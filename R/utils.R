# Add a label column to a lazy query from a lookup tibble, e.g. setting ->
# setting_label. Builds a case_when() so the labelling happens in SQL and
# works on read-only connections (a join with copy = TRUE would need
# permission to create temporary tables).
add_lookup_label <- function(query, lookup, code_col, label_col) {
  code_sym <- rlang::sym(code_col)
  cases <- lapply(seq_len(nrow(lookup)), function(i) {
    rlang::expr(
      !!code_sym == !!lookup[[code_col]][[i]] ~ !!lookup[[label_col]][[i]]
    )
  })
  dplyr::mutate(
    query,
    !!rlang::sym(label_col) := dplyr::case_when(!!!cases)
  )
}

# Validate a single date argument, accepting Date or "YYYY-MM-DD" strings.
# Returns NULL unchanged so optional filters can be skipped.
check_date <- function(
  x,
  arg = rlang::caller_arg(x),
  call = rlang::caller_env()
) {
  if (is.null(x)) {
    return(NULL)
  }
  date <- tryCatch(as.Date(x), error = function(e) as.Date(NA))
  if (length(date) != 1 || is.na(date)) {
    cli::cli_abort(
      "{.arg {arg}} must be a single date or {.val YYYY-MM-DD} string, not {.val {x}}.",
      call = call
    )
  }
  date
}
