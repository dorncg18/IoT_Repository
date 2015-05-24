#Get activity labels, will use these to paste a column of activities. Numbers are already included in train & test data
setwd("C:/Users/Dorn/R Programming/UCI HAR Dataset")
activity_labels <-read.delim("activity_labels.txt", header = FALSE, sep = "")
colnames(activity_labels) <- c("Number", "Activity")

#import test data
setwd("C:/Users/Dorn/R Programming/UCI HAR Dataset/test")
xtest <- read.delim("X_test.txt", header = FALSE, sep = "")
ytest <- read.delim("Y_test.txt", header = FALSE, sep = "")
colnames(ytest) <- c("Number")
#Redefine ytest with training labels, instead of just numbers
ytest <- join(ytest, activity_labels, by = "Number")
subject_test <- read.delim("subject_test.txt", header = FALSE, sep = "")

#Subject test lists which participant is performing the activity
subjectxy_test_data <- cbind(subject_test, ytest, xtest)
colnames(subjectxy_test_data)[1]<-c("Subject")
rm(subject_test, xtest, ytest)

#import train data
setwd("C:/Users/Dorn/R Programming/UCI HAR Dataset/train")
xtrain <- read.delim("X_train.txt", header = FALSE, sep = "")
ytrain <- read.delim("y_train.txt", header = FALSE, sep = "")
colnames(ytrain) <- c("Number")
#Redefine ytrain with training labels, instead of just numbers
ytrain <- join(ytrain, activity_labels, by = "Number")
subject_train <- read.delim("subject_train.txt", header = FALSE, sep ="")
subjectxy_train_data <- cbind(subject_train, ytrain, xtrain)
colnames(subjectxy_train_data)[1]<-c("Subject")
rm(subject_train, xtrain, ytrain)

#Combine all test and train data together
combined_data <- rbind(subjectxy_test_data, subjectxy_train_data)
rm(subjectxy_test_data, subjectxy_train_data, activity_labels)
combined_data <- arrange(combined_data, Subject, Number)

#Functions below provide average and standard deviations for each variable measurement by subject and by activity
Summarized_data_mean <- combined_data %>% group_by(Subject, Number) %>% summarise_each(funs(mean))
Summarized_data_sd <- combined_data %>% group_by(Subject, Number) %>% summarise_each(funs(sd))
