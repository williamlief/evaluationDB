# This file compiles the cleaned csvs into a single rmd file

# Setup ------------------------------------------------------------------------

library(dplyr)
library(tidyr)
library(readr)
library(tidylog)

# Read in Files ----------------------------------------------------------------
list <- list.files("data-raw/clean_csv_files", pattern = "Eval.csv", full.names = TRUE)

list <- list[!grepl("NewMexico", list)] # remove New Mexico as it has five categories

files <- lapply(
  list,
  read_csv,
  col_types = cols(.default = "d", state = "c", year = 'i', localid = "c", name = "c")
)

df <- files %>% bind_rows() %>%
  filter(year <= 2019) # exclude anything with COVID

# Create p_ variables ----------------------------------------------------------

df <- df %>%
  # LA data only has percents and no counts, need to exclude from this calculation
  # Ohio 2017-19 data is also percent only
  mutate(has_p =
           state == "LA" |
           (state == "OH" & year %in% 2017:2019)
  )

df2 <- df %>%
  filter(!has_p) %>%
  replace_na(list(e1 = 0, e2 = 0, e3 = 0, e4 = 0, es = 0, eu = 0)) %>%
  mutate(
    tmp_total = e1 + e2 + e3 + e4 + es,
    p1 = e1 / tmp_total,
    p2 = e2 / tmp_total,
    p3 = e3 / tmp_total,
    p4 = e4 / tmp_total,
    ps = es / tmp_total,
    # pu = eu / et,
    # pt = p1+p2+p3+p4+p2+pu
  ) %>%
  bind_rows(df %>%
              filter(has_p) %>%
              mutate(ps = 0) %>% # swap to line below if we get data with suppressed percents
              # replace_na(list(ps = 0)) %>%
              mutate(tmp_total = (p1 + p2 + p3 + p4 + ps), # rescale to 100
                     p1 = p1 / tmp_total,
                     p2 = p2 / tmp_total,
                     p3 = p3 / tmp_total,
                     p4 = p4 / tmp_total,
                     ps = ps / tmp_total)) %>%
  mutate_at(vars(c(year, starts_with("e"))), as.integer) %>%
  mutate_at(vars(ends_with("impute")), function(x) replace_na(as.logical(x), FALSE))

# Merge NCES -------------------------------------------------------------------

nces <- read_csv("data-raw/clean_csv_files/NCES_CCD.csv",
                 col_types = cols(year = 'i'))

df_nces <- df2 %>%
  mutate(
    localid = case_when(
      state == "MA" ~ substring(localid,1,4),
      state == "FL" ~ stringr::str_pad(localid, 2, side = "left", "0"),
      state == "IN" ~ stringr::str_pad(localid, 4, side = "left", "0"),
      state == "MI" ~ stringr::str_pad(localid, 5, side = "left", "0"),
      state == "CT" ~ stringr::str_pad(localid, 3, side = "left", "0"),
      state == "RI" ~ stringr::str_pad(localid, 2, side = "left", "0"),
      TRUE ~ localid
    )) %>%
  left_join(nces, by = c("state", "year", "localid")) %>%
  # manual fixing
  mutate(NCES_leaid = case_when(
    localid == "82015" ~ "2601103", # Detroit, MI is reporting this id before NCES has it
    TRUE ~ NCES_leaid
  )) %>%
  # manual removals
  filter(!(state == "ID" & is.na(NCES_leaid))) # visual check confirmed these are all charter schools

# Deal with Missing Values / NAN ------------------------------------------------

df_nces %>% group_by(state) %>% summarize(sum(is.na(NCES_leaid)))
df_nces %>% group_by(state) %>% summarize(sum(is.na(p1)))


# NCES - drop
warning(paste("Dropping", sum(is.na(df_nces$NCES_leaid))  ,"districts without NCES leaids"))
df_nces <- df_nces[!is.na(df_nces$NCES_leaid),]

# Get rid of districts without any p-values
warning(paste("Dropping", sum(is.na(df_nces$p1))  ,"districts without any evaluation percents"))
# This is a lot of districts, especially in MA. But visual checking shows many
# districts in MA that report 100% teachers evaluated, but no actual data on what
# those evals were.
df_nces <- df_nces[!is.nan(df_nces$p1),]


# Rename/Reorder and Save ------------------------------------------------------

# missing some of the p-impute variables because they were never used in any source
# file. This code adds in whichever ones are missing. In the next step we combine
# p_impute and count impute into a generic impute variable.
p_imputes <- c("p1_impute", "p2_impute", "p3_impute", "p4_impute")
for(p in p_imputes) {
  if(!p %in% names(df_nces)){
    df_nces[p] = FALSE
  }
}

evaluationDB <- df_nces %>%
  rowwise() %>%
  mutate(
    impute_level1 = any(e1_impute, p1_impute),
    impute_level2 = any(e2_impute, p2_impute),
    impute_level3 = any(e3_impute, p3_impute),
    impute_level4 = any(e4_impute, p4_impute),
  ) %>%
  select(
    state,
    year,
    "district_name" = name,
    localid,
    NCES_leaid,
    "count_teachers" = et,
    "count_not_evaluated" = eu,
    "count_suppressed" = es,
    "count_level1" = e1,
    "count_level2" = e2,
    "count_level3" = e3,
    "count_level4" = e4,
    # "percent_not_evaluated" = pu,
    "percent_suppressed" = ps,
    "percent_level1" = p1,
    "percent_level2" = p2,
    "percent_level3" = p3,
    "percent_level4" = p4,
    "impute_level1",
    "impute_level2",
    "impute_level3",
    "impute_level4"
  ) %>%
  ungroup()

usethis::use_data(evaluationDB, overwrite = TRUE)
