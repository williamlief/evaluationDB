context("No Missing Values")

# https://stackoverflow.com/questions/60269017/using-testthat-to-check-all-variables-in-a-data-frame-for-na-values

test_that("No Missing Values", {
  res <- apply(evaluationDB, 2, function(x) sum(is.na(x))>0)
  expect_true(all(res),
              label = paste(paste(names(which(res)), collapse=", ")))

})
