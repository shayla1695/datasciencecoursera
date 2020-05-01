library(dplyr)

if(!file.exists("./data")){dir.create("./data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "./data/.run_analysis", method="curl")

if(!file.exists("UCI HAR Dataset")){
  unzip("./data/.run_analysis")
}

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

merged_x <- rbind(x_test, x_train)
merged_y <- rbind(y_test, y_train)
merged_sub <- rbind(subject_test, subject_train)
Data <- cbind(merged_sub, merged_y, merged_x)

complete_data <- Data %>% 
  select(subject, code, contains("mean"), contains("std"))

complete_data$code <- activities[complete_data$code, 2]

names(complete_data)[2] = "activity"
names(complete_data) <- gsub("Acc", "Accelerometer", names(complete_data))
names(complete_data) <- gsub("Gyro", "Gyroscope", names(complete_data))
names(complete_data) <- gsub("BodyBody", "Body", names(complete_data))
names(complete_data) <- gsub("Mag", "Magnitude", names(complete_data))
names(complete_data) <- gsub("^t", "Time", names(complete_data))
names(complete_data) <- gsub("^f", "Frequency", names(complete_data))
names(complete_data) <- gsub("tBody", "TimeBody", names(complete_data))
names(complete_data) <- gsub("-mean ()", "Mean", names(complete_data))
names(complete_data) <- gsub("-std ()", "StD", names(complete_data))
names(complete_data) <- gsub("-freq ()", "Frequency", names(complete_data))
names(complete_data) <- gsub("angle", "Angle", names(complete_data))
names(complete_data) <- gsub("gravity", "Gravity", names(complete_data))

Ind_Data <- complete_data %>% 
  group_by(subject, activity) %>% 
  summarise_all(funs(mean))
write.table(Ind_Data, "Ind_Data.txt", row.name = FALSE)
  
