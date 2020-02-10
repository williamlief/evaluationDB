# Data-Raw/

`scripts/` Contains all of the code used to clean the original raw data. If you find any inconsistencies or potential errors in the scripts please [open an issue](https://github.com/williamlief/evaluationDB/issues/new) and describe the problem. 

`clean_csv_files/` contains the parsed csv files that are compiled into the final `evaluationDB.rda` file available in the repository. These csv files allow you to track changes in the parsed data across data releases.   

If you wish to check the data cleaning process yourself, you can clone the full repository for this project to your desktop. To allow for faster installation of the `evaluationDB` library and keep this repository to a minimum size, the raw-data is stored separately at [https://github.com/williamlief/evaluationDB-Raw](https://github.com/williamlief/evaluationDB-Raw). Run `r/raw_data_import.R` to download the raw data from github and install it into the project directory.
