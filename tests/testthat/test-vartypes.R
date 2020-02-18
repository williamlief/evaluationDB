test_that("id variables are typed correctly", {

  expect_type(evaluationDB$localid, "character")
  # "state", "district_name", "localid", "NCES_leaid"
  # year - integer
  # Fill in with remaining variables
  expect_true(FALSE)
})

test_that("count vars are integers", {

  expect_type(evaluationDB$count_level1, "integer")
  # Fill in with remaining variables
  expect_true(FALSE)
})

test_that("impute vars are logical", {

  expect_type(evaluationDB$impute_level1, "logical")
  # Fill in with remaining variables
  expect_true(FALSE)
})

test_that("percent vars are doubles", {

  expect_type(evaluationDB$percent_level1, "double")
  # Fill in with remaining variables
  expect_true(FALSE)
})
