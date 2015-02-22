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


## Name COlumns

colnames(dt_X_Train)        = dt_Features[,2]; 
colnames(dt_X_Test)        = dt_Features[,2]; 

colnames(dt_Y_Train)        = "activityId";
colnames(dt_Y_Test)        = "activityId";

colnames(dt_Subject_Train)  = "subjectId";
colnames(dt_Subject_Test)  = "subjectId";




##Merges the training and the test sets to create one data set.
dt_Train = cbind(dt_X_Train, dt_Y_Train, dt_Subject_Train)
dt_Test = cbind(dt_X_Test, dt_Y_Test, dt_Subject_Test)

dt_All <- rbind(dt_Train, dt_Test)




##Extracts only the measurements on the mean and standard deviation for each measurement. 
dt_Features[,2] = gsub('-mean', 'Mean', dt_Features[,2])
dt_Features[,2] = gsub('-std', 'Std', dt_Features[,2])
dt_Features[,2] = gsub('[-()]', '', dt_Features[,2])
columns <- grep(".*Mean.*|.*Std.*", dt_Features[,2])
dt_Features <- dt_Features[columns,] 
columns <- c(columns, 562, 563)
dt_All <- dt_All[,columns] 




##Uses descriptive activity names to name the activities in the data set
dt_Activity_labels <- read.table("activity_labels.txt",header=FALSE);

#I tried with a For Loop and dt_Activity_Labels ... but had no success (there are only 6 Values => )
dt_All$activityId <- gsub(1, "Walking", dt_All$activityId)
dt_All$activityId <- gsub(2, "WALKING_UPSTAIRS", dt_All$activityId)
dt_All$activityId <- gsub(3, "WALKING_DOWNSTAIRS", dt_All$activityId)
dt_All$activityId <- gsub(4, "SITTING", dt_All$activityId)
dt_All$activityId <- gsub(5, "STANDING", dt_All$activityId)
dt_All$activityId <- gsub(6, "LAYING", dt_All$activityId)


## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
IDs   = c("subjectId", "activityId")
data_labels = setdiff(colnames(dt_All), IDs)
melted_data = melt(dt_All, id = IDs, measure.vars = data_labels)
tidy = dcast(melted_data, subjectId + activityId ~ variable, mean)

write.table(tidy, file = "tidy_data.txt")
