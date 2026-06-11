# Practice status codes and labels

Lookup table mapping practice `status_code` values to descriptive
labels, e.g. `"A"` is an active practice. Used by
[`get_practices()`](https://bennettoxford.github.io/opr/reference/get_practices.md)
to add the `status_code_label` column.

## Usage

``` r
practice_statuses
```

## Format

A tibble with 6 rows and 2 columns:

- status_code:

  Single-letter status code

- status_code_label:

  Descriptive label

## Examples

``` r
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
