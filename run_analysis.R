# run_analysis.R
# place files in Path or Set Path mit setwd("<yourPathHere>")
dtSubjectTest <- fread("test\\subject_test.txt")
dtSubjectTrain <- fread("train\\subject_train.txt")
dtActivityTrain <- fread("train\\Y_train.txt")
dtActivityTest <- fread("test\\Y_test.txt")
#fread .... Error so i try an other way over ReadTable dataTable
tTrain <- data.table(read.table("train\\X_train.txt"))
dtTest <- data.table(read.table("test\\X_test.txt"))

dtSubject <- rbind(dtSubjectTrain, dtSubjectTest)
setnames(dtSubject, "V1", "subject")
dtActivity <- rbind(dtActivityTrain, dtActivityTest)
setnames(dtActivity, "V1", "activityNum")
dt <- rbind(dtTrain, dtTest)
