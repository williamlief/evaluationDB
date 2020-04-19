library(tidyverse)
library(readxl)

df <- read_excel("/Users/williamlief/Documents/ResearchProjects/EvaluationData/evaluationDB/data-raw/New Mexico/Evaluation/20-017   Esbenshade     Document--Teacher Ratings for all Districts 2013-2018.xlsx")

# Name manipulation
# Extract the school years so we get the right year for each column
names <- names(df)
names <- gsub("\\.\\.\\..*", "", names)
names <- gsub("School Year \\d\\d-", "", names)
for(i in 1:length(names)) { if(names[i] == ""){ names[i] = names[i-1] }}

# grab the first row for the effectiveness label and combine with years, then reassign names
newnames <- unlist(df[1,])
newnames <- paste(newnames, names, sep = "_")
df <- df[2:nrow(df),]

names(df)[2:length(names(df))] <- newnames[2:length(newnames)]

# Pivot data
long <- df %>%
  pivot_longer(
    -`District Name`,
    names_to = c(".value", "year"),
    names_sep = "_",
    names_ptypes = list(
      year = integer()))
