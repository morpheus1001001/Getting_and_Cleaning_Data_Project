##Download the data file in a temporary file

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
tempfile <- tempfile()
download.file(fileUrl, tempfile)

## Unzip the files and unlink the temp file
unzip(tempfile)
list.files()
unlink(tempfile)

#Set the working directory in the main directory that contains all the needed files
setwd("./UCI HAR Dataset")

#Bringing the data into R
activitynames <- read.table("activity_labels.txt")
features <- read.table("features.txt")

traindata<-read.table("./train/X_train.txt")
trainactivitylabels <- read.table("./train/Y_train.txt")
trainsubjectslabels <- read.table("./train/subject_train.txt")

testdata<-read.table("./test/X_test.txt")
testactivitylabels<-read.table("./test/Y_test.txt")
testsubjectslabels <- read.table("./test/subject_test.txt")

#Looking at the data
str(activitynames)
head(activitynames)
str(features)
head(features)
tail(features)
str(traindata)
str(trainlabels)
str(testdata)
str(testlabels)

#Select the mean and standard deviation from the features dataframe
mean_and_std <- grep(".*mean.*|.*std.*", features[,2])
names(mean_and_std)<-features[mean_and_std,2]

#Looking at the data
str(mean_and_std)

# Removing unnecessary "-" and "()"
names(mean_and_std) <- gsub("[-()]", "", names(mean_and_std))
str(mean_and_std)

#Create the working dataframes which include the activities, the subjects' labels and the labels for the required features(mean and std)
trainingworkdatfr<-cbind(trainsubjectslabels, trainactivitylabels, traindata[mean_and_std])
testworkdsdatfr<-cbind(testsubjectslabels, testactivitylabels, testdata[mean_and_std])

#Unite the training and test dataframes
udata<-rbind(trainingworkdatfr,testworkdsdatfr)
str(udata)

#Assign the proper variable names
names(udata)<-c("subjectlabel","activitylabel",names(mean_and_std))
str(udata)

#Performing some reshapings
table(udata$activitylabel)
table(udata$subjectlabel)

# Create the proper factor variables
udata$activitylabel <- factor(udata$activitylabel, levels = activitynames[,1], labels = activitynames[,2])
udata$subjectlabel <- as.factor(udata$subjectlabel)
table(Udata$activitylabel)
table(Udata$subjectlabel)
head(udata)
#Create the required second independent dataset with an independent average of each activity and each subject

library(tidyr)
gathereddata<-gather(udata,"featurename","featurevalue",-subjectlabel,-activitylabel)
head(gathereddata)
tail(gathereddata)

#Calculate the average for each subject and activity for the specific feature

library(reshape2)
finaldataset<-dcast(gathereddata, subjectlabel+activitylabel ~ featurename,value.var ="featurevalue",mean)

#Export the final dataset to a text file
write.table(finaldataset,"finaldataset.txt", row.names = FALSE, quote = FALSE)
list.files()
