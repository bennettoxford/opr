# Sample of the normalised_prescribing table

Five rows from the `normalised_prescribing` table, bundled so that
examples and vignettes run without a BigQuery connection. Column
descriptions are in
[`vignette("database-schema", package = "opr")`](https://bennettoxford.github.io/opr/articles/database-schema.md).

## Usage

``` r
normalised_prescribing_sample
```

## Format

A tibble with 5 rows and 12 columns.

## Source

OpenPrescribing BigQuery database, `hscic.normalised_prescribing`.

## See also

[`get_normalised_prescribing()`](https://bennettoxford.github.io/opr/reference/get_normalised_prescribing.md)

## Examples

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
