# run.analysis.R CodeBook 
The run_analysis.R performs the following tasks in order to process the raw data set to tidy data set:

## Preparation Steps
### 1. Download data.
The data is available at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### 2. Read and store data into variables.
The following variables are created:
- `features`		561 rows, 2 columns
- `subject_test`		2947 rows, 1 column
- `subject_train`		7352 rows, 1 column
- `x_test`		2947 rows, 1 column
- `x_train`		7352 rows, 1 column
- `y_test`		2947 rows, 1 column
- `y_train`		7352 rows, 1 column
- `activities_lables`	6 rows, 2 columns

## Processing Steps
### 1. Merges the training and the test sets to create one data set.
The code uses `rbind()` to merge `_train` and `_test data`, then uses `cbind()` to merge new columns. The output is an 10299 rows by 563 columns data frame called `total`.

### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
`select` the measurements on the mean and standard deviation. The selected variables from `total` are stored in a data frame called `tidy`

### 3. Uses descriptive activity names to name the activities in the data set.
Numbers are replaced by corresponding activity names, which is stored in the variable `activity_lables` 

### 4. Appropriately labels the data set with descriptive variable names.
Abbreviations are replaced by full and descriptive variable names:
| Abbreviation name | Descriptive name |
|-------------------|------------------|
|`t`|`Time`|
|`f`|`Frequency`|
|`tBody`|`TimeBody`|
|`Acc`|`Accelerometer`|
|`Gyro`|`Gyroscope`|
|`BodyBody`|`Body`|
|`Mag`|`Magnitude`|
|`-mean()`|`Mean`|
|`-std()`|`STD`|
|`-freq()`|`Frequency`|
|`angle`|`Angle`|
|`gravity`|`Gravity`|

Also renames the second column `code`	 to `activity`.

### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Groups the data frame `tidy` by variable `subject` and `activity`. Calculates the mean of each variable for each activity and each subject.
Stores the new output into variable `avg_data` and exports data into `avg_data.txt`.
