# GettingAndCleaningData

Abschlussarbeit des Coursera-Kurses "Getting and Cleaning Data". Das Skript `run_analysis.R` bereitet den Datensatz
[Human Activity Recognition Using Smartphones](https://archive.ics.uci.edu/dataset/240/human+activity+recognition+using+smartphones)
(UCI HAR Dataset, Beschleunigungs- und Gyroskopdaten von 30 Personen) auf.

## Verwendung

1. Datensatz herunterladen und entpacken.
2. In R das Arbeitsverzeichnis auf den Ordner `UCI HAR Dataset` setzen (`setwd(...)`).
3. Die Pakete `data.table` und `reshape2` installieren.
4. `source("run_analysis.R")` ausführen. Das Ergebnis liegt in `tidy_data.txt`.

## Was das Skript tut

1. Trainings- und Testdaten (`X`, `Y`, `subject`) laden und zu einem Datensatz zusammenführen.
2. Nur die Messgrössen mit Mittelwert (`Mean`) und Standardabweichung (`Std`) behalten.
3. Die Aktivitäts-IDs 1 bis 6 durch Namen ersetzen (Walking, Walking upstairs, ...).
4. Variablennamen bereinigen (`-mean()` wird zu `Mean`, Klammern und Bindestriche entfallen).
5. Pro Person und Aktivität den Mittelwert jeder Variable berechnen und als `tidy_data.txt` speichern (180 Zeilen: 30 Personen mal 6 Aktivitäten).

Die Beschreibung der Variablen steht in `CodeBook.txt`.

Hinweis: Die Pfade im Skript sind mit Backslash geschrieben (Windows).
