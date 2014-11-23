#####Script for the COURSE PROJECT in the Coursera Class GETTING AND CLEANING DATA in November/December 2014

###Reference for data and instructions (need to be loged in at Coursera): https://class.coursera.org/getdata-009/human_grading/view/courses/972587/assessments/3/submissions

###Comment: The instructions were carried out in following order: Merging (STEP 1), labeling variables (STEP 4), labeling activities (STEP 3), subsetting dataset (STEP 2), and finanlly summarizing (STEP 5)

###################################################################
###STEP 0 - Preparation: Setting working directory and loading data
###################################################################
setwd("~/Desktop/Coursera_Getting and Cleaning Data/5 Course Project")
#Import all necessary data as dataframes
X_train <- read.table(file="./train/X_train.txt")
y_train <- read.table(file="./train/y_train.txt")
sbj_train <- read.table(file="./train/subject_train.txt")
X_test <- read.table(file="./test/X_test.txt")
y_test <- read.table(file="./test/y_test.txt")
sbj_test <- read.table(file="./test/subject_test.txt")
features <- read.table(file="features.txt")
activity_labels <- read.table(file="activity_labels.txt")

#activity_labels$V2 <- as.character(activity_labels$V2)


######################################################################
###STEP 1: Merge the training and the test sets to create one data set
######################################################################
DF <- rbind(X_train, X_test)
sbj <- rbind(sbj_train, sbj_test)
#Add columns with subjectIDs and activities (order of these vectors is assumed to correspond to the order of the measurement data)
activities <- rbind(y_train, y_test)
DF <- cbind(sbj, activities, DF)


###########################################################################
###STEP 4: Appropriately label the data set with descriptive variable names
###########################################################################

#Rename first two variables and columns 3:563 according to the list of names in dataframe 'feature'
names(DF)[1] = "subjectID"
names(DF)[2] = "activity"
names(DF)[3:563] <- as.character(features$V2)

#Edit variable names: Replace characters unconvenient in R
names(DF) <- gsub(pattern="\\(|\\)", replacement="", names(DF))
names(DF) <- gsub(pattern="-|,", replacement="_", names(DF))
#Edit variable names to more descriptive labels (i.e. spell 'sd' out to 'StandardDeviation')
names(DF) <- gsub(pattern="std", replacement="StandardDeviation", names(DF))


#################################################################################
###STEP 3: Use descriptive activity names as listed in file 'activity_labels.txt'
#################################################################################

DF$activity <- factor(DF$activity, labels = as.character(activity_labels$V2))

################################################################################################
###STEP 2: Extract only the measurements on the mean and standard deviation for each measurement
################################################################################################

#Subset the data frame to those variables whose labels indicate representing mean or standard deviation of raw signal data
DF.subset <- DF[, grep("subjectID|activity|StandardDeviation|mean", names(DF), value=TRUE)]


###########################################################################################################################
###STEP 5: creates a second, independent tidy data set with the average of each variable for each activity and each subject
###########################################################################################################################

#Create a data table from the existing data set and compute mean for all variables by subject and activity
install.packages("data.table")
library(data.table)
DF.subset_DT <- data.table(DF.subset)
DF.summary <- DF.subset_DT[, lapply(.SD, mean), by = c("subjectID","activity")]
#DF.mean is the desired data table/frame 

#########################################
###EXPORT & INSTURCTIONS FOR RE-IMPORT###
#########################################
write.table(DF.summary, file = "tidy_dataset.txt", sep=";", row.names = FALSE) #No need to execute since my tidy dataset is provided via Coursera
#Download my tidy_dataset file to your working directory (you might copy-paste it to your working directory if the file is downloaded automatically into the default download folder)
#Code for re-importing the text file as dataset into R:
tidy_dataset <- read.table("12407de0732811e4bd28e118f5761593.txt", header=TRUE, sep=";")
(The cryptic file names results from Coursera/Amazon automatically renames the uploaded file)
