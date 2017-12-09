
run_analysis <- function () {
        library(dplyr)
        
# 1) Merge the training and test sets
        # Set the path if needed
        # setwd('./UCI HAR Dataset/')
        
        #Load the 561 features labels located in 2nd column, no header 
        features <- read.table('features.txt')
        #Load the 6 activity labels located in 2nd column, no header
        activity <- read.table('activity_labels.txt')
        
        #Load the training and test data, labels and subjects
        # Training : 7352 measurements of 561 variables for Data Set
        TrainingDataSet <- read.table('train/X_train.txt')
        TrainingLabel <- read.table('train/y_train.txt')
        TrainingSubject <- read.table('train/subject_train.txt')
        #2947 obs of 561 variables for Data set
        TestDataSet <- read.table('test/X_test.txt')
        TestLabel <- read.table('test/y_test.txt')
        TestSubject <- read.table('test/subject_test.txt')
        
        #Combine the training and test data using row binding
        # 10299 obs
        MergeData <- rbind(TrainingDataSet,TestDataSet)
        MergeLabel <- rbind(TrainingLabel,TestLabel)
        MergeSubject <- rbind(TrainingSubject,TestSubject)

# 2) Extracts only the measurements on the mean and standard deviation for each measurement.
        #Give correct names to the data variables
        names(MergeData) <-features[,2]  
        #Select the variables that have "mean" and "std" in their names
        # use grep that will return indices and pattern matching is not case sensitive, e.g. Mean/mean
        SelectData <- MergeData[grep('-(mean|std)\\(\\)',names(MergeData))] 
        
# 3) Uses descriptive activity names to name the activities in the data set
        # Select the activity name from the index
        MergeLabel[,1] <- activity[MergeLabel[,1],2]

# 4) Appropriately labels the data set with descriptive variable names
        # Merge all the data
        MergeAll <-cbind(MergeSubject,MergeLabel,SelectData)
        names(MergeAll)[1:2] = c("SubjectID", "Activity")

#Create set with the average of each variable for each activity and each subject.
        # group the data by SubjectID then Activity and then summarized them
        # Result have the correct size of 30 subjects x 6 Activities = 180 obs
       AnalysisResult <- group_by(MergeAll,SubjectID, Activity)  %>%   summarise_all(mean)    
#Save the results in file
       write.table(AnalysisResult, 'Analysis_Result.txt',row.names = FALSE)
        
}       
