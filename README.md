## Course project readme file for Getting and Cleaning data course
### Software Versions used
Operating system: Microsoft Windows 8.1, R version 3.1.2

#### R Script _run_analysis.R_ description for tidying up the Samsung smartphone data
* Checks if the required packages are installed, if not installs and loads them
 * Packages used: data.table, dplyr
1. Merging the _training_ and _test_ data into a single data frame 
 * Read the feature names from *features.txt*
 * Read the activity labels from *activity_labels.txt*
 * Read the _subject_ data for _training_ from */train/subject_test.txt*
 * Read the _activity_ for _training_ data from */train/y_test.txt*
 * Read the _features_ for _training_ data from */train/X_test.txt*
 * Read the _subject_ data for _test_ from */test/subject_test.txt*
 * Read the _activity_ for _test_ data from */test/y_test.txt*
 * Read the _features_ for _test_ data from */test/X_test.txt*
 * Insert names for all the variables
 * Row bind _training_ and _test_ data and then column bind all the variables together
 * Complete data frame is ready
2. Extracting the mean and the std variables from the complete dataset
 * Identify column names containing _mean_ or _std_ word using grep function
 * Only select _Subject_, _activity_, and above identified columns for a new data frame
3. Decoding activity column as factors
 * Decode factor levels for _activity_ using a for loop and activity labels read above
4. Assigning descriptive names for the variables
 * _gsub_ function is used to perform a global search and replacement operation for various abbreviations
5. Creating another dataset with average of each variable for each activity and each subject_test
 * Create file table to write using _aggregate_ function
 * Write the *TidyData.txt* file using _write.table_ function
 

