# data-raw/scripts/ 

This directory holds the code to clean the raw data.
There is one script for each state, and each script saves a csv file of its output
to `data-raw/clean_csv_files/`. 

`compile.R` combines the csv files and creates `data/evaluationDB.rda` with the final 
variable names and formats. 

# List of clean variables

These notes apply to cleaning the raw data and the intermediary csv files. The compiled database gives these variables intuitively legible names. 

## Identifiers

* state: two character state abbreviation
* year: 4 character spring year. e.g. 2012-2013 school year = 2013
* name: state used district name, all lower case
* localid: state used district id
* NCES_leaid (TODO)

## Evaluation
* et: total count of teachers reported by district
* eu: count of teachers district reports as unrated
* es: count of teachers with suppressed ratings
* e1: count of teachers receiving lowest rating  (typically ‘ineffective’)
* e2: count of teachers receiving second lowest rating (typically ‘developing’)
* e3: count of teachers receiving middle rating (typically ‘effective’)
* e4: count of teachers receiving highest rating (typically ‘highly effective’)
* e1_impute: indicator for imputed count 
* e2_impute: indicator for imputed count
* e3_impute: indicator for imputed count
* e4_impute: indicator for imputed count

# Data Imputation / Suppression
States have adopted various strategies to preserve the anonymity of teacher evaluation ratings. Some states arbitrarily suppress a fraction of ratings, others suppress all ratings in districts with less than 10 teachers, and others suppress ratings when fewer than n teachers are in that category. The _impute variables above are used to track when I have tried to fill in suppressed rating information. For more information about imputation see the state_details.md file.

Louisiana data values that are listed as less than or equal to 1% are imputed. p1 and p2 percentage values are derived from subtracting the known percentages from 100; if both p1 and p2 are imputed than everything is pushed to p2.

New Jersey imputes e2 data if both e1 and e2 are listed as NA. e2 is estimated by subtracting the sum of non-NA entries from the total number of evaluated teachers.

For the state of Ohio, any entries in all four categories which indicate a count of less than three are marked as NA and then imputed to 0.
