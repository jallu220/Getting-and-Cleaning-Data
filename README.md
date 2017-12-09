## Course Getting and Cleaning Data the Assignment
Goal create one R script called run_analysis.R that is doing the following tasks:

# 1) Merges the training and the test sets to create one data set.
This is done by loading all the txt files as table, then combining them by row.
It is providing MergeData, MergeLabel and MergeSubject

# 2) Extracts only the measurements on the mean and standard deviation for each measurement.
Renaming the MergeData by the features list, then extracting only the names that 
contains mean or std. 

# 3) Uses descriptive activity names to name the activities in the data set
MergeLabel is modified to contains only the label of the activity based on the index
of the activity

# 4) Appropriately labels the data set with descriptive variable names.
Final data frame is create by column combining the Merge Subject, Activity and data
Renaming is done for the Subject and activity variables

# Finally from the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Final results are created by using group_by and summarise_all function


