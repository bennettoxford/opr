#' Practice setting codes and labels
#'
#' Lookup table mapping practice `setting` codes to descriptive labels,
#' e.g. setting `4` is a standard GP practice. Used by [get_practices()]
#' to add the `setting_label` column.
#'
#' @format A tibble with `r nrow(practice_settings)` rows and 2 columns:
#' \describe{
#'   \item{setting}{Integer setting code}
#'   \item{setting_label}{Descriptive label}
#' }
#' @examples
#' practice_settings
"practice_settings"

#' Practice status codes and labels
#'
#' Lookup table mapping practice `status_code` values to descriptive labels,
#' e.g. `"A"` is an active practice. Used by [get_practices()] to add the
#' `status_code_label` column.
#'
#' @format A tibble with `r nrow(practice_statuses)` rows and 2 columns:
#' \describe{
#'   \item{status_code}{Single-letter status code}
#'   \item{status_code_label}{Descriptive label}
#' }
#' @examples
#' practice_statuses
"practice_statuses"

#' Sample of the practices table
#'
#' The first five GP practices (setting 4, ordered by practice code) from the
#' `practices` table, bundled so that examples and vignettes run without a
#' BigQuery connection. Column descriptions are in
#' `vignette("database-schema", package = "opr")`.
#'
#' @format A tibble with 5 rows and `r ncol(practices_sample)` columns.
#' @source OpenPrescribing BigQuery database, `hscic.practices`.
#' @seealso [get_practices()]
#' @examples
#' practices_sample
"practices_sample"

#' Sample of the normalised_prescribing table
#'
#' Five rows from the `normalised_prescribing` table, bundled so that examples
#' and vignettes run without a BigQuery connection. Column descriptions are in
#' `vignette("database-schema", package = "opr")`.
#'
#' @format A tibble with 5 rows and `r ncol(normalised_prescribing_sample)` columns.
#' @source OpenPrescribing BigQuery database, `hscic.normalised_prescribing`.
#' @seealso [get_normalised_prescribing()]
#' @examples
#' normalised_prescribing_sample
"normalised_prescribing_sample"

#' Sample of the practice_statistics table
#'
#' Five rows from the `practice_statistics` table, bundled so that examples
#' and vignettes run without a BigQuery connection. Column descriptions are in
#' `vignette("database-schema", package = "opr")`.
#'
#' @format A tibble with 5 rows and `r ncol(practice_statistics_sample)` columns.
#' @source OpenPrescribing BigQuery database, `hscic.practice_statistics`.
#' @examples
#' practice_statistics_sample
"practice_statistics_sample"

#' Sample of the regional_teams table
#'
#' The first five rows (ordered by code) from the `regional_teams` table,
#' bundled so that examples and vignettes run without a BigQuery connection.
#' Column descriptions are in `vignette("database-schema", package = "opr")`.
#'
#' @format A tibble with 5 rows and `r ncol(regional_teams_sample)` columns.
#' @source OpenPrescribing BigQuery database, `hscic.regional_teams`.
#' @examples
#' regional_teams_sample
"regional_teams_sample"
