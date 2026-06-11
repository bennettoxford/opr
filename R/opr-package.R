#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @importFrom rlang .data :=
# dbplyr is only used indirectly (dplyr::tbl on a DBI connection); importing
# sql() keeps R CMD check from flagging it as an unused dependency.
#' @importFrom dbplyr sql
#' @importFrom utils globalVariables
## usethis namespace: end
NULL

# Lookup tables shipped in data/ are lazy-loaded into the namespace and used
# by get_practices(), which R CMD check cannot see.
globalVariables(c("practice_settings", "practice_statuses"))
