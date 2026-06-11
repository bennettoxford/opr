# Sample of the practice_statistics table

Five rows from the `practice_statistics` table, bundled so that examples
and vignettes run without a BigQuery connection. Column descriptions are
in
[`vignette("database-schema", package = "opr")`](https://bennettoxford.github.io/opr/articles/database-schema.md).

## Usage

``` r
practice_statistics_sample
```

## Format

A tibble with 5 rows and 25 columns.

## Source

OpenPrescribing BigQuery database, `hscic.practice_statistics`.

## Examples

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
