# run_analysis.R
# place files in Path or Set Path mit setwd("<yourPathHere>")

##PreSet
setwd("C:\\Temp\\coursera\\UCI HAR Dataset")
packages <- c("data.table", "reshape2")
#Control
sapply(packages, require, character.only = TRUE, quietly = TRUE)



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

> dtSubject <- cbind(dtSubject, dtActivity)
> dt <- cbind(dtSubject, dt)
> setkey(dt, subject, activityNum)

##Extracts only the measurements on the mean and standard deviation for each measurement. 
dtFeatures <- fread("features.txt")
setnames(dtFeatures, names(dtFeatures), c("featureNum", "featureName"))

dtFeatures <- dtFeatures[grepl("mean\\(\\)|std\\(\\)", featureName)]

dtFeatures$featureCode <- dtFeatures[, paste0("V", featureNum)]
select <- c(key(dt), dtFeatures$featureCode)
dt <- dt[, select, with = FALSE]





##Uses descriptive activity names to name the activities in the data set
dtActivityNames <- fread("activity_labels.txt")
setnames(dtActivityNames, names(dtActivityNames), c("activityNum", "activityName"))


##Appropriately labels the data set with descriptive variable names. 
dt <- merge(dt, dtActivityNames, by = "activityNum", all.x = TRUE)
setkey(dt, subject, activityNum, activityName)
dt <- data.table(melt(dt, key(dt), variable.name = "featureCode"))
dt <- merge(dt, dtFeatures[, list(featureNum, featureCode, featureName)], by = "featureCode", 
    all.x = TRUE)
    
dt$activity <- factor(dt$activityName)
dt$feature <- factor(dt$featureName)


## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
