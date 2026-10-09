# CodeBook für tidy_data.txt

`tidy_data.txt` wird von `run_analysis.R` erzeugt. Quelle ist der Datensatz
[Human Activity Recognition Using Smartphones](https://archive.ics.uci.edu/dataset/240/human+activity+recognition+using+smartphones)
(30 Personen tragen ein Smartphone am Gürtel, das Beschleunigung und Drehgeschwindigkeit misst).

## Aufbau

- 180 Zeilen: 30 Personen mal 6 Aktivitäten
- 68 Spalten: `subjectId`, `activity` und 66 Messgrössen
- Eine Zeile pro Person und Aktivität, die Messgrössen sind jeweils der **Mittelwert** aller Messungen dieser Kombination
- Leerzeichen-getrennte Textdatei mit Kopfzeile, einlesbar mit `read.table("tidy_data.txt", header = TRUE)`

## Kennungen

| Variable | Werte | Bedeutung |
|---|---|---|
| `subjectId` | 1 bis 30 | Nummer der Person |
| `activity` | WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING | Aktivität während der Messung (aus `activity_labels.txt`) |

## Messgrössen

Alle Werte sind auf den Bereich −1 bis 1 normiert und haben deshalb keine Einheit. Die Beschleunigung wurde in der
Quelle in der Einheit *g* gemessen, die Drehgeschwindigkeit in *rad/s*. Die Namen setzen sich so zusammen:

`<Bereich><Signal><Achse oder Betrag><Statistik>` zum Beispiel `timeBodyAccelerometerMeanX`

| Teil | Werte | Bedeutung |
|---|---|---|
| Bereich | `time`, `frequency` | `time`: Zeitbereich (Rohsignal, mit 50 Hz gemessen). `frequency`: mit Fourier-Transformation in den Frequenzbereich umgerechnet |
| Signal | `BodyAccelerometer`, `GravityAccelerometer`, `BodyAccelerometerJerk`, `BodyGyroscope`, `BodyGyroscopeJerk` | Beschleunigung des Körpers, Erdbeschleunigung (Schwerkraftanteil), jeweils Ableitung nach der Zeit (`Jerk`) und Drehgeschwindigkeit |
| Betrag | `Magnitude` | Länge des 3D-Vektors (`sqrt(x² + y² + z²)`), dann ohne Achse |
| Achse | `X`, `Y`, `Z` | Richtung der Messung |
| Statistik | `Mean`, `Std` | Mittelwert und Standardabweichung der ursprünglichen Messfenster (je 2,56 Sekunden) |

Insgesamt gibt es 66 Messgrössen: 33 Signale mal die zwei Statistiken `Mean` und `Std`.

Zeitbereich (je X, Y, Z mit `Mean` und `Std`): `timeBodyAccelerometer`, `timeGravityAccelerometer`,
`timeBodyAccelerometerJerk`, `timeBodyGyroscope`, `timeBodyGyroscopeJerk`. Dazu ohne Achse: `timeBodyAccelerometerMagnitude`,
`timeGravityAccelerometerMagnitude`, `timeBodyAccelerometerJerkMagnitude`, `timeBodyGyroscopeMagnitude`,
`timeBodyGyroscopeJerkMagnitude`.

Frequenzbereich (je X, Y, Z): `frequencyBodyAccelerometer`, `frequencyBodyAccelerometerJerk`, `frequencyBodyGyroscope`.
Ohne Achse: `frequencyBodyAccelerometerMagnitude`, `frequencyBodyBodyAccelerometerJerkMagnitude`,
`frequencyBodyBodyGyroscopeMagnitude`, `frequencyBodyBodyGyroscopeJerkMagnitude`. Der Namensteil `BodyBody` steht schon
so im Original.

## Aufbereitung

1. Trainings- (7352 Zeilen) und Testdaten (2947 Zeilen) zu 10299 Messungen zusammengeführt
2. Nur die Variablen mit `mean()` und `std()` behalten. `meanFreq()` und die `angle(...)`-Variablen fehlen absichtlich,
   weil sie keine Mittelwerte oder Standardabweichungen der Messung selbst sind
3. Aktivitätsnummern durch Namen ersetzt
4. Namen lesbar gemacht: `t` wird `time`, `f` wird `frequency`, `Acc` wird `Accelerometer`, `Gyro` wird `Gyroscope`,
   `Mag` wird `Magnitude`, `-mean()` wird `Mean`, `-std()` wird `Std`, Bindestriche und Klammern entfallen
5. Mittelwert je Person und Aktivität berechnet
