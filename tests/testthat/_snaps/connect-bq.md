# connect_bq errors helpfully when the env variable is not set

    Code
      connect_bq()
    Condition
      Error in `connect_bq()`:
      ! Environment variable `OP_CREDENTIALS` is not set.
      i Set it in your '.Renviron' file to point to your BigQuery credentials JSON file.
      i You can edit your '.Renviron' file using `usethis::edit_r_environ()`.
      i See `vignette("connect-bigquery", package = "opr")` for detailed setup instructions.

# connect_bq errors helpfully when the credentials file is missing

    Code
      connect_bq()
    Condition
      Error in `connect_bq()`:
      ! Credentials file not found at '/nonexistent/bq-credentials.json'.
      i The `OP_CREDENTIALS` environment variable is set, but the file does not exist.
      i Check the path in your '.Renviron' file.

