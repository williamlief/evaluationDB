# Note here we ignore missing values, those are tested separately in test-na.R

test_that("No Negative Values", {

  df <- dplyr::select_if(evaluationDB, is.numeric)
  res <- apply(df, 2, function(x) sum(x < 0, na.rm = T) == 0)
  expect_true(all(res),
              label = paste(paste(names(which(res)), collapse=", ")))

})

test_that("Percent Cols Sum To One", {

  unity <- rowSums(evaluationDB[,grep("percent", names(evaluationDB))], na.rm = TRUE)
  rows <- sapply(unity, function(x) round(x, 2) == 1)
  pct_eq_one <- mean(rows)

  expect_gte(pct_eq_one, 1)
})

test_that("Total teachers >= sum of evaluations reported", {

  cols <- evaluationDB[, grepl("count", names(evaluationDB))]
  sum_eval <- rowSums(cols[,!grepl("teachers", names(cols))], na.rm = TRUE)
  pct_gte <- mean(evaluationDB$count_teachers >= sum_eval, na.rm = TRUE)

  expect_gte(pct_gte, 1)
})

test_that("Years are in expected range - (2005-2025)", {
  expect_lte(max(evaluationDB$year), 2025) # some padding for the next few years of the project
  expect_gte(min(evaluationDB$year), 2005) # some padding if we get earlier data
})
