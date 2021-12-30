# Note: splitting the test this way lets us know if we are missing a variable
# or have addeed one, if we just ran expect_equal(names(evaluationDB), expected_names)
# we wouldn't know if variable addition/subtraction was causing the problem

# Current observation count! update with new data. This test is expected to fail
# frequently, but forces us to be very explicit about adding or removing rows.
# Remember to update r/evaluationDB.R documentation when this count changes!
expected_rows <- 17447

test_that("Expected number of rows exists", {
  expect_equal(nrow(evaluationDB), expected_rows)
})


# This is the list of documented variables, will need to be manually updated
expected_names <- c("state", "year", "district_name", "localid", "NCES_leaid",
                    "count_teachers", "count_not_evaluated", "count_suppressed",
                    "count_level1", "count_level2", "count_level3", "count_level4",
                    "percent_suppressed",
                    "percent_level1", "percent_level2", "percent_level3", "percent_level4",
                    "impute_level1", "impute_level2", "impute_level3", "impute_level4")

test_that("All Documented Variables Exist", {
  res <- expected_names %in% names(evaluationDB)
  expect_true(all(res))
})

test_that("No Extra Variables", {
  res <- names(evaluationDB) %in% expected_names
  expect_true(all(res))
})


# This is the list of documented states, will need to be manually updated
expected_states <- c("CT", "FL", "ID", "IN", "LA", "MA", "MI", "NJ", "OH", "RI")

test_that("All Documented States Exist", {
  res <- expected_states %in% unique(evaluationDB$state)
  expect_true(all(res))
})

test_that("No Extra States Exist", {
  res <- unique(evaluationDB$state) %in% expected_states
  expect_true(all(res))
})


