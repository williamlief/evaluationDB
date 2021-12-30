
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Teacher Evaluation Database

This project is a compilation of publicly available teacher evaluation
reports for US school districts. In the 2018-19 school year the data
represents evaluations for over 500,000 public school teachers. The goal
of this data is to facilitate an understanding of the teacher evaluation
reforms that occured in the 2010s, by examining the district level
variation in reported teacher quality. The data covers the 2011-12
through 2018-19 school years with data from 10 states. Exact data
availability varies by state and year.

## Available Data

Evaluation records have been obtained from the following states and
years. The counts show the number of districts with reported data in
each year. For each district-year the database includes the total number
and proportion of teachers with a level 1 “ineffective” rating, a level
2 “developing” rating, a level 3 “effective” rating, and a level 4
“highly effective” rating. Exact labels for the four rating labels used
vary by state.

| state | 2011-12 | 2012-13 | 2013-14 | 2014-15 | 2015-16 | 2016-17 | 2017-18 | 2018-19 |
|:------|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|
| CT    |         |         |     165 |     164 |         |         |         |         |
| FL    |      72 |      73 |      72 |      70 |      74 |      74 |      73 |      73 |
| ID    |         |         |         |     147 |     148 |     151 |     153 |     159 |
| IN    |         |     238 |     306 |     350 |     371 |     374 |     388 |     384 |
| LA    |         |      69 |      69 |      69 |      69 |      68 |      68 |      68 |
| MA    |         |      56 |     135 |     158 |     176 |     191 |     210 |     193 |
| MI    |     856 |     875 |     893 |     896 |     896 |     894 |     887 |     888 |
| NJ    |         |         |     582 |     576 |     580 |         |         |         |
| OH    |         |         |     772 |         |         |     608 |     607 |     608 |
| RI    |         |         |      56 |      57 |      60 |      60 |      59 |      59 |

## Installation / Documentation

The data can be installed from github as an r-package and is fully
documented in R.

``` r
# install.packages("devtools")
devtools::install_github("williamlief/evaluationDB")

library(evaluationDB)
?evaluationDB
```

## Details

**This database does not include teacher names and evaluation scores**.
It includes only district level counts of teachers receiving each final,
aggregate rating in a district.

**This data should not be used to compare teacher quality across
districts.** The high level of variability in reported teacher quality
across districts and time make any such comparisons highly suspect. To
our knowledge, there is no evidence that statewide teacher evaluation
mandates, as implemented by districts, have resulted in a consistent and
reliable metric that allows valid inter-district comparisons of teacher
quality. This database is a first step towards understanding what
happened with the push to reform teacher evaluations of the 2010s. With
the evaluation reforms, states moved from Satisfactory/Unsatisfactory
rating systems to systems with 4 or more categories ranging from
Ineffective to Highly Effective.

Detailed notes with the sources of all data are part of this repostiory,
as is all code used to clean and process the data.

## Contributing

This repository contains all code used to clean and process the raw
data. If you are interested in inspecting the data cleaning process
please see
[here](https://github.com/williamlief/evaluationDB/tree/master/data-raw)

If you find an error, please [open an
issue](https://github.com/williamlief/evaluationDB/issues) and describe
in detail what you are seeing.

If you are interested in contributing more data to this project, please
contact me at <liefEsbenshade@gmail.com>
