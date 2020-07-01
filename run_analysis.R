#Set up wd and load package
library(dplyr)
currfolder <- "./data"
dir.create("./data")
setwd(currfolder)

#import from online
dataOnline <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zippedData <- "UCI HAR Dataset.zip"
download.file(dataOnline, zippedData)
unzip(zippedData)

#take out files and read them into tables + fix issues
features <- paste("UCI HAR Dataset", "features.txt", sep="/")
featuresData <- read.table(features, col.names=c("Row","Variable"))
uniquefeatures <- mutate(featuresData, Variable = gsub("BodyBody","Body", Variable))
uniquefeatures <- unique(uniquefeatures)
head(uniquefeatures)

activity <- paste("UCI HAR Dataset", "activity_labels.txt", sep="/")
labels <- read.table(activity, col.names=c("activity", "description"))

xtest <- paste("UCI HAR Dataset", "test/X_test.txt", sep="/")
testvals <- read.table(xtest, col.names = uniquefeatures$Variable)

ytest <- paste("UCI HAR Dataset", "test/y_test.txt", sep="/")
testactivities <- read.table(ytest)

subjecttest <- paste("UCI HAR Dataset", "test/subject_test.txt", sep="/")
subjecttesttable <- read.table(subjecttest, col.names=c("subject"))
testactivitiesdesc <- merge(testactivities, labels)

xtrain <- paste("UCI HAR Dataset", "train/X_train.txt", sep="/")
featureTrainTable <- read.table(xtrain, col.names = uniquefeatures$Variable)

ytrain <- paste("UCI HAR Dataset", "train/y_train.txt", sep="/")
activityTrainTable <- read.table(ytrain)

subjecttrain <- paste("UCI HAR Dataset", "train/subject_train.txt", sep="/")
trainsubjecttable <- read.table(subjecttrain, col.names=c("subject"))

#build comprehensive data table
subjectDT <- rbind(trainsubjecttable, subjecttesttable)
activityDT<- rbind(activityTrainTable, testactivities)
featuresDT<- rbind(featureTrainTable, testvals)

names(subjectDT)<-c("subject")
names(activityDT)<- c("activity")
featuresUsed <- read.table(file.path("./UCI HAR Dataset", "features.txt"),head=FALSE)
names(featuresDT)<- featuresUsed$V2

compData <- cbind(subjectDT, activityDT)
finalData <- cbind(featuresDT, compData)

usedfeaturesSubset<-featuresUsed$V2[grep("mean\\(\\)|std\\(\\)", featuresUsed$V2)]

usedNames<-c(as.character(usedfeaturesSubset), "subject", "activity" )
finalData<-subset(finalData,select=usedNames)
head(finalData)

#describe/label properly following work above
names(finalData)<-gsub("^t", "Time", names(finalData))
names(finalData)<-gsub("Mag", "Magnitude", names(finalData))
names(finalData)<-gsub("^f", "Freq", names(finalData))
names(finalData)<-gsub("Acc", "Acceleration", names(finalData))

#tidy data with average
library(plyr)
tidyData<-aggregate(. ~subject + activity, finalData, mean)
tidyData<-tidyData[order(tidyData$activity,tidyData$subject),]

write.table(tidyData, "tidyDataExercise.txt", row.name = FALSE)
