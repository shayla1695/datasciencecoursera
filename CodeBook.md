---
title: "Code Book"
author: "Shayla Clark"
date: "5/1/2020"
output: html_document
---
The run_analysis.R script prepares the Human Activity Recognition Data to the specifications outlined in the definition of the course project.

# Download the dataset

- The dataset was downloaded into a folder called UCI HAR Dataset

# Assign variables

- features <- features.txt: 561 rows, 2 columns
  Features for this database came from accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ
- activities <- activity_labels.txt: 6 rows, 2 columns
  List of activities performed while the corresponding measurements were taken
- subject_test <- test/subject_test.txt: 2947 rows, 1 column
  Test data of the subjects
- x_test <- test/X_test.txt: 2947 rows, 561 columns
  Recoded features test data
- y_test <- test/y_test.txt: 2947 rows, 1 column
  Test data of activities' code labels
- subject_train <- train/subject_train.txt: 7352 rows, 1 column 
  Train data of subjects
- x_train <- train/X_train.txt: 7352 rows, 1 column
  Recorded features train data
- y_train <- train/y_train.txt: 7352 rows, 1 column
  Train data of activities' code labels
  
# Merge Training and Test Datasets
 - merged_x (10299 rows, 561 columns) created by merging x_test and x_train using rbind() function
 - merged_y (10299 rows, 1 column) created by merging y_test and y_train using rbind() function
 - merged_sub (10299 rows, 1 column) created by merging subject_test and subject_train using rbind() function
 - Data (10299 rows, 563 columns) created by merging merge_sub, merged_y, merged_x
 
# Extract Measurements on Mean and StD for Each Measurement
- complete_data (10299 rows, 88 columns) created by susetting Data, selecting only columns: subject, code and the measurements on the mean and standarad deviation for each measurement

# Use Descriptive Activity Names
- Numbers in the code column of the complete_data was replaced with corresponding activity from the second column of the activities variable

# Label the Data Set with Descriptive Names
- code column in complete_data renamed to activities
- All ACC in column names was changed to Accelerometer
- All Gyro in column names was changed to Gyroscope
- All BodyBody in column's name was changed to Body
- All Mag in column names was changed to Magnitude
- All start with character f in column names was changed to Frequency
- All start with character t in column names was changed to Time

# Create an Independent Tidy Dataset with the Average of each Variable for each Activity and each Subject
- Ind_Data (180 rows, 88 columns) is created by sumarizing complete_data taking the means of each variable for each activity and each subject, after grouped by subject and activity
- Exports Ind_Data into Ind_Data.txt file

