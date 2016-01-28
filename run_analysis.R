# Coursera Getting and Cleaning Data Course Project

# Sarvar Abdullaev

# run_analysis.R File Description:

# This script accomplishes following transformations to the original data given in folder "./data". 

# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement.
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names.
# 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#USING: Simply run the script.

############################################################################################################

# this library allows chaining R statements in neat form. Very useful for gsub
require('magrittr')
require('dplyr')

# 1) Merges the training and the test sets to create one data set.

# Loading tables from data files inside data folder:
features     = read.table('./data/features.txt',header=FALSE) 
activityType = read.table('./data/activity_labels.txt',header=FALSE)
subjectTrain = read.table('./data/train/subject_train.txt',header=FALSE)
xTrain       = read.table('./data/train/x_train.txt',header=FALSE)
yTrain       = read.table('./data/train/y_train.txt',header=FALSE)
subjectTest  = read.table('./data/test/subject_test.txt',header=FALSE)
xTest        = read.table('./data/test/x_test.txt',header=FALSE)
yTest        = read.table('./data/test/y_test.txt',header=FALSE)

#Renaming the columns for loaded tables:
colnames(activityType)  = c("activityId", "activityType")
colnames(subjectTrain)  = "subjectId"
colnames(xTrain)        = features[,2]
colnames(yTrain)        = "activityId"
colnames(subjectTest)   = "subjectId"
colnames(xTest)         = features[,2]
colnames(yTest)         = "activityId"

#Bind columns of subjects, activities and measurements into one table for both train and test data:
trainData   = cbind(subjectTrain, yTrain, xTrain)
testData    = cbind(subjectTest, yTest, xTest)

#Union the rows of trainData and testData tables into new finalData table
finalData = rbind(trainData, testData)

# 2) Extracts only the measurements on the mean and standard deviation for each measurement.

#Fetching column names for merged data set
columns=colnames(finalData)

#Selecting column names that end with mean() or std(), as well as activityId and subjectId
colsToExtract=grep("mean\\(\\)|std\\(\\)|^activityId$|^subjectId$", columns, value=TRUE)

#Projecting the data set to requested columns, and reassigning to finalData
finalData=finalData[,colsToExtract]

# 3) Uses descriptive activity names to name the activities in the data set

#Left joining the finalData table with activityType table, because we don't want unmatched records from finalData to be lost
finalData=merge(finalData, activityType, by="activityId", all.x=TRUE)

# 4) Appropriately labels the data set with descriptive variable names.

#Cleaning the final column names including those in recently joined in activityType table

#I use camel notation for naming columns
finalColumns = colnames(finalData)              %>% 
    gsub(pattern="-mean", replacement="Mean")   %>% #turning -mean to capital Mean 
    gsub(pattern="-std", replacement="Std")     %>% #turning -std to capital Std
    gsub(pattern="\\W", replacement="")         %>% #removing non-alphanumeric chars
    gsub(pattern="^t", replacement="time")      %>% #initial t means time
    gsub(pattern="^f", replacement="freq")          #inital f means freq

#Assign new column names
colnames(finalData)=finalColumns

# 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Getting tidy data frame
tidyDf = tbl_df(finalData)                              %>% #convert to data frame in dplyr
    select(-activityType)                               %>% #exclude activityType column
    group_by(subjectId, activityId)                     %>% #group by subjectId and activityId
    summarise_each(funs(mean))                          %>% #summarise each column with mean function
    merge(y=activityType, by='activityId', all.x=TRUE)  %>% #include activityType column back
    arrange(subjectId, activityId)                          #sorted by subjectId

#saving the data frame as table in tidy.txt
write.table(tidyDf, './data/tidy.txt', row.names=TRUE, sep='\t')
