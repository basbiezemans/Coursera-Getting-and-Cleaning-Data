#
# This script does the following:
# 
#  1. Merge the training and the test sets to create one data set.
#  2. Extract only the measurements on the mean and standard deviation for each measurement. 
#  3. Use descriptive activity names to name the activities in the data set
#  4. Appropriately label the data set with descriptive variable names. 
#  5. Create an independent tidy data set with the average of each variable for each activity and each subject.

library(data.table)
library(dplyr)

separator <- "\\"
rootDir   <- "UCI_HAR_Dataset"
testDir   <- paste(rootDir, "test", sep = separator)
trainDir  <- paste(rootDir, "train", sep = separator)

# Read the data sets
testData      <- fread(paste(testDir, "X_test.txt", sep = separator))
trainData     <- fread(paste(trainDir, "X_train.txt", sep = separator))
testLabels    <- fread(paste(testDir, "y_test.txt", sep = separator))
trainLabels   <- fread(paste(trainDir, "y_train.txt", sep = separator))
testSubjects  <- fread(paste(testDir, "subject_test.txt", sep = separator))
trainSubjects <- fread(paste(trainDir, "subject_train.txt", sep = separator))

# Merge the columns
testSet  <- cbind(testSubjects, testLabels, testData)
trainSet <- cbind(trainSubjects, trainLabels, trainData)

# Merge the data sets
dataset <- rbind(trainSet, testSet)

# Add descriptive feature names
features <- fread(paste(rootDir, "features.txt", sep = separator))
names(dataset) <- c("subject", "activity", features$V2)

# Extract the mean and standard deviation for each measurement
colsToSelect <- grepl("mean|std", names(dataset))
colsToSelect[1:2] <- TRUE # include subject and activity
dataset <- subset(dataset, select = colsToSelect)

# Use descriptive activity names to name the activities in the data set
activities <- fread(paste(rootDir, "activity_labels.txt", sep = separator))
dataset$activity <- factor(dataset$activity, labels = activities$V2)

# Create an independent tidy data set with the average of each variable for each activity and each subject
tidyDataset <- summarise_each(group_by(dataset, subject, activity), funs(mean))

# Store the tidy data set
write.table(tidyDataset, "tidy_dataset.txt", row.name = FALSE)

# Cleanup the environment
remove(testData, testLabels, testSubjects, testSet, tidyDataset)
remove(trainData, trainLabels, trainSubjects, trainSet, colsToSelect)
remove(features, dataset, activities, separator, rootDir, testDir, trainDir)
