library(plyr)
library(dplyr)
 
features <- read.table("./data/features.txt")
activity_labels <- read.table("./data/activity_labels.txt")
# 1.Merges the training and the test sets to create one data set.
x_train <- read.table("./data/train/X_train.txt")
y_train <- read.table("./data/train/y_train.txt") #  activity codes
subject_train <-  read.table("./data/train/subject_train.txt") # subject numbers
x_train$label <- y_train
x_train$subject <- subject_train

x_test <- read.table("./data/test/X_test.txt")
y_test <- read.table("./data/test/y_test.txt") #  activity codes
subject_test <-  read.table("./data/test/subject_test.txt") # subject numbers
x_test$label <- y_test$V1
x_test$subject <- subject_test$V1

merged_data <- merge(x_test, y_test, all=TRUE)

# 2.Extracts only the measurements on the mean and standard deviation for each measurement.
#merged_data %>% group_by(merged_data$subject, merged_data$label) %>% summarise_each(funs(mean), contains("mean()"), contains("std()"))

# 3.Uses descriptive activity names to name the activities in the data set
merged_data$label[merged_data$label == 1] <- "WALKING"
merged_data$label[merged_data$label == 2] <- "WALKING_UPSTAIRS"
merged_data$label[merged_data$label == 3] <- "WALKING_DOWNSTAIRS"
merged_data$label[merged_data$label == 4] <- "SITTING"
merged_data$label[merged_data$label == 5] <- "STANDING"
merged_data$label[merged_data$label == 6] <- "LAYING"

# 4.Appropriately labels the data set with descriptive variable names. 
feature_columns <- as.vector(features$V2)
columns <- c(feature_columns, c("activity", "subject"))
colnames(merged_data) <- columns

# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
aggregated_data <- aggregate(merged_data[,1:561], list(merged_data$activity, merged_data$subject), mean)
aggregated_columns <- c(c("activity", "subject"), feature_columns)
colnames(aggregated_data) <- aggregated_columns




