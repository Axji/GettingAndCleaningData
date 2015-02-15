# run_analysis.R
# place files in Path or Set Path mit setwd("<yourPathHere>")

##Merges the training and the test sets to create one data set.

dtSubjectTest <- fread("test\\subject_test.txt")
dtSubjectTrain <- fread("train\\subject_train.txt")
dtActivityTrain <- fread("train\\Y_train.txt")
dtActivityTest <- fread("test\\Y_test.txt")
#fread .... Error so i try an other way over ReadTable dataTable
dtTrain <- data.table(read.table("train\\X_train.txt"))
dtTest <- data.table(read.table("test\\X_test.txt"))

dtSubject <- rbind(dtSubjectTrain, dtSubjectTest)
setnames(dtSubject, "V1", "subject")
dtActivity <- rbind(dtActivityTrain, dtActivityTest)
setnames(dtActivity, "V1", "activityNum")
dt <- rbind(dtTrain, dtTest)

##Extracts only the measurements on the mean and standard deviation for each measurement. 

##Uses descriptive activity names to name the activities in the data set

##Appropriately labels the data set with descriptive variable names. 

## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
