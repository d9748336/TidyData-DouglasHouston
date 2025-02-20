TidyData-DouglasHouston
=======================

Getting and Cleaning Data Course Project

SUMMARY: 
The script run_analysis.R reads all of the pertinent data in the UCI HAR Dataset  into separate data frame objects. It then extracts only those readings that have been calculated on the means or standard deviations of the original measurements by using s regular expression search of "mean" and "std". It uses these to construct a table that has clearly labelled columns (named using the plain English contained in features.txt). Then it calculates the mean measurements for each subject (i.e. the person who took the readings) and activity type (e.g. standing or walking). Finally it constructs a single tidy table that presents only these summarised data, all clearly labelled in a logical order. 

The final output is "tidy" because it contains observations in the rows and variables in the columns, one per column. Every column has been labelled with a heading that is readable in English (so no code numbers etc.). The features names as provided in the data set have been used to name the measurement columns as these are descriptive, although they have been converted to R syntactically correct ones using make.names in order to make future subsetting etc. more easy so that the user can easily map them back to the names in the original data. Descriptive activity names (e.g. "Walking" and "Walking Up") have been used to denote the activities.

There are some duplicate names in the original features.txt because the trailing -X, -Y or -Z has been accidentally omitted, but these are not a problem as none of the mean or std features names are affected (and it is only these that appear in the tidy data set).

Please also inspect the contents of the run_analysis.R script as there are extensive comments describing each part of the code and what it is doing at each stage. Also note the presence of d9748336-TidyData-CODEBOOK.md file in the repository - this contains descriptions of the variables present in the tidy data.

PLEASE NOTE:
The tidy data file ("tidy.txt") that the script writes is not formatted for reading in text readers. To be able to see the tidy tabulated formatting use the following code in RStudio:

data <- read.table("tidy.txt", header = TRUE)
head(data) # Or any other function for inspecting the contents of objects
