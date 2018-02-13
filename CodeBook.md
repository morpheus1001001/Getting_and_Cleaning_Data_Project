##CodeBook

This code runs simple analysis on data for 30 subjects that performed 6 activities :WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING waring smartfones with activity sensors. The data was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and it was processed as follows:

Download the data file in a temporary file
Unzip the files and unlink the temp file
Set the working directory in the main directory that contains all the needed files
Bringing the data into R
Select the mean and standard deviation from the features dataframe
Cleanup the variables'names.
There are 79 variables names stored in the mean_and_std data frame.
Create the working dataframes which include the activities' and the subjects' labels and the labels for the required features(mean and std)
Unite the training and test dataframes into oneSINGLE data frame
Assign the proper variable names
Create the proper factor variables
Create the required second independent dataset with an independent average of each activity and each subject
Calculate the average for each subject and activity for the specific feature
The resulting data frame has 81 variables: 79 numeric, 2 factor variables(subject and activity) and 180 records: 30x6 combinations of subject and activity for which we calculated the averages of the numerical variables.
Export the final dataset to a text file
