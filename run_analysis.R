require(plyr)

# Files and filepaths
data_root <- "UCI\ HAR\ Dataset"
feature_file <- paste0(data_root, "/features.txt")
activity_labels_file <- paste0(data_root, "/activity_labels.txt")
x_train_file <- paste0(data_root, "/train/X_train.txt")
y_train_file <- paste0(data_root, "/train/y_train.txt")
subject_train_file <- paste0(data_root, "/train/subject_train.txt")
x_test_file  <- paste0(data_root, "/test/X_test.txt")
y_test_file  <- paste0(data_root, "/test/y_test.txt")
subject_test_file <- paste0(data_root, "/test/subject_test.txt")



# Load raw data
features <- read.table(feature_file, colClasses = c("character"))
activity_labels <- read.table(activity_labels_file, col.names = c("ActivityId", "Activity"))
x_train <- read.table(x_train_file)
y_train <- read.table(y_train_file)
subject_train <- read.table(subject_train_file)
x_test <- read.table(x_test_file)
y_test <- read.table(y_test_file)
subject_test <- read.table(subject_test_file)

#====================================================================#
# STEP 1. Merges the training and the test sets to create one data   #
#         set.                                                       #
#                                                                    #
#    This is done by first combining the x and y data sets into      #
#    train_data & test_data and then combining the training and      #
#    test data sets into a single data set before finally adding     #
#    labels to data set.                                             #
#====================================================================#

training_data <- cbind(cbind(x_train, subject_train), y_train)
test_data <- cbind(cbind(x_test, subject_test), y_test)
combined_data <- rbind(training_data, test_data)

data_labels <- rbind(rbind(features, c(562, "Subject")), c(563, "ActivityId"))[,2]
names(combined_data) <- data_labels

#====================================================================#
# STEP 2. Extract only the measurements on the mean and standard     #
#         deviation for each measurement.                            #
#                                                                    #              
#   This is done using grep1 as the column names identify which      #
#   field contain mean and std information                           #
#====================================================================#

data_mean_std <- combined_data[,grepl("mean|std|Subject|ActivityId", names(combined_data))]

#====================================================================#
# STEP 3. Uses descriptive activity names to name the activities in  # 
#         the data set.                                              #
#                                                                    #
#   This is done using the plyr function join and then removes the   #
#   old activityId                                                   #
#====================================================================#

data_mean_std <- join(data_mean_std, activity_labels, by = "ActivityId", match = "first")
data_mean_std <- data_mean_std[,-1]

#====================================================================#
# STEP 4. Appropriately labels the data set with descriptive names.  #
#                                                                    #
#    This is done using regex with gsub to remove brackets then      #
#    make.names to make sure names are valid and finally a number of #
#    gsub to provide more  meaningful names                          #
#====================================================================#

names(data_mean_std) <- gsub('\\(|\\)',"",names(data_mean_std), perl = TRUE)  
names(data_mean_std) <- make.names(names(data_mean_std))  
names(data_mean_std) <- gsub('Acc',"Acceleration",names(data_mean_std))
names(data_mean_std) <- gsub('GyroJerk',"AngularAcceleration",names(data_mean_std))
names(data_mean_std) <- gsub('Gyro',"AngularSpeed",names(data_mean_std))
names(data_mean_std) <- gsub('Mag',"Magnitude",names(data_mean_std))
names(data_mean_std) <- gsub('^t',"TimeDomain.",names(data_mean_std))
names(data_mean_std) <- gsub('^f',"FrequencyDomain.",names(data_mean_std))
names(data_mean_std) <- gsub('\\.mean',".Mean",names(data_mean_std))
names(data_mean_std) <- gsub('\\.std',".StandardDeviation",names(data_mean_std))
names(data_mean_std) <- gsub('Freq\\.',"Frequency.",names(data_mean_std))
names(data_mean_std) <- gsub('Freq$',"Frequency",names(data_mean_std))


#====================================================================#
# STEP 5. From the data set in STEP 4, creates a second, independent #
#         tidy data set with the average of each variable for each   #
#         activity and each subject.                                 #
#                                                                    #
#     This is done using the plyr function ddply with the function   #
#     numcolwise to apply the mean                                   #
#                                                                    #
#     Write this dataset to a txt file                               #
#====================================================================#

avg_by_activity_subject = ddply(data_mean_std, c("Subject","Activity"), numcolwise(mean))
write.table(avg_by_activity_subject , file = "avg_by_activity_subject.txt")


#Cleanup Temporary Variables
rm("x_train")
rm("y_train")
rm("x_test")
rm("y_test")
rm("training_data")
rm("test_data")
rm("subject_train")
rm("subject_test")
rm("data_labels")
