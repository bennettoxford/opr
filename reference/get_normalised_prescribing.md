# Get normalised prescribing

Queries the `normalised_prescribing` table, with optional filtering by
BNF codes and prescribing month. This is the table you'll usually want,
rather than the raw prescribing table.

## Usage

``` r
get_normalised_prescribing(
  con,
  bnf_codes = NULL,
  start_date = NULL,
  end_date = NULL
)
```

## Arguments

- con:

  A BigQuery connection from
  [`connect_bq()`](https://bennettoxford.github.io/opr/reference/connect_bq.md).

- bnf_codes:

  Character vector of BNF codes to keep, e.g. `"0601022B0AAASAS"`. `%`
  anywhere in a code is a wildcard matching any characters, so
  `"0404000M0%"` keeps all methylphenidate presentations. Default `NULL`
  (no filter).

- start_date:

  Earliest prescribing month to keep, as a `Date` or `"YYYY-MM-DD"`
  string. Default `NULL` (no filter).

- end_date:

  Latest prescribing month to keep, as a `Date` or `"YYYY-MM-DD"`
  string. Default `NULL` (no filter).

## Value

A query (`tbl`) of the `normalised_prescribing` table, to be downloaded
with
[`dplyr::collect()`](https://dplyr.tidyverse.org/reference/compute.html).

## Details

The result is a query, not data: nothing is downloaded until you call
[`dplyr::collect()`](https://dplyr.tidyverse.org/reference/compute.html),
and you can add further `dplyr` steps first. The full table is very
large, so filter by BNF code and date range before collecting.

## Examples

``` r
if (FALSE) { # \dontrun{
con <- connect_bq()

# Prescribing of two presentations between January and March 2023
get_normalised_prescribing(
  con,
  bnf_codes = c("0408010W0BBAKA1", "0601022B0AAASAS"),
  start_date = "2023-01-01",
  end_date = "2023-03-01"
) |>
  dplyr::collect()

# Prescribing of all methylphenidate presentations, using a wildcard
get_normalised_prescribing(
  con,
  bnf_codes = "0404000M0%",
  start_date = "2023-01-01",
  end_date = "2023-03-01"
) |>
  dplyr::collect()
} # }
```
