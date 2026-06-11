# In-memory duckdb connection with small fixture versions of the BigQuery
# tables, so the get_*() functions can be tested end-to-end without
# credentials. Values are made up, except setting and status_code, which must
# exist in the lookup tables for the label tests — plus one of each (99, "X")
# deliberately missing from them to test unmatched labels.
local_test_con <- function(env = parent.frame()) {
  skip_if_not_installed("duckdb")

  con <- DBI::dbConnect(duckdb::duckdb())
  withr::defer(DBI::dbDisconnect(con, shutdown = TRUE), envir = env)

  practices <- tibble::tibble(
    code = c("P1", "P2", "P3", "P4"),
    name = c("Practice 1", "Practice 2", "Practice 3", "Practice 4"),
    setting = c(4L, 4L, 99L, 2L),
    status_code = c("A", "C", "A", "X")
  )

  normalised_prescribing <- tibble::tibble(
    practice = c("P1", "P1", "P2", "P2"),
    bnf_code = c("100", "200", "100", "300"),
    bnf_name = c("Drug A", "Drug B", "Drug A", "Drug C"),
    items = 1:4,
    month = as.POSIXct(
      c("2023-01-01", "2023-02-01", "2023-03-01", "2023-04-01"),
      tz = "UTC"
    )
  )

  DBI::dbWriteTable(con, "practices", practices)
  DBI::dbWriteTable(con, "normalised_prescribing", normalised_prescribing)

  con
}
