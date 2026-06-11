# Connect to the OpenPrescribing BigQuery database

Authenticates with BigQuery using a service account credentials file and
returns a database connection. The path to the credentials file is read
from an environment variable (by default `OP_CREDENTIALS`), so
credentials never need to be hardcoded in analysis scripts.

## Usage

``` r
connect_bq(
  project = "ebmdatalab",
  dataset = "hscic",
  billing = "ebmdatalab",
  credentials_var = "OP_CREDENTIALS",
  quiet = FALSE
)
```

## Arguments

- project:

  Character, the BigQuery project. Default `"ebmdatalab"`.

- dataset:

  Character, the BigQuery dataset to connect to. Default `"hscic"`.

- billing:

  Character, the BigQuery project to bill. Default `"ebmdatalab"`.

- credentials_var:

  Character, the name of the environment variable that holds the path to
  your BigQuery credentials JSON file. Default `"OP_CREDENTIALS"`.

- quiet:

  Logical, suppress informational messages. Default `FALSE`.

## Value

A `DBIConnection` to BigQuery that can be used with
[`DBI::dbGetQuery()`](https://dbi.r-dbi.org/reference/dbGetQuery.html),
[`dplyr::tbl()`](https://dplyr.tidyverse.org/reference/tbl.html), and
the `get_*()` functions in this package.

## Details

See
[`vignette("connect-bigquery", package = "opr")`](https://bennettoxford.github.io/opr/articles/connect-bigquery.md)
for how to get credentials and set up the environment variable.

## Examples

``` r
if (FALSE) { # \dontrun{
con <- connect_bq()

# List all available tables
DBI::dbListTables(con)

# Disconnect when done
DBI::dbDisconnect(con)
} # }
```
