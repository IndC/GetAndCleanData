library(data.table)
library(reshape2)
library(dplyr)

ProData <- function(datatype){                     # Loads appropriate data and adds activity names & column labels
  # Load Test data
  subj <- read.table(paste(FolderPath,datatype,"/subject_",datatype,".txt", sep=""))
  data <- read.table(paste(FolderPath,datatype, "/X_",datatype,".txt", sep=""))
  act <- read.table(paste(FolderPath,datatype, "/Y_",datatype,".txt", sep=""))
  
  # Enrich data with column names activity names
  colnames(subj) <- "Subject"
  act <- left_join(act,activity_labels, by = "V1") # 3. Uses descriptive activity names to name the activities in the data set
  act <- select(act, V2)
  colnames(act) <- "Activity"
  colnames(data) <- as.vector(feature_labels$V2)   # 4. Appropriately labels the data set with descriptive variable names.
  
  # Merge loaded data
  data <- cbind(subj, act, data)
}

# Load Common data
FolderPath <- "./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/"
activity_labels <- read.table(paste(FolderPath,"activity_labels.txt", sep = ""))

feature_labels <- read.table(paste(FolderPath,"features.txt", sep = ""))

# 1. Merges the training and the test sets to create one data set
masterdata <- rbindlist(list(ProData("test"), ProData("train")))

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
cl <- colnames(masterdata)
mscols <- cl[grepl("mean|std", colnames(masterdata), ignore.case=TRUE)]
masterdata <- subset(masterdata,select = c("Subject", "Activity", mscols))

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidydata <- melt(masterdata, id = c("Subject", "Activity"))
tidydata <- dcast(tidydata, Subject + Activity ~ variable, mean)

write.table(tidydata, file = paste(FolderPath, "UCI HAR Dataset Tidy Data.txt", sep = ""), row.names=FALSE, sep = "")
