# Practice setting codes and labels

Lookup table mapping practice `setting` codes to descriptive labels,
e.g. setting `4` is a standard GP practice. Used by
[`get_practices()`](https://bennettoxford.github.io/opr/reference/get_practices.md)
to add the `setting_label` column.

## Usage

``` r
practice_settings
```

## Format

A tibble with 24 rows and 2 columns:

- setting:

  Integer setting code

- setting_label:

  Descriptive label

## Examples

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
```
