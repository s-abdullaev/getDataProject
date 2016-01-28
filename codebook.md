## Getting and Cleaning Data Project

This document provides information about the variables, the data and the transformations performed to accomplish the tasks given in Getting and Cleaning Data course project.

### Source
The data has been obtained from The UCI Machine Learning Repository which provides detailed description of the variables in [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
I downloaded the source data from [this url](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### Data Set Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Check the url in the source section for further details about this dataset.

### Attribute Information
For each record in the dataset it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment.

###Feature Selection

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.
Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).
Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).
These signals were used to estimate variables of the feature vector for each pattern:
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are:

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values.
iqr(): Interquartile range
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal
kurtosis(): kurtosis of the frequency domain signal
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'

###Transformations done to the original data

#### 1. Merge the training and the test sets to create one data set.
I used several files to construct a single table containing the subjects(people participating in the experiment), activities and the measurements. The table below provides the name of the file used, description of its variables and units of measurement:
 *File Name*         | *Variables Description*                                                                               | *Data Type*
---------------------|-------------------------------------------------------------------------------------------------------|-------------
 features.txt        | names of the measurements such as:  "body-acceleration-X", "body-acceleration-X-mean", "angle-X", etc | Categorical
 activity_labels.txt | names and ids of the activities such as: WALKING, WALKING_UPSTAIRS, etc                               | Categorical
 subject_train.txt   | repetitive collection of subject ids for 1-30 subjects                                                | Integer
 x_train.txt         | values for the measurements in acceleration and angular velocity                                      | Real
 y_train.txt         | activity ids per subject                                                                              | Integer
 subject_test.txt    | repetitive collection of subject ids for 1-30 subjects                                                | Integer
 x_test.txt          | values for the measurements in acceleration and angular velocity                                      | Real
 y_test.txt          | activity ids per subject                                                                              | Integer

The measurements are taken on accelaration and angular velocity in 3 directions (X,Y,Z) with following units:
 *Measurement*    | *Unit*
------------------|----------------------
 Acceleration     | ``` g=9.8 m/s^2 ```
 Angular velocity | ``` rad/s  ```

I merged columns from subject_train.txt, x_train.txt and y_train.txt into single table. I named the columns of this table as: subjectId, activityId and the names extracted from features.txt.
Then I appended the data from subject_test.txt, x_test.txt and y_test.txt to the existing table.

#### 2. Extract only the measurements on the mean and standard deviation for each measurement.
I selected column names containing mean() and std() using grep along with other informative columns such as subjectId, activityId and used this selection to project the resulted table.

#### 3. Use descriptive activity names to name the activities in the data set
I merged the activity labels from activity_labels.txt to the resulted table and named it finalTable.

#### 4. Appropriately label the data set with descriptive variable names.
I replaced the -mean() to Mean, -std() to Std in column names, and also removed non-alphabetic characters such as dash, parenthesis, etc.

#### 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
I created a table which groups by activityId and subjectId, and then finds the mean for each measurement inside the finalTable. Then finalTable is saved to source folder as tidyData.txt file.
