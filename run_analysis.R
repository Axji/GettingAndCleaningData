# run_analysis.R
# Bereitet den "UCI HAR Dataset" (Human Activity Recognition Using Smartphones) auf und berechnet den
# Mittelwert jeder Messgrösse je Person und Aktivität.
#
# Aufruf auf der Kommandozeile (schreibt tidy_data.txt):
#   Rscript run_analysis.R [Pfad/zu/UCI HAR Dataset]
# Aufruf in R:
#   source("run_analysis.R"); tidy <- run_analysis()
#
# Ohne Pfad wird der Ordner "UCI HAR Dataset" im aktuellen Verzeichnis verwendet und bei Bedarf heruntergeladen.

library(reshape2)

DATA_URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Ordner mit den Daten bestimmen und die Daten bei Bedarf herunterladen
find_data_dir <- function(path = NULL) {
  if (!is.null(path)) {
    return(path)
  }
  dir <- "UCI HAR Dataset"
  if (!dir.exists(dir)) {
    zip_file <- tempfile(fileext = ".zip")
    download.file(DATA_URL, zip_file, mode = "wb")
    unzip(zip_file, exdir = ".")
  }
  dir
}

# Liest X (Messwerte), y (Aktivität) und subject (Person) eines Teils ("train" oder "test") und setzt sie nebeneinander
read_part <- function(dir, part, features) {
  read <- function(name) {
    read.table(file.path(dir, part, paste0(name, "_", part, ".txt")), header = FALSE)
  }
  x <- read("X")
  colnames(x) <- features
  data.frame(subjectId = read("subject")[, 1], activityId = read("y")[, 1], x, check.names = FALSE)
}

# Macht aus den Kürzeln der Originalnamen lesbare Namen (tBodyAcc-mean()-X wird zu timeBodyAccelerometerMeanX).
# "BodyBody" bleibt wie im Original stehen, sonst gäbe es doppelte Namen (fBodyAccJerkMag und fBodyBodyAccJerkMag).
clean_names <- function(names) {
  names <- gsub("-mean\\(\\)", "Mean", names)
  names <- gsub("-std\\(\\)", "Std", names)
  names <- gsub("-", "", names)
  names <- gsub("^t", "time", names)
  names <- gsub("^f", "frequency", names)
  names <- gsub("Acc", "Accelerometer", names)
  names <- gsub("Gyro", "Gyroscope", names)
  names <- gsub("Mag", "Magnitude", names)
  names
}

run_analysis <- function(path = NULL) {
  dir <- find_data_dir(path)

  features <- read.table(file.path(dir, "features.txt"), header = FALSE, stringsAsFactors = FALSE)[, 2]
  activities <- read.table(file.path(dir, "activity_labels.txt"), header = FALSE, stringsAsFactors = FALSE)
  colnames(activities) <- c("activityId", "activity")

  # 1. Trainings- und Testdaten zu einem Datensatz zusammenführen
  all_data <- rbind(read_part(dir, "train", features), read_part(dir, "test", features))

  # 2. Nur Mittelwert (mean()) und Standardabweichung (std()) behalten. meanFreq() und die angle()-Variablen
  #    gehören nicht dazu.
  keep <- grepl("-(mean|std)\\(\\)", features)
  all_data <- all_data[, c(TRUE, TRUE, keep)]

  # 3. Aktivitäts-IDs durch Namen ersetzen
  all_data <- merge(all_data, activities, by = "activityId")
  all_data$activityId <- NULL

  # 4. Variablennamen lesbar machen
  measure_cols <- setdiff(colnames(all_data), c("subjectId", "activity"))
  clean_cols <- clean_names(measure_cols)
  stopifnot(!anyDuplicated(clean_cols))
  colnames(all_data)[match(measure_cols, colnames(all_data))] <- clean_cols

  # 5. Mittelwert jeder Variable je Person und Aktivität
  melted <- melt(all_data, id.vars = c("subjectId", "activity"), measure.vars = clean_cols)
  dcast(melted, subjectId + activity ~ variable, mean)
}

# Nur ausführen, wenn das Skript mit Rscript gestartet wird (nicht bei source())
if (sys.nframe() == 0) {
  args <- commandArgs(trailingOnly = TRUE)
  tidy <- run_analysis(if (length(args) > 0) args[1] else NULL)
  write.table(tidy, file = "tidy_data.txt", row.names = FALSE)
  message("tidy_data.txt geschrieben: ", nrow(tidy), " Zeilen, ", ncol(tidy), " Spalten")
}
