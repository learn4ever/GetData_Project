# Project Assignment 2
#
# INSTRUCTIONS
# You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# Creates a second, independent tidy data set with the average of each variable 
#   for each activity and each subject. 

# Setup the variables ...
# The script should be run from where the zipfile was unzipped
#   .                     <- run_analysis.R is here
#   +---/UCI HAR Dataset/
#        +--------------/test
#        +--------------/test/Inertial Signals
#        +--------------/train
#        +--------------/train/Inertial Signals

rootdir="./UCI HAR Dataset/"
testdir=paste(rootdir,"test",sep="")
traindir=paste(rootdir,"train",sep="")

# Read the feature labels
allfeatures <- read.table(paste(rootdir, "features.txt", sep="/"), 
                          sep=" ", 
                          strip.white=TRUE)
# Read the activity labels
activity_labels <- read.table(paste(rootdir, "activity_labels.txt", sep="/"), 
                              sep=" ", 
                              strip.white=TRUE)

# reading all the files in ....
print("Reading data files ....")
y_train <- read.table(paste(traindir, "y_train.txt", sep="/"))
x_train <- read.table(paste(traindir, "X_train.txt", sep="/"))
y_test  <- read.table(paste(testdir, "y_test.txt", sep="/"))
x_test  <- read.table(paste(testdir, "X_test.txt", sep="/"))
subject_test  <- read.table(paste(testdir, "subject_test.txt", sep="/"))
subject_train <- read.table(paste(traindir, "subject_train.txt", sep="/"))

print(".... done")


# Add the columns from subject and features to the data 
trainingData <- cbind(y_train, subject_train, x_train)
testingData  <- cbind(y_test, subject_test, x_test)

# merge the two datasets
# 1. Merges the training and the test sets to create one data set.-- DONE
fulldata <- rbind(trainingData, testingData)

print("Finished merging datasets ....")


# set the columnnames from features.txt
# 2. Appropriately labels the data set with descriptive variable names. DONE
colnames(fulldata) <- c("activity", "subject", as.character(allfeatures[,c(2)]))

# convert the character type to numeric
for (i in 3:ncol(fulldata)) { 
  fulldata[,i] <- as.numeric(fulldata[,i])
}
# all the data is now tidied up and stored in the dataframe called "fulldata"

# make a list of columns to keep,
#     which are "activity", "subject" and anything that has mean() or std() in the column name
keep_cols <- grepl("activity|subject|mean\\(\\)|std\\(\\)",colnames(fulldata))

# subset the fulldata to keep only the requested columns
tidydata <- subset(fulldata,select=keep_cols)

print("Finished creating a subset ....")

# 3. Extract only the measurements on the mean and standard deviation for each measurement. DONE !


# match the activity code to the descriptive activity label
activity_descriptions <- as.character(activity_labels[match(tidydata$activity, activity_labels$V1),c(2)])

# 4. Uses descriptive activity names to name the activities in the data set. DONE !

# add the activity labels to the tidy data set
tidydata <- cbind(activity_label=activity_descriptions, tidydata)

# write the tidy dataset to a comma-separated file
write.table(tidydata, file="tidydata.txt", sep=",", row.names=FALSE)

print("Finished writing the tidy dataset to file ....")

# Now, to calculate the mean of the observations
# I think I can use melt() and dcast() instead of this approach. Revisit this. #TODO

first_time <- TRUE
# numeric readings start from column 4 onwards
for (i in 4:ncol(tidydata)) { 
  # aggregate the readings by activity and subject, with the 'mean' function
  colmean <- aggregate(tidydata[,i] ~ activity + subject,data=tidydata, FUN="mean")
  colnames(colmean)[3] <- colnames(tidydata)[i]
    
  if (first_time) {
    # keep the activity and subject columns only for the first time
    allmeans <- colmean
    first_time = FALSE
  }else{
    # for the next column onwards, keep only the column containing the means 
    allmeans <- cbind(allmeans, colmean[,3])
    colnames(allmeans)[i-1] = colnames(tidydata)[i]
  } 
}

print("Finished calculating the means for each activity and subject ....")

# again, match the activity codes to the descriptive activity labels
activity_descriptions <- as.character(activity_labels[match(allmeans$activity, activity_labels$V1),c(2)])

# add the activity labels to the dataset containing the means
allmeans <- cbind(activity_label=activity_descriptions, allmeans)

# Creates a second, independent tidy data set with the average of each variable 
#   for each activity and each subject.  DONE !

# write the dataset to the second comma-separated file
write.table(allmeans, file="allmeans_tidy.txt", sep=",", row.names=FALSE)

print("Finished writing the means for each activity and subject to file .... DONE")

# we are done !

# Testing

checkTidy <- function(file="tidydata.txt") {
  tidy <- read.csv(file)
  sprintf("Tidy data read : Rows=%d, Columns=%d", nrow(tidy), ncol(tidy))
}

checkMeans <- function(file="allmeans_tidy.txt") {
  means <- read.csv(file)
  sprintf("Tidy Means data read : Rows=%d, Columns=%d", nrow(means), ncol(means))
}

# uncomment to test output files
#
#  checkTidy()
#  checkMeans()










