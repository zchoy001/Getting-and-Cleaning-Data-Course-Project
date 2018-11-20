## Download and extract the files in the working directory
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
f <- file.path(getwd(), "UCIData.zip")
download.file(url,f, mode = "wb") 

## Unzip the downloaded file
unzip("UCIdata.zip", files = NULL, exdir=".")

##Read the data from the files into R
dataSubjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
dataSubjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
dataFeaturesTest <- read.table("UCI HAR Dataset/test/X_test.txt")
dataFeaturesTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
dataActivityTest <- read.table("UCI HAR Dataset/test/y_test.txt")
dataActivityTrain <- read.table("UCI HAR Dataset/train/y_train.txt")
dataFeaturesNames <- read.table("UCI HAR Dataset/features.txt")
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")


## Merges the training and test data sets
dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity<- rbind(dataActivityTrain, dataActivityTest)
dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)

## descriptive activity names to name the activities in the data set
names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
names(dataFeatures)<- dataFeaturesNames$V2

## Merge columns of the data to a consolidated data frame
dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)

## Subset Name of Features by measurements on the mean and standard deviation
subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

##subset the data by selected names of Features
selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )


## Facorize Variale `activity` in  the data frame `Data` using  descriptive activity names** 
  
Data$activity<-factor(Data$activity);
Data$activity<- factor(Data$activity,labels=as.character(activityLabels$V2))

## Appropriately labels the data set with descriptive variable names
#- prefix t  is replaced by  time
#- Acc is replaced by Accelerometer
#- Gyro is replaced by Gyroscope
#- prefix f is replaced by frequency
#- Mag is replaced by Magnitude
#- BodyBody is replaced by Body

names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

## Creates a second,independent tidy data set and ouput it
#In this part,a second, independent tidy data set will be created with the average 
#of each variable for each activity and each subject  based on the data set in step 4. 

library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)