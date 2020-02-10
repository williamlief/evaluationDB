
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Teacher Evaluation Database

This project is a compilation of publicly available teacher evaluation
reports for US school districts. Detailed notes with the sources of all
data are part of this repostiory, as is all code used to clean and
process the data.

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

## Available Data

Evaluation records have been obtained from the following states:

| state | 2012 | 2013 | 2014 | 2015 | 2016 | 2017 | 2018 | 2019 |
| :---- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| FL    |   73 |   74 |   73 |   74 |   74 |   74 |   73 |      |
| MI    |  856 |  875 |  893 |  896 |  896 |  894 |  887 |  889 |
| IN    |      |  249 |  317 |  365 |  381 |  378 |  391 |  396 |
| LA    |      |   69 |   69 |   69 |   69 |   71 |   70 |      |
| MA    |      |  403 |  407 |  405 |  407 |  404 |  406 |      |
| NY    |      |  718 |  759 |  758 |  635 |      |      |      |
| CT    |      |      |  165 |  165 |      |      |      |      |
| NJ    |      |      |  582 |  576 |  582 |      |      |      |
| OH    |      |      |  793 |      |      |  608 |  608 |  608 |
| ID    |      |      |      |  155 |  155 |  156 |  158 |  165 |

Number of districts with teacher evaluation data by state and year

## Installation

The data can be installed from github.

``` r
# install.packages("devtools")
devtools::install_github("williamlief/evaluationDB")
```

## Documentation

The database is fully documented in R and contains an overview vignette
with descriptive statistics and figures for each state.

``` r
library(evaluationDB)
?evaluationDB
vignette("overview", package = "evaluationDB")
```

## Updates

Version 0.9 will soon be released for the 2020 AERA conference

## Contributing

This repository contains all code used to clean and process the raw
data. If you are interested in inspecting the data cleaning process
please see
[here](https://github.com/williamlief/evaluationDB/tree/master/data-raw)

If you are interested in contributing to this project, please contact
Lief Esbenshade.

## About the Author

Lief Esbenshade is a doctoral candidate at Stanford University in the
Economics of Education program. His work focuses on understanding
teacher quality and teacher labor markets. He has worked with New York
City Department of Education, San Francisco Unified School District,
Stanford Center for Assessment Learning and Equity (SCALE), and the
Educational Testing Service (ETS).
