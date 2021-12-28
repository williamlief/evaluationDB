#' Teacher Evaluation Data
#'
#' A dataset containing the count and percent of teachers
#' receiving each evaluation score for a subset of school districts and years.
#'
#' @section: Imputation:
#'
#' To protect anonymity, some districts suppressed ratings when small numbers of
#' teachers received a specific rating (typically ten or fewer teachers). In some
#' cases, the district still reported the total number of teachers evaluated and
#' the number in the other rating categories so we could recover the number in the
#' suppressed category. Note that because we only know the number of teachers
#' receiving a rating, and have no individual information about the teachers,
#' n-size suppression in this context is unnecessary for privacy protection. In
#' other districts rating categories with ten or fewer teachers were suppressed as were the
#' number of teachers rated in the next smallest category. In this case, when the
#' two suppressed categories were ineffective and developing, I assigned all teachers
#' to the developing category. All cases where imputation of this nature occurred
#' are indicated through the `impute_` variables. There were also cases when districts
#' reported that some number of teachers had a suppressed rating, this is reported in
#' the `count/percent_suppressed` variables.
#'
#' @format a data frame with 19983 rows and 21 variables
#' \describe{
#'   \item{state}{the name of the state, not null}
#'   \item{year}{school year, 2012-13 coded as 2013, not null}
#'   \item{district_name}{descriptive district name, not null}
#'   \item{localid}{nces localid for school district, not null}
#'   \item{NCES_leaid}{nces leaid for school district, not null}
#'   \item{count_teachers}{number of teachers in school district as reported in evaluation files. Some state-years only reported proportions evaluated and not counts. In those cases the total number of teachers evaluated and the count in each category will be null}
#'   \item{count_not_evaluated}{number of teachers without reported evaluations. Note that these teachers are excluded from the percentage calculations. The percents given are only of evaluated teachers}
#'   \item{count_suppressed}{number of teachers with ratings suppressed for privacy reasons by the source. These teachers are included in the percentage calculations.}
#'   \item{count_level1}{number of teachers with lowest rating - typically "ineffective"}
#'   \item{count_level2}{number of teachers with second lowest rating - typically "developing"}
#'   \item{count_level3}{number of teachers with third level rating - typically "effective"}
#'   \item{count_level4}{number of teachers with fourth level rating - typically "highly effective"}
#'   \item{percent_suppressed}{percent with suppressed ratings}
#'   \item{percent_level1}{percent with lowest rating}
#'   \item{percent_level2}{percent with second lowest rating}
#'   \item{percent_level3}{percent with third level rating}
#'   \item{percent_level4}{percent with level four rating}
#'   \item{impute_level1}{Was count/percent imputed}
#'   \item{impute_level2}{Was count/percent imputed}
#'   \item{impute_level3}{Was count/percent imputed}
#'   \item{impute_level4}{Was count/percent imputed}
#' }
#' @source Data compiled from public records. See \url{https://github.com/williamlief/evaluationDB}
#' for source code.
#'
"evaluationDB"
