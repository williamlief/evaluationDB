
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Teacher Evaluation Database

This project is a compilation of publicly available teacher evaluation
reports for US school districts. The goal of this data is to facilitate
an understanding of the teacher evaluation reforms that occured in the
2010s, by examining the district level variation in reported teacher
quality.

## Previous work has reported state level evaluation results; this project reports district level data

<!-- ```{r} -->

<!-- p1 <- evaluationDB %>%  -->

<!--   filter(year == 2015, !is.na(count_teachers)) %>%  -->

<!--   select(count_level1, count_level2, count_level3, count_level4, NCES_leaid, year) %>%  -->

<!--   pivot_longer(c(-NCES_leaid, -year), names_to = "level", values_to = "count") %>% -->

<!--   group_by(year, level) %>%  -->

<!--   summarize(count = sum(count, na.rm = T)) %>%  -->

<!--   ggplot(data = .,  -->

<!--          aes(x = year, y = count, fill = level)) + -->

<!--   geom_col(position = "fill")  -->

<!-- p2 <- evaluationDB %>%  -->

<!--   filter(year == 2015, !is.na(count_teachers)) %>%  -->

<!--   mutate( -->

<!--     p1 = percent_level1,  -->

<!--     p2 = p1 + percent_level2, -->

<!--     p3 = p2 + percent_level3, -->

<!--     p4 = p3 + percent_level4) %>%  -->

<!--   arrange(p2) %>%  -->

<!--   mutate(index = cumsum(count_teachers)) %>%  -->

<!--   select(NCES_leaid, index, p1, p2, p3, p4) %>%  -->

<!--   ggplot(data = ., aes(x = index)) + -->

<!--   geom_ribbon(aes(ymax = p1, ymin = 0 ), fill = "red") + -->

<!--   geom_ribbon(aes(ymax = p2, ymin = p1), fill = "blue") + -->

<!--   geom_ribbon(aes(ymax = p3, ymin = p2), fill = "green") + -->

<!--   geom_ribbon(aes(ymax = p4, ymin = p3), fill = "purple") -->

<!-- ``` -->

![Overall teacher evaluation results for Ohio, then disaggregated by
district](resources/ratings.gif)

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

## Available Data

Evaluation records have been obtained from the following states:

| state | 2012 | 2013 | 2014 | 2015 | 2016 | 2017 | 2018 | 2019 |
|:------|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|
| FL    |   72 |   73 |   72 |   70 |   74 |   74 |   73 |      |
| MI    |  856 |  875 |  893 |  896 |  896 |  894 |  887 |  888 |
| IN    |      |  238 |  306 |  350 |  371 |  374 |  388 |  384 |
| LA    |      |   69 |   69 |   69 |   69 |   68 |   68 |      |
| MA    |      |   56 |  135 |  158 |  176 |  191 |  210 |      |
| NY    |      |  718 |  759 |  758 |  635 |      |      |      |
| CT    |      |      |  165 |  164 |      |      |      |      |
| NJ    |      |      |  582 |  576 |  580 |      |      |      |
| OH    |      |      |  772 |      |      |  608 |  607 |  608 |
| RI    |      |      |   56 |   57 |   60 |   60 |   59 |   59 |
| ID    |      |      |      |  147 |  148 |  151 |  153 |  159 |

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
