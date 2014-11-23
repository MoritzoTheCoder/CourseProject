CourseProject
=============
This repository contains the required files according to the instructions for submitting the Course Project in the Coursera Class "Getting and Cleaning Data" :

* This readme file 'readme.md'
* The file 'run_analysis.R' contains the script used to clean and aggregate the experimental data
* The file 'codebook.md' provides more information about the variables in the final dataset

Raw data of the experiment can be downloaded from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

About the experiment: 
30 participants were performing a set of six different activities while accelaration and gyroscopic data were collected by the sensors of a smart phone attached to the participants bodies. More info about the experiment: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Goal of the current analysis: 
Provide a dataset which averages the (already aggregated) sensor data for each participant performing each activity

About this analysis in more detail:
Note: The steps are listed in the order performed on the data set; however, the numbers correspond to the order as described in the course project description; there is often some flexibility in performing certain steps.
* STEP 0: Read in all necessary data tables (make sure you have unzipped saved the downloaded data in your R working directory since paths in the code are relative to that directory; in R-Studio go to 'Session' and than 'Set working directory')
* STEP 1: Since the data provided are splitted into a test and training group and the variable labels, subjectIDs and the actual measurements are stored in different files, those are merged into one big data frame
* STEP 4: The variable names need some editing to have unique and more descriptive labels: e.g. the abbreviation 'sd' is replaced by the more descriptive substring 'StandardDeviation'; also, some characters not convenient in R are replaced in this step (brakets and commas)
* STEP 3: The numeric coding of the performed activities is replaced by descriptive labels
* STEP 2: The dataset contains many variables describing the collected sensor data on different levels of aggregation. Since only already averaged signals are of interest here, the dataset is subsetted to those variables which contain 'mean' or 'standard deviation' in their labels.
* STEP 5: Since we are interested in even more aggregated data, in this step the mean of the selected variables is computed for every participant performing every activity
* Please, also have a look at the comments inside the script file itself.

