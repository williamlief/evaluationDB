context("Values are plausible")

test_that("No Negative Values", {

  df <- dplyr::select_if(evaluationDB, is.numeric)
  res <- apply(df, 2, function(x) sum(x < 0, na.rm = T) > 0)
  expect_true(all(res),
              label = paste(paste(names(which(res)), collapse=", ")))

})

test_that("Percent Cols Sum To One", {

  unity <- rowSums(evaluationDB[,grep("percent", names(evaluationDB))], na.rm = TRUE)
  rows <- sapply(unity, function(x) round(x, 2) == 1)

  expect_true(all(rows))
})

test_that("Total teachers >= sum of evaluations reported", {

})

test_that("Years are in expected range - (2005-2025)", {
  expect_lte(max(evaluationDB$year), 2025) # some padding for the next few years of the project
  expect_gte(min(evaluationDB$year), 2005) # some padding if we get earlier data
})
