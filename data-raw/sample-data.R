# Fetch 5-row samples of the main OpenPrescribing tables so that examples,
# tests, and vignettes run without a BigQuery connection.
# Requires the OP_CREDENTIALS environment variable. Re-run with: just build-data

devtools::load_all()

con <- connect_bq()

practices_sample <- get_practices(con, filter_setting = 4) |>
  dplyr::arrange(code) |>
  head(5) |>
  dplyr::collect()

normalised_prescribing_sample <- dplyr::tbl(con, "normalised_prescribing") |>
  head(5) |>
  dplyr::collect()

practice_statistics_sample <- dplyr::tbl(con, "practice_statistics") |>
  head(5) |>
  dplyr::collect()

regional_teams_sample <- dplyr::tbl(con, "regional_teams") |>
  dplyr::arrange(code) |>
  head(5) |>
  dplyr::collect()

DBI::dbDisconnect(con)

usethis::use_data(
  practices_sample,
  normalised_prescribing_sample,
  practice_statistics_sample,
  regional_teams_sample,
  overwrite = TRUE
)
