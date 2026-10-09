# GettingAndCleaningData

Abschlussarbeit des Coursera-Kurses "Getting and Cleaning Data". Das Skript `run_analysis.R` bereitet den Datensatz
[Human Activity Recognition Using Smartphones](https://archive.ics.uci.edu/dataset/240/human+activity+recognition+using+smartphones)
(UCI HAR Dataset, Beschleunigungs- und Gyroskopdaten von 30 Personen) auf.

## Verwendung

Voraussetzung: R mit dem Paket `reshape2` (`install.packages("reshape2")`).

```bash
Rscript run_analysis.R                    # lädt den Datensatz bei Bedarf herunter
Rscript run_analysis.R "C:/Daten/UCI HAR Dataset"   # oder einen vorhandenen Ordner angeben
```

Das Ergebnis liegt in `tidy_data.txt`. In R geht es auch so:

```r
source("run_analysis.R")
tidy <- run_analysis()
```

## Was das Skript tut

1. Trainings- und Testdaten (`X`, `y`, `subject`) laden und zu einem Datensatz zusammenführen
2. Nur die Messgrössen mit Mittelwert (`mean()`) und Standardabweichung (`std()`) behalten (66 Stück)
3. Die Aktivitätsnummern 1 bis 6 mit `activity_labels.txt` durch Namen ersetzen
4. Variablennamen lesbar machen (zum Beispiel `timeBodyAccelerometerMeanX`)
5. Pro Person und Aktivität den Mittelwert jeder Variable berechnen (180 Zeilen: 30 Personen mal 6 Aktivitäten)

Die Beschreibung aller Variablen steht in [CodeBook.md](CodeBook.md).

## Hinweis

Das Skript wurde ohne R-Installation überarbeitet und noch nicht ausgeführt. Bitte einmal laufen lassen und prüfen,
ob `tidy_data.txt` 180 Zeilen und 68 Spalten hat.
