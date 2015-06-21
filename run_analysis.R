# check if the required packages are installed and load them
if(!require("data.table")) {
    install.packages("data.table")
    require("data.table")
}

if(!require("dplyr")) {
    install.packages("dplyr")
    require("dplyr")
}

# read the feature names
featureNames <- read.table("UCI HAR Dataset/features.txt")[,2]

# read the activity labels
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)

# read the training data
subjectTraining <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activityTraining <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
featuresTraining <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)

# read the test data
subjectTesting <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activityTesting <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
featuresTesting <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)

# Part 1: Merging the data

# combine training and test data
subjectTotal <- bind_rows(subjectTraining, subjectTesting)
activityTotal <- bind_rows(activityTraining, activityTesting)
featuresTotal <- bind_rows(featuresTraining, featuresTesting)

# naming the columns
colnames(featuresTotal) <- featureNames
colnames(activityTotal) <- "Activity"
colnames(subjectTotal) <- "Subject"

# stick columns together to form the complete dataset
totalData <- bind_cols(subjectTotal, activityTotal, featuresTotal)

# Part 2: Extracting the mean and the std for each measurements
meanStdColumns <- grep("*mean*|*std*", names(totalData), ignore.case = TRUE)
meanStdData <- totalData[, c(1, 2, meanStdColumns)]

# Part 3: Un-coding activity column as factors
for (index in seq_along(activityLabels[,1])) {
    meanStdData$Activity[meanStdData$Activity == index] <- as.character(activityLabels[index, 2])
}
meanStdData$Activity <- as.factor(meanStdData$Activity)



# Part 4: Apprimate descriptive names for the variables
names(meanStdData) <- gsub("\\(\\)", "", names(meanStdData))
names(meanStdData) <- gsub("-mean", "Mean", names(meanStdData))
names(meanStdData) <- gsub("-std", "STD", names(meanStdData))
names(meanStdData) <- gsub("^t", "Time", names(meanStdData))
names(meanStdData) <- gsub("^f|Freq", "Frequency", names(meanStdData))
names(meanStdData) <- gsub("Acc", "Accelerometer", names(meanStdData))
names(meanStdData) <- gsub("Gyro", "Gyroscope", names(meanStdData))
names(meanStdData) <- gsub("Mag", "Magnitude", names(meanStdData))
names(meanStdData) <- gsub("BodyBody", "Body", names(meanStdData))
names(meanStdData) <- gsub("\\(t", "(Time", names(meanStdData))
names(meanStdData) <- gsub("gravity", "Gravity", names(meanStdData))
names(meanStdData) <- gsub("Mean),", "Mean,", names(meanStdData))

# Part 5: Creating another dataset with average of each variable for each
#         activity and each subject
tidyData <- aggregate(. ~ Subject + Activity, data = meanStdData, mean)
write.table(tidyData, file = "TidyData.txt", row.names = FALSE)




