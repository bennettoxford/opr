# Database schema

``` r

library(opr)
```

This vignette describes the main tables used for research projects. The
`hscic` dataset has many more tables (around 194); to list them all,
run:

``` r

con <- connect_bq()
DBI::dbListTables(con)
```

Each table below comes with a five-row sample bundled in the package
(for example `practices_sample`), so you can look at the data without a
BigQuery connection.

## `normalised_prescribing`

A cleaned-up version of the main prescribing dataset, updated monthly.
This is the table you will usually want, rather than the raw prescribing
table. Query it with
[`get_normalised_prescribing()`](https://bennettoxford.github.io/opr/reference/get_normalised_prescribing.md).

| Column | Description |
|----|----|
| `sha` | Strategic Health Authority code (e.g. QHM) |
| `regional_team` | Regional team code (e.g. Y63) |
| `stp` | Sustainability and Transformation Partnership code (e.g. QHM) |
| `pct` | Primary Care Trust code (e.g. 16C) |
| `practice` | Practice code (e.g. A81001) |
| `bnf_code` | British National Formulary (BNF) code (e.g. 0408010W0BBAKA1) |
| `bnf_name` | British National Formulary (BNF) drug name (e.g. Epilim Chrono 300 tablets) |
| `items` | Number of items (one item = one appearance on a prescription) |
| `net_cost` | Cost according to the Drug Tariff |
| `actual_cost` | Actual cost after adjustments for bulk purchases, out of pocket expenses, etc. This is the cost field usually used in analyses |
| `quantity` | Number of pills/grams/millilitres/dressings/ampoules prescribed |
| `month` | Prescribing month |

``` r

normalised_prescribing_sample
#> # A tibble: 5 × 12
#>   sha   regional_team stp   pct   practice bnf_code      bnf_name items net_cost
#>   <chr> <chr>         <chr> <chr> <chr>    <chr>         <chr>    <int>    <dbl>
#> 1 Q44   Y62           QYG   12F   N85625   0302000ABBBA… Fostair…    30    880. 
#> 2 Q44   Y62           QYG   02E   N81089   0401020K0AAA… Diazepa…    63     48.8
#> 3 Q44   Y62           QYG   12F   N85012   0302000K0BHA… DuoResp…    33   1079. 
#> 4 Q44   Y62           QYG   27D   Y03882   23804708006   Proshie…    55    449. 
#> 5 Q44   Y62           QYG   12F   N85054   0205052N0AAA… Losarta…    22     33.3
#> # ℹ 3 more variables: actual_cost <dbl>, quantity <dbl>, month <dttm>
```

## `practices`

GP practice details including addresses and organisational information,
updated monthly. Contains the latest month’s data only, but includes
closed practices. Query it with
[`get_practices()`](https://bennettoxford.github.io/opr/reference/get_practices.md).

| Column | Description |
|----|----|
| `code` | Practice code (e.g. E82084) |
| `name` | Practice name (e.g. HATFIELD ROAD SURGERY) |
| `address1` to `address5` | Address lines |
| `postcode` | Practice postcode (e.g. AL1 3HD) |
| `location` | Location of the practice in WGS84 format |
| `ccg_id` | Clinical Commissioning Group identifier (e.g. 06N) |
| `pcn_id` | Primary Care Network identifier (e.g. U73966) |
| `setting` | Practice setting code, e.g. 4 = GP Practice. See `practice_settings` for all codes |
| `close_date` | Date the practice closed |
| `join_provider_date` | Date the practice joined its CCG |
| `leave_provider_date` | Date the practice left its CCG (or closed) |
| `open_date` | Date the practice opened |
| `status_code` | Practice status code, e.g. A = Active. See `practice_statuses` for all codes |

``` r

practices_sample
#> # A tibble: 5 × 17
#>   code   name     address1 address2 address3 address4 address5 postcode location
#>   <chr>  <chr>    <chr>    <chr>    <chr>    <chr>    <chr>    <chr>    <chr>   
#> 1 A81001 THE DEN… HEALTH … LAWSON … NA       STOCKTO… NA       TS18 1HU 0101000…
#> 2 A81002 QUEENS … FARRER … NA       NA       STOCKTO… NA       TS18 2AW 0101000…
#> 3 A81003 VICTORI… HEALTH … VICTORI… NA       HARTLEP… NA       TS26 8DB 0101000…
#> 4 A81004 ACKLAM … TRIMDON… ACKLAM   NA       MIDDLES… NA       TS5 8SB  0101000…
#> 5 A81005 SPRINGW… RECTORY… NA       NA       GUISBOR… NA       TS14 7DJ 0101000…
#> # ℹ 8 more variables: ccg_id <chr>, pcn_id <chr>, setting <int>,
#> #   close_date <chr>, join_provider_date <chr>, leave_provider_date <chr>,
#> #   open_date <chr>, status_code <chr>
```

## `practice_statistics`

Practice-level patient counts by age and gender, updated monthly.
Contains the latest month’s data only. Also contains population
weightings used to compare prescribing across practices with different
patient populations (STAR-PU and ASTRO-PU).

| Column | Description |
|----|----|
| `month` | The month the statistics were recorded |
| `male_0_4` to `female_75_plus` | Count of patients by gender and age band (e.g. `male_0_4` is the number of male patients aged 0 to 4) |
| `total_list_size` | Total number of patients registered at the practice |
| `astro_pu_cost` | ASTRO-PU (Age, Sex, and Temporary Resident Originated Prescribing Units) cost weighting |
| `astro_pu_items` | ASTRO-PU items weighting |
| `star_pu` | STAR-PU (Specific Therapeutic group Age-sex Related Prescribing Units) weightings, stored as JSON |
| `pct_id` | Primary Care Trust identifier (e.g. 08G) |
| `practice` | Practice code (e.g. E86005) |

``` r

practice_statistics_sample
#> # A tibble: 5 × 25
#>   month               male_0_4 female_0_4 male_5_14 male_15_24 male_25_34
#>   <dttm>                 <int>      <int>     <int>      <int>      <int>
#> 1 2017-07-01 00:00:00       12         12        27         45         81
#> 2 2017-07-01 00:00:00      106         67       172        177        374
#> 3 2017-07-01 00:00:00      145        159       442        436        478
#> 4 2017-07-01 00:00:00      224        206       510        395        723
#> 5 2017-07-01 00:00:00      288        222       700        465        738
#> # ℹ 19 more variables: male_35_44 <int>, male_45_54 <int>, male_55_64 <int>,
#> #   male_65_74 <int>, male_75_plus <int>, female_5_14 <int>,
#> #   female_15_24 <int>, female_25_34 <int>, female_35_44 <int>,
#> #   female_45_54 <int>, female_55_64 <int>, female_65_74 <int>,
#> #   female_75_plus <int>, total_list_size <int>, astro_pu_cost <dbl>,
#> #   astro_pu_items <dbl>, star_pu <chr>, pct_id <chr>, practice <chr>
```

## `regional_teams`

Names and open/close dates for regional teams.

| Column | Description |
|----|----|
| `code` | Regional team code (e.g. Y57) |
| `name` | Regional team name (e.g. SOUTH OF ENGLAND COMMISSIONING REGION) |
| `open_date` | Date the regional team opened |
| `close_date` | Date the regional team closed, `NA` if still open |

``` r

regional_teams_sample
#> # A tibble: 5 × 4
#>   code  name                                              open_date  close_date
#>   <chr> <chr>                                             <date>     <date>    
#> 1 Y54   NORTH OF ENGLAND COMMISSIONING REGION             2012-10-01 2019-03-31
#> 2 Y55   MIDLANDS AND EAST OF ENGLAND COMMISSIONING REGION 2012-10-01 2019-03-31
#> 3 Y56   LONDON COMMISSIONING REGION                       2012-10-01 NA        
#> 4 Y57   SOUTH OF ENGLAND COMMISSIONING REGION             2012-10-01 2018-03-31
#> 5 Y58   SOUTH WEST COMMISSIONING REGION                   2018-04-01 NA
```

## How the tables join together

- `normalised_prescribing$practice` matches `practices$code`
- `normalised_prescribing$regional_team` matches `regional_teams$code`
- `practice_statistics$practice` matches `practices$code`

See the “Joining tables” section of
[`vignette("opr")`](https://bennettoxford.github.io/opr/articles/opr.md)
for a worked example.
