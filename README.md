# Getting and Cleaning Data - Course Project

The raw data comes from the "Human Activity Recognition Using Smartphones Data Set". It's a collection of measurements from a smartphone's embedded accelerometer and gyroscope. A group of 30 volunteers was asked to perform six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone on the waist.

The script run_analysis.R creates a data set that can be used for further analysis. It only contains averages of the mean and standard deviation data.

Download: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Checklist

* Unzip the data set in the same directory as the script file.
* Make sure the packages `data.table` and `dplyr` are installed.
* Change the `separator` variable in the script file if you're not using a Windows OS.

## Run file

    > source("run_analysis.R")

## Result

File: tidy_dataset.txt
