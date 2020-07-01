# Activity Analysis: Getting and Cleaning Data Coursera Project

Welcome to my project -- this code fulfills the following:

 	Merges the training and the test sets to create one data set.
    
    Extracts only the measurements on the mean and standard deviation for each measurement.
    
    Uses descriptive activity names to name the activities in the data set
    
    Appropriately labels the data set with descriptive variable names.
    
    
    From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The script pulls data from the cloudfront http source for UCI's activity daataset. It then goes through the directory and reads each relevant file into a data table. These data tables are then organized, labelled for the right columns, and cleaned up for only the needed data (mean / std) before ultimately being merged into a 'finalData' data table. This data table is then tidied up to organize by subject and activity. 