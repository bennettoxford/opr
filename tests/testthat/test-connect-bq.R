test_that("connect_bq errors helpfully when the env variable is not set", {
  withr::local_envvar(OP_CREDENTIALS = NA)
  expect_snapshot(connect_bq(), error = TRUE)
})

test_that("connect_bq errors helpfully when the credentials file is missing", {
  withr::local_envvar(OP_CREDENTIALS = "/nonexistent/bq-credentials.json")
  expect_snapshot(connect_bq(), error = TRUE)
})

test_that("connect_bq respects a custom credentials_var", {
  withr::local_envvar(MY_CREDS = NA)
  expect_error(connect_bq(credentials_var = "MY_CREDS"), "MY_CREDS")
})
