
run_analysis <- function () {
 
# 1) Merge the training and test sets
        # Set the path if needed
        # setwd('./UCI HAR Dataset/')
        
        #Load the 561 features labels located in 2nd column, no header 
        features <- read.csv('features.txt',sep='',header=FALSE)
        #Load the 6 activity labels located in 2nd column, no header
        activity <- read.csv('activity_labels.txt',sep='',header=FALSE)
        
        #Load the training and test data, labels and subjects
        # Training : 7352 measurements of 561 variables for Data Set
        TrainingDataSet <- read.csv('train/X_train.txt',sep='',header=FALSE)
        TrainingLabel <- read.csv('train/y_train.txt',sep='',header=FALSE)
        TrainingSubject <- read.csv('train/subject_train.txt',sep='',header=FALSE)
        #2947 obs of 561 variables for Data set
        TestDataSet <- read.csv('test/X_test.txt',sep='',header=FALSE)
        TestLabel <- read.csv('test/y_test.txt',sep='',header=FALSE)
        TestSubject <- read.csv('test/subject_test.txt',sep='',header=FALSE)
        
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
        SelectData <- MergeData[grep('mean|std'),names(MergeData),ignore.case = TRUE] 
        
# 3) Uses descriptive activity names to name the activities in the data set
        #Use merge function by common row names
        MergeActivity <- merge(MergeLabel, activity, by.x = "V1", by.y = "V1")

# 4) Appropriately labels the data set with descriptive variable names
        MergeAll <-cbind(MergeSubject,MergeActivity[,2],SelectData)
        names(MergeAll)[1:2] = c("SubjectID", "Activity")

#Create set with the average of each variable for each activity and each subject.        
       group_by(MergeAll,SubjectID, Activity)  %>%   summarise_all(funs(mean))        
}       
