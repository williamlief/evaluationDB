# Note here we ignore missing values, those are tested separately in test-na.R

test_that("No Negative Values", {

  df <- dplyr::select_if(evaluationDB, is.numeric)
  res <- apply(df, 2, function(x) sum(x < 0, na.rm = T) == 0)
  expect_true(all(res),
              label = paste(paste(names(which(!res)), collapse=", ")))

})

test_that("Percent Cols Sum To One (.99-1.01)", {

  unity <- rowSums(evaluationDB[,grep("percent", names(evaluationDB))], na.rm = TRUE)
  rows <- sapply(unity, function(x) dplyr::between(x, .99, 1.01))
  pct_eq_one <- mean(rows)

  expect_gte(pct_eq_one, 1)

})

test_that("Total teachers >= sum of evaluations reported", {

  # known failures due to bad source data in CT, and one dist in MA
  # Errors are minimal, off by a pct or two
  known_fail <- c("0900450", "0900510", "0901920", "0901920", "0902670", # CT
                  "0902700", "0902790", "0900005", "0904680", "0904830", # CT
                  "0904860", "0904890", # CT
                  "2513230" # MA
                  )

  df <- evaluationDB[!evaluationDB$NCES_leaid %in% known_fail,]

  cols <- df[, grepl("count", names(df))]
  sum_eval <- rowSums(cols[,!grepl("teachers", names(cols))], na.rm = TRUE)
  pct_gte <- mean(df$count_teachers >= sum_eval, na.rm = TRUE)

  expect_gte(pct_gte, 1)
})

test_that("Years are in expected range - (2005-2025)", {
  expect_lte(max(evaluationDB$year), 2025) # some padding for the next few years of the project
  expect_gte(min(evaluationDB$year), 2005) # some padding if we get earlier data
})
