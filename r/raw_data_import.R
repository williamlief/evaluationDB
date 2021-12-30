#' Import raw data from github
#'
#'
#' @details This function is used to support investigation into
#' the data cleaning process. It should only be used after cloning the evaluationDB repository
#' at \url{https://github.com/williamlief/evaluationDB}.
#'
#' It downloads the original government reports and FOIA request responses used
#' to create the evaluationDB
#' from \url{https://github.com/williamlief/evaluationDB-Raw}.
#'
#' Data files are installed into the `data-raw/` directory and supplies all files
#' necessary for the data cleaning scripts in `data-raw/scripts`
#'
raw_data_import <- function() {
  if(file.exists("raw-download")) {
    stop("There is already a zip file called 'raw-download' in the
    working directory, download cancelled to prevent overwriting")
  }
  if(!dir.exists("data-raw")) {
    stop("'data-raw' directory not found. Do you need to clone the repository at
         https://github.com/williamlief/evaluationDB?")
  }

  utils::download.file("https://github.com/williamlief/evaluationDB-Raw/archive/master.zip",
                "raw-download.zip")

  utils::unzip("raw-download.zip", exdir = "data-raw")

  # Move all the files down one level - must manually remake the directory structure
  files <- list.files("data-raw/evaluationDB-Raw-master", recursive = TRUE)
  files <- files[!grepl(".Rmd|.md", files)] # get rid of root readme
  dirs <- unique(paste0("data-raw/", sub("\\/[^\\/]*$", "", files)))
  dirs <- dirs[!grepl("\\.", dirs)] # removes nces_ccd file, not a dir
  lapply(dirs, dir.create, recursive = TRUE)

  file.copy(from = paste0("data-raw/evaluationDB-Raw-master/", files),
            to = paste0("data-raw/", files),
            overwrite = TRUE)

  file.copy(from = "data-raw/NCES_CCD.csv",
            to = "data-raw/clean_csv_files/NCES_CCD.csv",
            overwrite = TRUE)

  # cleanup
  unlink("data-raw/NCES_CCD.csv")
  unlink("data-raw/evaluationDB-Raw-master")
  unlink("raw-download.zip")
}
