#' Connect to the OpenPrescribing BigQuery database
#'
#' Authenticates with BigQuery using a service account credentials file and
#' returns a database connection. The path to the credentials file is read
#' from an environment variable (by default `OP_CREDENTIALS`), so credentials
#' never need to be hardcoded in analysis scripts.
#'
#' See `vignette("connect-bigquery", package = "opr")` for how to get
#' credentials and set up the environment variable.
#'
#' @param project Character, the BigQuery project. Default `"ebmdatalab"`.
#' @param dataset Character, the BigQuery dataset to connect to. Default `"hscic"`.
#' @param billing Character, the BigQuery project to bill. Default `"ebmdatalab"`.
#' @param credentials_var Character, the name of the environment variable that
#' holds the path to your BigQuery credentials JSON file. Default `"OP_CREDENTIALS"`.
#' @param quiet Logical, suppress informational messages. Default `FALSE`.
#'
#' @return A `DBIConnection` to BigQuery that can be used with [DBI::dbGetQuery()],
#' [dplyr::tbl()], and the `get_*()` functions in this package.
#'
#' @export
#' @examples
#' \dontrun{
#' con <- connect_bq()
#'
#' # List all available tables
#' DBI::dbListTables(con)
#'
#' # Disconnect when done
#' DBI::dbDisconnect(con)
#' }
connect_bq <- function(
  project = "ebmdatalab",
  dataset = "hscic",
  billing = "ebmdatalab",
  credentials_var = "OP_CREDENTIALS",
  quiet = FALSE
) {
  credentials_path <- Sys.getenv(credentials_var)

  if (credentials_path == "") {
    cli::cli_abort(c(
      "Environment variable {.envvar {credentials_var}} is not set.",
      "i" = "Set it in your {.file .Renviron} file to point to your BigQuery credentials JSON file.",
      "i" = "You can edit your {.file .Renviron} file using {.run usethis::edit_r_environ()}.",
      "i" = "See {.code vignette(\"connect-bigquery\", package = \"opr\")} for detailed setup instructions."
    ))
  }

  if (!file.exists(credentials_path)) {
    cli::cli_abort(c(
      "Credentials file not found at {.path {credentials_path}}.",
      "i" = "The {.envvar {credentials_var}} environment variable is set, but the file does not exist.",
      "i" = "Check the path in your {.file .Renviron} file."
    ))
  }

  if (!quiet) {
    cli::cli_alert_info("Authenticating with BigQuery ...")
  }
  bigrquery::bq_auth(path = credentials_path)

  con <- DBI::dbConnect(
    bigrquery::bigquery(),
    project = project,
    dataset = dataset,
    billing = billing
  )

  if (!quiet) {
    cli::cli_alert_success(
      "Connected to project {.val {project}}, dataset {.val {dataset}}."
    )
  }

  con
}
