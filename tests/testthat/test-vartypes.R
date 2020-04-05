test_that("id variables are typed correctly", {

  expect_type(c(evaluationDB$localid, evaluationDB$state, evaluationDB$district_name,
              evaluationDB$localid, evaluationDB$NCES_leaid), "character")
  # "state", "district_name", "localid", "NCES_leaid"
  expect_type(evaluationDB$year, "integer")
  # year - integer
  # Fill in with remaining variables
})

test_that("count vars are integers", {

  expect_type(c(evaluationDB$count_level1, evaluationDB$count_level2, evaluationDB$count_level3,
              evaluationDB$count_level4, evaluationDB$count_not_evaluated, evaluationDB$count_suppressed,
              evaluationDB$count_teachers), "integer")
  # Fill in with remaining variables
})

test_that("impute vars are logical", {

  expect_type(c(evaluationDB$impute_level1, evaluationDB$impute_level2, evaluationDB$impute_level3,
              evaluationDB$impute_level4), "logical")
  # Fill in with remaining variables
})

test_that("percent vars are doubles", {

  expect_type(c(evaluationDB$percent_level1, evaluationDB$percent_level2, evaluationDB$percent_level3,
              evaluationDB$percent_level4, evaluationDB$percent_suppressed),
              "double")
  # Fill in with remaining variables
})
