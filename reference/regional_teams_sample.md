# Sample of the regional_teams table

The first five rows (ordered by code) from the `regional_teams` table,
bundled so that examples and vignettes run without a BigQuery
connection. Column descriptions are in
[`vignette("database-schema", package = "opr")`](https://bennettoxford.github.io/opr/articles/database-schema.md).

## Usage

``` r
regional_teams_sample
```

## Format

A tibble with 5 rows and 4 columns.

## Source

OpenPrescribing BigQuery database, `hscic.regional_teams`.

## Examples

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
