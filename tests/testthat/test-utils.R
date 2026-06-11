test_that("check_date passes NULL through", {
  expect_null(check_date(NULL))
})

test_that("check_date accepts dates and date strings", {
  expect_equal(check_date("2023-01-01"), as.Date("2023-01-01"))
  expect_equal(check_date(as.Date("2023-01-01")), as.Date("2023-01-01"))
})

test_that("check_date rejects invalid input", {
  expect_error(check_date("not-a-date"), "must be a single date")
  expect_error(
    check_date(c("2023-01-01", "2023-02-01")),
    "must be a single date"
  )
  expect_error(check_date(NA), "must be a single date")
})
