# PREP: 
# Download data.
filename <- "experiments.zip"

# Download if not already exist
if (!file.exists(filename)){
    fileUrl <- "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones"
    download.file(fileUrl, filename)
}

# Unzip if not already exist
if (!file.exists("UCI HAR Dataset")){
    unzip(filename)
}

# Read all data into R and store in variables.
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
activity_lables <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

# REQUIREMENTS:
# 1. Merges the training and the test sets to create one data set.
total <- cbind(rbind(subject_train, subject_test), rbind(x_train, x_test), rbind(y_train, y_test))

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
library(dplyr) #We will need select function from dplyr.
tidy <- select(total, subject, code, contains("mean"), contains("std"))

# 3. Uses descriptive activity names to name the activities in the data set.
tidy$code <- activity_lables[total$code, 2]

# 4. Appropriately labels the data set with descriptive variable names.
colnames(tidy) <- gsub("^t", "Time", names(tidy))
colnames(tidy) <- gsub("^f", "Frequency", names(tidy))
colnames(tidy) <- gsub("tBody", "TimeBody", names(tidy))
colnames(tidy) <- gsub("Acc", "Accelerometer", names(tidy))
colnames(tidy) <- gsub("Gyro", "Gyroscope", names(tidy))
colnames(tidy) <- gsub("BodyBody", "Body", names(tidy))
colnames(tidy) <- gsub("Mag", "Magnitude", names(tidy))
colnames(tidy) <- gsub("-mean()", "Mean", names(tidy), ignore.case = TRUE)
colnames(tidy) <- gsub("-std()", "STD", names(tidy), ignore.case = TRUE)
colnames(tidy) <- gsub("-freq()", "Frequency", names(tidy), ignore.case = TRUE)
colnames(tidy) <- gsub("angle", "Angle", names(tidy))
colnames(tidy) <- gsub("gravity", "Gravity", names(tidy))
names(tidy)[2] = "activity"

# 5. From the data set in step 4, creates a second, independent tidy data set with
#the average of each variable for each activity and each subject.
avg_data <- tidy %>%
    group_by(subject, activity) %>%
    summarise_all(funs(mean))
write.table(avg_data, "avg_data.txt", row.name=FALSE)
