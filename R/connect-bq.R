#' Connect to BigQuery
connect_bq <- function(
  project = "ebmdatalab",
  dataset = "hscic",
  billing = "ebmdatalab",
  credentials_var = "OP_CREDENTIALS"
) {
  # Get the credentials path from environment variable
  credentials_path <- Sys.getenv(credentials_var)

  # Check if environment variable is set
  if (credentials_path == "") {
    cli::cli_abort(c(
      paste("Environment variable", credentials_var, "is not set."),
      "i" = "Please set it in your .Renviron file to point to your BigQuery credentials JSON file.",
      "i" = "You can edit your .Renviron file using: usethis::edit_r_environ()",
      "i" = "See chapters/connect-bq.qmd for detailed setup instructions."
    ))
  }

  # Check if the credentials file exists
  if (!file.exists(credentials_path)) {
    cli::cli_abort(c(
      paste("Credentials file not found at:", credentials_path),
      "i" = paste(
        "The",
        credentials_var,
        "environment variable is set, but the file does not exist."
      ),
      "i" = "Please check the path in your .Renviron file."
    ))
  }

  # Authenticate with BigQuery
  cli::cli_alert_info("Authenticating with BigQuery ...")
  bigrquery::bq_auth(path = credentials_path)

  # Connect to BigQuery
  cli::cli_alert_info(paste0(
    "Connecting to project ",
    project,
    ", dataset ",
    dataset
  ))

  con <- DBI::dbConnect(
    bigrquery::bigquery(),
    project = project,
    dataset = dataset,
    billing = billing
  )

  cli::cli_alert_success("Successfully connected to BigQuery!")
  invisible(con)
}
