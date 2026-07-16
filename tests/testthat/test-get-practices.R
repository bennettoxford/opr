test_that("get_practices returns all rows by default", {
  con <- local_test_con()
  df <- get_practices(con) |> dplyr::collect()
  expect_equal(nrow(df), 4)
  expect_false("setting_label" %in% names(df))
  expect_false("status_code_label" %in% names(df))
})

test_that("get_practices filters by setting", {
  con <- local_test_con()
  df <- get_practices(con, filter_setting = 4) |> dplyr::collect()
  expect_equal(sort(df$code), c("P1", "P2"))

  df <- get_practices(con, filter_setting = c(2, 4)) |> dplyr::collect()
  expect_equal(nrow(df), 3)
})

test_that("get_practices filters by status_code", {
  con <- local_test_con()
  df <- get_practices(con, filter_status_code = "A") |> dplyr::collect()
  expect_equal(sort(df$code), c("P1", "P3"))
})

test_that("get_practices adds setting labels, NA for unknown codes", {
  con <- local_test_con()
  df <- get_practices(con, add_setting_labels = TRUE) |>
    dplyr::collect() |>
    dplyr::arrange(code)
  expect_equal(
    df$setting_label,
    c("GP Practice", "GP Practice", NA, "OOH Practice")
  )
})

test_that("get_practices adds status code labels, NA for unknown codes", {
  con <- local_test_con()
  df <- get_practices(con, add_status_code_labels = TRUE) |>
    dplyr::collect() |>
    dplyr::arrange(code)
  expect_equal(df$status_code_label, c("Active", "Closed", "Active", NA))
})

test_that("get_practices composes with further dplyr verbs", {
  con <- local_test_con()
  df <- get_practices(con, add_setting_labels = TRUE, filter_setting = 4) |>
    dplyr::select(code, setting_label) |>
    dplyr::collect()
  expect_named(df, c("code", "setting_label"))
  expect_equal(nrow(df), 2)
})

test_that("add_lookup_label generates a CASE WHEN in SQL", {
  # Match identifiers with "." so the test passes whichever quoting style
  # (backticks or double quotes) the installed dbplyr version renders
  lf <- dbplyr::lazy_frame(
    setting = integer(),
    con = dbplyr::simulate_dbi()
  )
  sql <- add_lookup_label(lf, practice_settings, "setting", "setting_label") |>
    dbplyr::sql_render() |>
    as.character()
  expect_match(sql, "CASE")
  expect_match(sql, "WHEN \\(.setting. = 4\\) THEN 'GP Practice'")
  expect_match(sql, "END AS .setting_label.")
  expect_length(gregexpr("WHEN ", sql)[[1]], nrow(practice_settings))
})
