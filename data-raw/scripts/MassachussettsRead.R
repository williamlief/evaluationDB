# Setup ------------------------------------------------------------------------

library(dplyr)
library(readxl)
library(readr)

path <- "data-raw/Massachusetts/evaluation"

# Read -------------------------------------------------------------------------

list <- list.files(path = path, pattern = "*.xlsx", full.names = TRUE)
files <- lapply(list, read_excel, na = c("NA","NI","NR"), skip = 1)

# File name does not include year, but first row of excel file has year as header info
years <- lapply(list, function(x) {
  x <- read_excel(x, n_max =1, col_names = FALSE)
  return(as.numeric(substr(x[1,1], 1, 4)) + 1)}) %>%
  unlist()

for (i in 1:length(files)) {
  files[[i]]$year <- years[i]
}

df <- bind_rows(files) %>%
  rename(name = `District Name`,
         localid = `District Code`,
         et = `# of Educators to be Evaluated`,
         evaluated = `# Evaluated`,
         e4 = `% Exemplary`,
         e3 = `% Proficient`,
         e2 = `% Needs Improvement`,
         e1 = `% Unsatisfactory`
  )


# Clean ------------------------------------------------------------------------

convertNumber <- function(e, evaluated) {
  round(as.numeric(gsub("-", NA, e)) / 100 * evaluated, 0)
}

Massachusetts <- df %>%
  mutate(evaluated = as.numeric(gsub(",", "", evaluated))) %>%
  mutate_at(
    vars(e1, e2, e3, e4),
    list(~convertNumber(., evaluated))
  ) %>%
  rowwise() %>%
  mutate(
    state = "MA",
    name = tolower(name),
    et = as.numeric(gsub(",", "", et)),
    es = ifelse(e1 == "-" & e2 == "-" & e3 == "-" & e4 == "-", evaluated, 0),
    eu = et - sum(e1, e2, e3, e4, na.rm = TRUE)
    ) %>%
  select("state", "name", "localid", "year", "et", "eu", "es",
         "e4", "e3", "e2", "e1") %>%
  filter(name != "state totals") %>%
  arrange(localid, year)

write_csv(Massachusetts, "data-raw/clean_csv_files/MassachusettsEval.csv")
