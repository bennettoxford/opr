#' Get practices
#'
#' Queries the `practices` table, with options to add descriptive labels for
#' the `setting` and `status_code` columns and to filter by those columns.
#' Labels are defined in the [practice_settings] and [practice_statuses]
#' lookup tables.
#'
#' The result is a query, not data: nothing is downloaded until you call
#' [dplyr::collect()], and you can add further `dplyr` steps first.
#'
#' @param con A BigQuery connection from [connect_bq()].
#' @param add_setting_labels Logical, add a `setting_label` column describing
#' the practice setting code. Default `FALSE`.
#' @param filter_setting Integer vector of setting codes to keep, e.g. `4` for
#' standard GP practices. Default `NULL` (no filter). See [practice_settings].
#' @param add_status_code_labels Logical, add a `status_code_label` column
#' describing the practice status code. Default `FALSE`.
#' @param filter_status_code Character vector of status codes to keep, e.g.
#' `"A"` for active practices. Default `NULL` (no filter). See [practice_statuses].
#'
#' @return A query (`tbl`) of the `practices` table, to be downloaded with
#' [dplyr::collect()].
#'
#' @export
#' @examples
#' \dontrun{
#' con <- connect_bq()
#'
#' # All practices, unfiltered
#' get_practices(con)
#'
#' # Standard GP practices with labels, downloaded into R
#' gp_practices <- get_practices(
#'   con,
#'   add_setting_labels = TRUE,
#'   filter_setting = 4
#' ) |>
#'   dplyr::collect()
#' }
get_practices <- function(
  con,
  add_setting_labels = FALSE,
  filter_setting = NULL,
  add_status_code_labels = FALSE,
  filter_status_code = NULL
) {
  query <- dplyr::tbl(con, "practices")

  if (add_setting_labels) {
    query <- add_lookup_label(
      query,
      practice_settings,
      "setting",
      "setting_label"
    )
  }

  if (add_status_code_labels) {
    query <- add_lookup_label(
      query,
      practice_statuses,
      "status_code",
      "status_code_label"
    )
  }

  if (!is.null(filter_setting)) {
    query <- dplyr::filter(query, .data$setting %in% !!filter_setting)
  }

  if (!is.null(filter_status_code)) {
    query <- dplyr::filter(query, .data$status_code %in% !!filter_status_code)
  }

  query
}
