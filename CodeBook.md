# Code Book for the Getting And Cleaning Data Course Project
This Code Book code book describes the variables, the data, and any transformations or work that was performed to clean up the data and produce the tidy data set.

## Background
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit:

1) a tidy data set as described below, 
2) a link to a Github repository with your script for performing the analysis, and 
3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 
4) You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

Here are the data for the project: 

  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 



## Steps to be followed

### A. Get data and understand data structure 
1. Download the file from the link provided (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) to your R working directory.

2. Extract the data in your working directory to create a folder "getdata-projectfiles-UCI HAR Dataset"

3. Understand the data. Folder "./getdata-projectfiles-UCI HAR Dataset" contains a folder "UCI HAR Dataset". This in turn contains a "test" and a "train" folder along with 4 text files
  - README.TXT : Explains the data set
  - features_info.TXT: Explains the data that was collected
  - features.TXT: Lists all the data headings that was captured
  - activity_labels.TXT: Lists the activities against which the data was captured.

The "test" and a "train" folders follow a similar structure and includes a folder with "Inertial Signals" which is ignored for the purpose of this data analysis. 
These folders have 3 text files.

- X_train.TXT / X_test.TXT: Contains the data measurements that was collected
- subject_train.TXT / subject_test.TXT: includes the test subject 
- Y_train.TXT / Y_test.TXT: Contains the activities 

All 3 contain the same number of rows - 2947 rows for "test" and 7352 rows for the "train" folder.
X_train.TXT / X_test.TXT contain 561 columns which matches with the number of fields mapped in the features.TXT file.

4. 

### B. Create Analysis script (run_analysis.R)
Create one R script called run_analysis.R that does the following.

 1) Merges the training and the test sets to create one data set.
 2) Extracts only the measurements on the mean and standard deviation for each measurement.
 3) Uses descriptive activity names to name the activities in the data set 
 4) Appropriately labels the data set with descriptive variable names.  
 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
 
For this analysis, I am using 3 libraries - data.table, reshape2 and dplyr.

I noticed that the two relevant folders "test" and "train" have a similar structure, so I decided to create a function "Prodata" which carries out the repetitive task of loading appropriate data and adding activity names & column labels. The "Prodata" function takes a "datatype" variable which can be either test or train. 

a. The function loads Subject, Activity and Data from the appropriate files in the test/train folder.
b. The Activity data (1-6) is replaced by descriptive activity names from the activity_labels.TXT data set
c. The Data loaded from  X_train.TXT / X_test.TXT is enriched by adding column labels from the features.TXT file
d. The function then column binds Subject, Activity and Data data tables to create a table on which additional activities can be performed.


Steps 
i. While running the script, a couple of common files are loaded - activity_labels and feature_labels.
ii. The function "Prodata" is called once for "test" and again for "train". This returns the appropriate test/train file which has the Subject, Activity and Data data which readable column names.
iii. The data from train & test is merged into a "masterdata" table
iv. Then the measurements on the mean and standard deviation for each measurement is extracted by searching for mean & std in the "masterdata" column names.
v. Once we have only the relevant information in "masterdata", a tidydata table is created using melt & dcast. This is written out to the "UCI HAR Dataset Tidy Data.TXT" file in the FolderPath.

The "UCI HAR Dataset Tidy Data.TXT" was then copied to the Github repository.