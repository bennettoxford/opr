test_that("get_normalised_prescribing returns all rows by default", {
  con <- local_test_con()
  df <- get_normalised_prescribing(con) |> dplyr::collect()
  expect_equal(nrow(df), 5)
})

test_that("get_normalised_prescribing filters by BNF codes", {
  con <- local_test_con()
  df <- get_normalised_prescribing(con, bnf_codes = "100") |>
    dplyr::collect()
  expect_equal(nrow(df), 2)
  expect_equal(unique(df$bnf_name), "Drug A")
})

test_that("get_normalised_prescribing filters by date range", {
  con <- local_test_con()

  df <- get_normalised_prescribing(con, start_date = "2023-02-01") |>
    dplyr::collect()
  expect_equal(nrow(df), 3)

  df <- get_normalised_prescribing(con, end_date = "2023-02-01") |>
    dplyr::collect()
  expect_equal(nrow(df), 3)

  df <- get_normalised_prescribing(
    con,
    start_date = as.Date("2023-02-01"),
    end_date = as.Date("2023-03-01")
  ) |>
    dplyr::collect()
  expect_equal(nrow(df), 2)
})

test_that("get_normalised_prescribing filters by BNF codes with wildcards", {
  con <- local_test_con()

  # "1%" matches both codes starting with 1 ("100" and "101"), not just "100"
  df <- get_normalised_prescribing(con, bnf_codes = "1%") |>
    dplyr::collect()
  expect_equal(nrow(df), 3)
  expect_setequal(df$bnf_name, c("Drug A", "Drug A1"))

  # Wildcard and exact codes can be mixed
  df <- get_normalised_prescribing(con, bnf_codes = c("1%", "300")) |>
    dplyr::collect()
  expect_equal(nrow(df), 4)
  expect_setequal(df$bnf_name, c("Drug A", "Drug A1", "Drug C"))

  # Wildcards combine with date filters
  df <- get_normalised_prescribing(
    con,
    bnf_codes = c("1%", "300"),
    start_date = "2023-02-01",
    end_date = "2023-03-01"
  ) |>
    dplyr::collect()
  expect_equal(nrow(df), 1)
  expect_equal(df$practice, "P2")

  # Quotes in codes are escaped, not executed as SQL
  df <- get_normalised_prescribing(con, bnf_codes = "1' OR '1'='1%") |>
    dplyr::collect()
  expect_equal(nrow(df), 0)
})

test_that("get_normalised_prescribing combines BNF and date filters", {
  con <- local_test_con()
  df <- get_normalised_prescribing(
    con,
    bnf_codes = "100",
    start_date = "2023-02-01"
  ) |>
    dplyr::collect()
  expect_equal(nrow(df), 1)
  expect_equal(df$practice, "P2")
})

test_that("get_normalised_prescribing validates dates", {
  con <- local_test_con()
  expect_snapshot(
    get_normalised_prescribing(con, start_date = "not-a-date"),
    error = TRUE
  )
  expect_snapshot(
    get_normalised_prescribing(
      con,
      start_date = "2023-04-01",
      end_date = "2023-01-01"
    ),
    error = TRUE
  )
})
