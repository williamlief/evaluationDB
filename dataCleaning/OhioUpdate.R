source("setup.r")

path <- setpath("Ohio")

library(dplyr)
library(readxl)
library(tidyr)
library(readr)

df1 <- read_excel(paste(path, 
                       "DISTRICT_TEACHER_2017_fin.xls", 
                       sep = "/"), 
                 sheet=1) %>% 
  select(localid = `District IRN`,
         name = `District Name`,
         p1 = `% of Teachers  Evaluated as  Ineffective`,
         p2 = `% of Teachers  Evaluated as  Developing`,
         p3 = `% of Teachers  Evaluated as Skilled`,
         p4 = `% of Teachers  Evaluated as  Accomplished`,
         ps = `% of Teachers  Evaluations Not Completed`)

df2 <- read_excel(paste(path, "DIST_LRC_2018_EDUCATOR_DATA.xlsx",
                        sep = "/"),
                  sheet = 1) %>% 
  select(localid = `District IRN`,
         name = `District Name`,
         p1 = `Pct Tchrs Evaluated Ineffective`,
         p2 = `Pct Tchrs Evaluated Developing`,
         p3 = `Pct Tchrs Evaluated Skilled`,
         p4 = `Pct Tchrs Evaluated Accomplished`,
         ps = `Pct Tchrs Eval Not Completed`)

df3 <- read_excel(paste(path, "DIST_LRC_2019_EDUCATOR_DATA.xlsx",
                        sep = "/"),
                  sheet = 2) %>%
  select(localid = `District IRN`,
         name = `District Name`,
         p1 = `Percent of Teachers Evaluated as Ineffective`,
         p2 = `Percent of Teachers Evaluated as Developing`,
         p3 = `Percent of Teachers Evaluated as Skilled`,
         p4 = `Percent of Teachers Evaluated as Accomplished`,
         ps = `Percent Teachers whose Evaluations were Not Completed`)

df1$year <- 2017
df2$year <- 2018
df3$year <- 2019

Ohio <- bind_rows(df1, df2, df3) %>% 
  mutate(name = tolower(name),
         p1=as.numeric(p1) * 100,
         p2=as.numeric(p2) * 100,
         p3=as.numeric(p3) * 100,
         p4=as.numeric(p4) * 100)

write_csv(Ohio, "CleanData/OhioUpdate.csv")