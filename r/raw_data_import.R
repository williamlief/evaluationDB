#' Import raw data from github
#'
#'
#' @details This function is used to support investigation into
#' the data cleaning process. It should only be used after cloning the evaluationDB repository
#' at \code{\href{https://github.com/williamlief/evaluationDB}{https://github.com/williamlief/evaluationDB}}.
#'
#' It downloads the original government reports and FOIA request responses used
#' to create the evaluationDB
#' from \code{\href{https://github.com/williamlief/evaluationDB-Raw}{https://github.com/williamlief/evaluationDB-Raw}}.
#'
#' Data files are installed into the `data-raw/` directory and supplies all files
#' necessary for the data cleaning scripts in `data-raw/scripts`
#'
#' @return
#' @export
raw_data_import <- function() {
  if(file.exists("raw-download")) {
    stop("There is already a zip file called 'raw-download' in the
    working directory, download cancelled to prevent overwriting")
  }
  if(!dir.exists("data-raw")) {
    stop("'data-raw' directory not found. Do you need to clone the repository at
         https://github.com/williamlief/evaluationDB?")
  }

  download.file("https://github.com/williamlief/evaluationDB-Raw",
                "raw-download.zip")

  unzip("raw-download.zip", exdir = "data-raw")
  file.remove("raw-download.zip")
}
