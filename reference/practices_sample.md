# Sample of the practices table

The first five GP practices (setting 4, ordered by practice code) from
the `practices` table, bundled so that examples and vignettes run
without a BigQuery connection. Column descriptions are in
[`vignette("database-schema", package = "opr")`](https://bennettoxford.github.io/opr/articles/database-schema.md).

## Usage

``` r
practices_sample
```

## Format

A tibble with 5 rows and 17 columns.

## Source

OpenPrescribing BigQuery database, `hscic.practices`.

## See also

[`get_practices()`](https://bennettoxford.github.io/opr/reference/get_practices.md)

## Examples

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
