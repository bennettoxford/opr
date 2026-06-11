# Get practices

Queries the `practices` table, with options to add descriptive labels
for the `setting` and `status_code` columns and to filter by those
columns. Labels are defined in the
[practice_settings](https://bennettoxford.github.io/opr/reference/practice_settings.md)
and
[practice_statuses](https://bennettoxford.github.io/opr/reference/practice_statuses.md)
lookup tables.

## Usage

``` r
get_practices(
  con,
  add_setting_labels = FALSE,
  filter_setting = NULL,
  add_status_code_labels = FALSE,
  filter_status_code = NULL
)
```

## Arguments

- con:

  A BigQuery connection from
  [`connect_bq()`](https://bennettoxford.github.io/opr/reference/connect_bq.md).

- add_setting_labels:

  Logical, add a `setting_label` column describing the practice setting
  code. Default `FALSE`.

- filter_setting:

  Integer vector of setting codes to keep, e.g. `4` for standard GP
  practices. Default `NULL` (no filter). See
  [practice_settings](https://bennettoxford.github.io/opr/reference/practice_settings.md).

- add_status_code_labels:

  Logical, add a `status_code_label` column describing the practice
  status code. Default `FALSE`.

- filter_status_code:

  Character vector of status codes to keep, e.g. `"A"` for active
  practices. Default `NULL` (no filter). See
  [practice_statuses](https://bennettoxford.github.io/opr/reference/practice_statuses.md).

## Value

A query (`tbl`) of the `practices` table, to be downloaded with
[`dplyr::collect()`](https://dplyr.tidyverse.org/reference/compute.html).

## Details

The result is a query, not data: nothing is downloaded until you call
[`dplyr::collect()`](https://dplyr.tidyverse.org/reference/compute.html),
and you can add further `dplyr` steps first.

## Examples

``` r
if (FALSE) { # \dontrun{
con <- connect_bq()

# All practices, unfiltered
get_practices(con)

# Standard GP practices with labels, downloaded into R
gp_practices <- get_practices(
  con,
  add_setting_labels = TRUE,
  filter_setting = 4
) |>
  dplyr::collect()
} # }
```
