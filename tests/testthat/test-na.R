# https://stackoverflow.com/questions/60269017/using-testthat-to-check-all-variables-in-a-data-frame-for-na-values

test_that("No Missing Values - excluding LA and OH, count teachers", {
  df <- dplyr::filter(evaluationDB, !state %in% c("LA", "OH"))
  df <- dplyr::select(df, -count_teachers)
  res <- apply(df, 2, function(x) sum(is.na(x))>0)
  expect_true(all(!res),
              label = paste(paste(names(which(res)), collapse=", ")))

})

test_that("No Missing Values, LA OH excluding count variables", {
  df <- dplyr::filter(evaluationDB, state %in% c("LA", "OH"))
  df <- dplyr::select(df, -dplyr::starts_with("count_"))

  res <- apply(df, 2, function(x) sum(is.na(x))>0)
  expect_true(all(!res),
              label = paste(paste(names(which(res)), collapse=", ")))

})
