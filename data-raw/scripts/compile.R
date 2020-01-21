# This file compiles the cleaned csvs into a single rmd file

# Setup ------------------------------------------------------------------------

library(dplyr)
library(tidyr)
library(readr)

# Read in Files ----------------------------------------------------------------
list <- list.files("data-clean", pattern = "Eval.csv", full.names = TRUE)

files <- lapply(
  list,
  read_csv, 
  col_types = cols(.default = "d", state = "c", localid = "c", name = "c")  
)
  
df <- files %>% bind_rows() 

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
  replace_na(list(e1 = 0, e2 = 0, e3 = 0, e4 = 0)) %>% 
  mutate(
    p1 = e1 / et, 
    p2 = e2 / et, 
    p3 = e3 / et, 
    p4 = e4 / et,
    ps = es / et, 
    pu = eu / et,
    pt = p1+p2+p3+p4+p2+pu
  ) %>% 
  bind_rows(df %>% 
              filter(has_p) %>% 
              mutate_at(vars(p1, p2, p3, p4), ~. / 100))

df2 %>% group_by(state) %>% summarize(sum(is.na(et)))
# check p data not missing
df2 %>% group_by(state) %>% summarize(sum(is.na(p1)))
df2 %>% group_by(state) %>% summarize(sum(is.na(p2)))
df2 %>% group_by(state) %>% summarize(sum(is.na(p3)))
df2 %>% group_by(state) %>% summarize(sum(is.na(p4)))
df2 %>% mutate(pt = p1+p2+p3+p4) %>% group_by(state) %>% summarize(mean(is.na(pt)))

# Merge NCES -------------------------------------------------------------------

nces <- read_csv("data-clean/NCES_CCD.csv") 

df_nces <- df2 %>% 
  mutate(
    localid = case_when(
      state == "MA" ~ substring(localid,1,4),
      state == "FL" ~ stringr::str_pad(localid, 2, side = "left", "0"),
      state == "IN" ~ stringr::str_pad(localid, 4, side = "left", "0"),
      state == "MI" ~ stringr::str_pad(localid, 5, side = "left", "0"),
      TRUE ~ localid
    )) %>% 
  left_join(nces, by = c("state", "year", "localid")) %>% 
  filter(!(state == "ID" & is.na(NCES_leaid))) # visual check confirmed these are all charter schools

df_nces %>% group_by(state) %>% summarize(sum(is.na(NCES_leaid)))

# Rename/Reorder and Save ------------------------------------------------------

evaluationData <- df_nces %>% 
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
    "percent_not_evaluated" = pu, 
    "percent_suppressed" = ps, 
    "percent_level1" = p1,
    "percent_level2" = p2,
    "percent_level3" = p3,
    "percent_level4" = p4,
    "impute_level1" = e1_impute,
    "impute_level2" = e2_impute,
    "impute_level3" = e3_impute,
    "impute_level4" = e4_impute
  )

saveRDS(evaluationData, "data-clean/evaluationData.rds")