# run_analysis.R
# place files in Path or Set Path mit setwd("<yourPathHere>")

##PreSet
setwd("C:\\Temp\\coursera\\UCI HAR Dataset")
packages <- c("data.table", "reshape2")
#Control
sapply(packages, require, character.only = TRUE, quietly = TRUE)


##Load All Files

dt_Subject_Train <- read.table("train\\subject_train.txt",header=FALSE)
dt_Subject_Test <- read.table("test\\subject_test.txt",header=FALSE)

dt_Y_Train <- read.table("train\\Y_train.txt",header=FALSE)
dt_Y_Test <- read.table("test\\Y_test.txt",header=FALSE)

dt_X_Train <- read.table("train\\X_train.txt",header=FALSE)
dt_X_Test <- read.table("test\\X_test.txt",header=FALSE)


dt_Features <- read.table("features.txt",header=FALSE)
dt_Activity_labels <- read.table("activity_labels.txt",header=FALSE);



## Name COlumns
colnames(dtActivity_labels)  = c('activityId','activityType');
colnames(dtTrain)        = dtFeatures[,2]; 
colnames(yTrain)        = "activityId";
colnames(subjectTrain)  = "subjectId";


##Merges the training and the test sets to create one data set.
dtSubject <- rbind(dtSubjectTrain, dtSubjectTest)
dtActivity <- rbind(dtActivityTrain, dtActivityTest)

#fread .... Error so i try an other way over ReadTable dataTable



setnames(dtSubject, "V1", "subject")

setnames(dtActivity, "V1", "activityNum")
dt <- rbind(dtTrain, dtTest)

dtSubject <- cbind(dtSubject, dtActivity)
dt <- cbind(dtSubject, dt)
setkey(dt, subject, activityNum)

##Extracts only the measurements on the mean and standard deviation for each measurement. 






##Uses descriptive activity names to name the activities in the data set



##Appropriately labels the data set with descriptive variable names. 



## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
