# opr: OpenPrescribing in R

The `opr` package helps researchers access and analyse the
[OpenPrescribing.net](https://openprescribing.net/) BigQuery database in
R. Instead of writing SQL, you can use
[`dplyr`](https://dplyr.tidyverse.org/).

## Installation

You can install the development version of `opr` from GitHub:

``` r

# install.packages("pak")
pak::pak("bennettoxford/opr")
```

## Usage

You’ll need BigQuery credentials, see [Connect to
BigQuery](https://bennettoxford.github.io/opr/articles/connect-bigquery.html)
for setup instructions.

``` r

library(opr)
library(dplyr)

con <- connect_bq()

# Standard GP practices (setting code 4) with descriptive labels
get_practices(con, filter_setting = 4, add_setting_labels = TRUE) |>
  collect()

# Prescribing of metformin 500mg MR tablets in early 2023
get_normalised_prescribing(
  con,
  bnf_codes = "0601022B0AAASAS",
  start_date = "2023-01-01",
  end_date = "2023-03-01"
) |>
  collect()
```

The `get_*()` functions return a query that runs in BigQuery; nothing is
downloaded until you call
[`collect()`](https://dplyr.tidyverse.org/reference/compute.html). See
[Getting started](https://bennettoxford.github.io/opr/articles/opr.html)
for more details.

## For developers

See [DEVELOPERS.md](https://bennettoxford.github.io/opr/DEVELOPERS.md).
