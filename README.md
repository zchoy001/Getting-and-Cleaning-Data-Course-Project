# Getting and Cleaning Data

## Course Project

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Steps to work on this course project
1. Save ```run_analysis.R``` to your working directory of R.
2. Run ```source("run_analysis.R")``` to download the data source into your R working folder on your local drive. You'll have a ```UCI HAR Dataset``` folder.
3. It will generate a new file ```tiny_data.txt``` in your working directory, which is the tidy data set.

## Dependencies

1. Install package ```data.table``` by using install.packages("data.table") in the console of Rstudio 
