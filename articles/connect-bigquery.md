# Connect to BigQuery

This guide walks you through getting access to the OpenPrescribing
BigQuery database and connecting to it from R with
[`connect_bq()`](https://bennettoxford.github.io/opr/reference/connect_bq.md).

## Get access

To get access to the OpenPrescribing BigQuery database write in any
public Slack channel and tag `@bigquery_admins`. One of the admins will
send you a JSON file with your BigQuery credentials in a private
message. The file should look something like this:

``` json
{
  "type": "ACCOUNT_TYPE",
  "project_id": "PROJECT_ID",
  "private_key_id": "PRIVATE_KEY_ID",
  "private_key": "PRIVATE_KEY",
  "client_email": "CLIENT_EMAIL",
  "client_id": "CLIENT_ID",
  "auth_uri": "AUTH_URI",
  "token_uri": "TOKEN_URI",
  "auth_provider_x509_cert_url": "AUTH_CERTIFICATE",
  "client_x509_cert_url": "CLIENT_CERTIFICATE",
  "universe_domain": "DOMAIN"
}
```

**Never commit this file to GitHub or share it with anyone.**

## Store your credentials

You can store this file anywhere on your computer, but a common location
is in a hidden folder in your home directory, for example:

**On macOS/Linux:**

``` bash
~/.config/openprescribing/bq-credentials.json
```

**On Windows:**

``` bash
C:/Users/YOUR_USERNAME/.config/openprescribing/bq-credentials.json
```

## Set up the environment variable

Rather than hardcoding the path in your R scripts you can set an
environment variable named `OP_CREDENTIALS`. To help you edit your
`.Renviron` file and set the variable for all R sessions you can use the
`usethis` package:

``` r

# Open your .Renviron file
usethis::edit_r_environ()
```

This will open your `.Renviron` file in your editor where you can add
the location where you stored your credentials file, for example:

``` bash
# macOS/Linux
OP_CREDENTIALS=~/.config/openprescribing/bq-credentials.json

# Windows
OP_CREDENTIALS=C:/Users/YOUR_USERNAME/.config/openprescribing/bq-credentials.json
```

**Note: You will probably need to restart your R session for R to know
about your new environment variable.**

## Connect from R

With the environment variable in place,
[`connect_bq()`](https://bennettoxford.github.io/opr/reference/connect_bq.md)
authenticates and connects to the `hscic` dataset in the `ebmdatalab`
project. You might be asked to log in with your Google account the first
time you run this.

``` r

library(opr)

con <- connect_bq()
```

You can connect to a different dataset, or use a differently named
environment variable, via the arguments:

``` r

con <- connect_bq(dataset = "dmd", credentials_var = "MY_OTHER_CREDENTIALS")
```

The connection works with everything in the `DBI` and `dplyr`/`dbplyr`
ecosystem, for example:

``` r

# List all available tables
DBI::dbListTables(con)

# Create a lazy query against any table
dplyr::tbl(con, "practices")
```

If something is not set up correctly,
[`connect_bq()`](https://bennettoxford.github.io/opr/reference/connect_bq.md)
will tell you what to fix, for example when the environment variable is
missing:

``` r

opr::connect_bq(credentials_var = "VARIABLE_THAT_IS_NOT_SET")
#> Error in `opr::connect_bq()`:
#> ! Environment variable `VARIABLE_THAT_IS_NOT_SET` is not set.
#> ℹ Set it in your .Renviron file to point to your BigQuery credentials JSON
#>   file.
#> ℹ You can edit your .Renviron file using `usethis::edit_r_environ()`.
#> ℹ See `vignette("connect-bigquery", package = "opr")` for detailed setup
#>   instructions.
```

## Next steps

See
[`vignette("opr")`](https://bennettoxford.github.io/opr/articles/opr.md)
for how to query the data with the `get_*()` functions, and
[`vignette("database-schema")`](https://bennettoxford.github.io/opr/articles/database-schema.md)
for descriptions of the main tables.
