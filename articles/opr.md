# Getting started with opr

The `get_*()` functions in `opr` return a query, not data. The query
runs in BigQuery, and nothing is downloaded until you call
[`collect()`](https://dplyr.tidyverse.org/reference/compute.html). This
means you can keep adding `dplyr` steps like
[`filter()`](https://dplyr.tidyverse.org/reference/filter.html) and
[`select()`](https://dplyr.tidyverse.org/reference/select.html) first,
and only the (much smaller) result is downloaded.

``` r

library(opr)
library(dplyr)
```

The examples that query BigQuery are not run when this vignette is
built. To run them yourself you need access to the database, see
[`vignette("connect-bigquery")`](https://bennettoxford.github.io/opr/articles/connect-bigquery.md).

## Connect

``` r

con <- connect_bq()
```

## Get practices

[`get_practices()`](https://bennettoxford.github.io/opr/reference/get_practices.md)
queries the `practices` table, with options to add descriptive labels
for the `setting` and `status_code` columns and to filter by them. For a
description of the table see
[`vignette("database-schema")`](https://bennettoxford.github.io/opr/articles/database-schema.md),
or look at the bundled five-row sample:

``` r

practices_sample |>
  select(code, name, postcode, setting, status_code)
#> # A tibble: 5 × 5
#>   code   name                       postcode setting status_code
#>   <chr>  <chr>                      <chr>      <int> <chr>      
#> 1 A81001 THE DENSHAM SURGERY        TS18 1HU       4 A          
#> 2 A81002 QUEENS PARK MEDICAL CENTRE TS18 2AW       4 A          
#> 3 A81003 VICTORIA MEDICAL PRACTICE  TS26 8DB       4 B          
#> 4 A81004 ACKLAM MEDICAL CENTRE      TS5 8SB        4 A          
#> 5 A81005 SPRINGWOOD SURGERY         TS14 7DJ       4 A
```

The labels come from lookup tables shipped with the package:

``` r

practice_settings
#> # A tibble: 24 × 2
#>    setting setting_label           
#>      <int> <chr>                   
#>  1       0 Other                   
#>  2       1 WIC Practice            
#>  3       2 OOH Practice            
#>  4       3 WIC + OOH Practice      
#>  5       4 GP Practice             
#>  6       8 Public Health Service   
#>  7       9 Community Health Service
#>  8      10 Hospital Service        
#>  9      11 Optometry Service       
#> 10      12 Urgent & Emergency Care 
#> # ℹ 14 more rows

practice_statuses
#> # A tibble: 6 × 2
#>   status_code status_code_label
#>   <chr>       <chr>            
#> 1 A           Active           
#> 2 B           Retired          
#> 3 C           Closed           
#> 4 D           Dormant          
#> 5 P           Proposed         
#> 6 U           Unknown
```

For example, to get all standard GP practices (setting code 4) with
labels for setting and status codes:

``` r

get_practices(
  con,
  add_setting_labels = TRUE,
  filter_setting = 4,
  add_status_code_labels = TRUE
) |>
  select(code, name, setting_label, status_code_label) |>
  collect()
```

To see the SQL that will run in BigQuery, use
[`show_query()`](https://dplyr.tidyverse.org/reference/explain.html):

``` r

get_practices(con, add_setting_labels = TRUE, filter_setting = 4) |>
  select(code, name, setting_label) |>
  show_query()
```

## Get normalised prescribing

[`get_normalised_prescribing()`](https://bennettoxford.github.io/opr/reference/get_normalised_prescribing.md)
queries the `normalised_prescribing` table with optional filtering by
BNF codes and prescribing month. The full table is very large, so filter
before collecting. A sample of the table:

``` r

normalised_prescribing_sample |>
  select(month, practice, bnf_code, bnf_name, items, quantity)
#> # A tibble: 5 × 6
#>   month               practice bnf_code        bnf_name           items quantity
#>   <dttm>              <chr>    <chr>           <chr>              <int>    <dbl>
#> 1 2016-12-01 00:00:00 N85625   0302000ABBBAAAA Fostair NEXThaler…    30       30
#> 2 2016-12-01 00:00:00 N81089   0401020K0AAAHAH Diazepam 2mg tabl…    63     1822
#> 3 2016-12-01 00:00:00 N85012   0302000K0BHAAAM DuoResp Spiromax …    33       36
#> 4 2016-12-01 00:00:00 Y03882   23804708006     Proshield Foam & …    55    15980
#> 5 2016-12-01 00:00:00 N85054   0205052N0AAADAD Losartan 100mg ta…    22      896
```

In this example we get prescribing data for two BNF codes between
January and March 2023:

``` r

get_normalised_prescribing(
  con,
  bnf_codes = c("0408010W0BBAKA1", "0601022B0AAASAS"),
  start_date = "2023-01-01",
  end_date = "2023-03-01"
) |>
  collect()
```

## Joining tables

Joins also run in BigQuery before anything is downloaded. Here we join
prescribing data to GP practices and filter for metformin:

``` r

# Metformin 500mg modified-release tablets in March 2025
prescribing_query <- get_normalised_prescribing(
  con,
  bnf_codes = "0601022B0AAASAS",
  start_date = "2025-03-01",
  end_date = "2025-03-01"
) |>
  select(month, practice, bnf_code, bnf_name, items, quantity)

practices_query <- get_practices(con, filter_setting = 4) |>
  select(code, name, status_code)

prescribing_query |>
  inner_join(practices_query, by = c("practice" = "code")) |>
  collect()
```

## Other tables

The `get_*()` functions only cover the most commonly used tables. The
connection from
[`connect_bq()`](https://bennettoxford.github.io/opr/reference/connect_bq.md)
works with any table in the dataset:

``` r

dplyr::tbl(con, "practice_statistics")
```

And if you prefer writing SQL directly, that works too:

``` r

DBI::dbGetQuery(con, "SELECT code, name FROM practices LIMIT 5")
```
