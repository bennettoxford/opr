#' Get normalised prescribing
#'
#' Queries the `normalised_prescribing` table, with optional filtering by
#' BNF codes and prescribing month. This is the table you'll usually want,
#' rather than the raw prescribing table.
#'
#' The result is a query, not data: nothing is downloaded until you call
#' [dplyr::collect()], and you can add further `dplyr` steps first. The full
#' table is very large, so filter by BNF code and date range before
#' collecting.
#'
#' @param con A BigQuery connection from [connect_bq()].
#' @param bnf_codes Character vector of BNF codes to keep, e.g.
#' `"0601022B0AAASAS"`. Default `NULL` (no filter).
#' @param start_date Earliest prescribing month to keep, as a `Date` or
#' `"YYYY-MM-DD"` string. Default `NULL` (no filter).
#' @param end_date Latest prescribing month to keep, as a `Date` or
#' `"YYYY-MM-DD"` string. Default `NULL` (no filter).
#'
#' @return A query (`tbl`) of the `normalised_prescribing` table, to be
#' downloaded with [dplyr::collect()].
#'
#' @export
#' @examples
#' \dontrun{
#' con <- connect_bq()
#'
#' # Prescribing of two presentations between January and March 2023
#' get_normalised_prescribing(
#'   con,
#'   bnf_codes = c("0408010W0BBAKA1", "0601022B0AAASAS"),
#'   start_date = "2023-01-01",
#'   end_date = "2023-03-01"
#' ) |>
#'   dplyr::collect()
#' }
get_normalised_prescribing <- function(
  con,
  bnf_codes = NULL,
  start_date = NULL,
  end_date = NULL
) {
  start_date <- check_date(start_date)
  end_date <- check_date(end_date)

  if (!is.null(start_date) && !is.null(end_date) && start_date > end_date) {
    cli::cli_abort(
      "{.arg start_date} ({.val {start_date}}) must not be after {.arg end_date} ({.val {end_date}})."
    )
  }

  query <- dplyr::tbl(con, "normalised_prescribing")

  if (!is.null(bnf_codes)) {
    query <- dplyr::filter(query, .data$bnf_code %in% !!bnf_codes)
  }

  if (!is.null(start_date)) {
    query <- dplyr::filter(query, .data$month >= !!start_date)
  }

  if (!is.null(end_date)) {
    query <- dplyr::filter(query, .data$month <= !!end_date)
  }

  query
}
