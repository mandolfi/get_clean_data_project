## Basically I used the approach described at: 
##  points 1-4: https://class.coursera.org/getdata-002/forum/thread?thread_id=291#post-1233
##  points   5: https://class.coursera.org/getdata-002/forum/thread?thread_id=146#post-516
#
#
# My approach is: 
######### for every file
## a. load the features 
## b. filter the features-names getting only the one for "mean" and "std"
## c. load the activities labels
######### for the train files
## d. load all the files concerning the Train data set
## e. apply the filter on the X_train data set, get only the columns for "mean" and "std"
## f. give proper column names to the train set
## g. merging the activity id with the correspondent name
## h. Combine all the files for the "train" and create one final big train set
######### for the test files
## i. load all the files concerning the Test data set
## j. apply the filter on the X_test data set, get only the columns for "mean" and "std"
## k. give proper column names to the test set
## m. merging the activity id with the correspondent name
## n. Combine all the files for the "train" and create one final big train set
######### creation of final tidy set
## o. combine all the dataset. Reaching the temp tidy set
## p. create the grouped table for the temp tidy_set
## q. Writing the final tidy set

# in between I have removed repeatedly unused variables, in order to keep a low
# usage of the memory (I have a small machine).



###### step a.
## a. load the features 
#
# load the features first
fileLocation <- "features.txt";
features <- read.table(fileLocation);



###### step b.
## b. filter the features-names getting only the one for "mean" and "std"
#
# Obtain the list of features I want to consider. 
# From the assignment I read: 
#   "2. Extracts only the measurements on the mean and standard deviation for each measurement. "
#  Therefore I took only features with substrings "-mean()" and "-std()".
#  NOTATION: Varbiables with postfix "_f" are meant to be "filtered".
idx_mean <- grep("-mean()", as.vector(features$V2), fixed = TRUE);
idx_std  <- grep("-std()",  as.vector(features$V2), fixed = TRUE);
idx <- union(idx_mean, idx_std);
idx <- sort(idx);
features_f <- as.vector(features$V2);
features_f <- features_f[idx];



###### step c.
## c. load the activities labels
#
#load then the activity labels file
fileLocation    <- "activity_labels.txt";
activity        <- read.table(fileLocation);
names(activity) <- c("Activity_id", "Activity_name");


####### Clean up memory no more needed; 
rm(idx_mean);
rm(idx_std);
rm(features);
gc();





###### step d.
## d. load all the files concerning the Train data set
#
# Load and combine the test dataset: 
fileLocation <- ".\\train\\X_train.txt";
  X_train <- read.table(fileLocation);
fileLocation <- ".\\train\\y_train.txt";
  y_train <- read.table(fileLocation);
fileLocation <- ".\\train\\subject_train.txt";
  st_train <- read.table(fileLocation);





###### step e.
## e. apply the filter on the X_train data set, get only the columns for "mean" and "std"
#
# in the assignment, this cover the point 2: 
# "2.Extracts only the measurements on the mean and standard deviation for each measurement."
X_train_f <- X_train[, idx];


####### Clean up memory no more needed; 
rm(X_train);
gc();





###### step f.
## f. give proper column names to the train set
#
# apply descriptive column names
names(X_train_f) <- features_f;
names(y_train)   <- "Activity_id";
names(st_train)  <- "Subject";
 




###### step g.
## g. merging the activity id with the correspondent name
#
# combine the y with the correspondent name of the activity
# this is the step 3-4 
# "3.Uses descriptive activity names to name the activities in the data set
#  4.Appropriately labels the data set with descriptive activity names. "
y_train_m <- merge(y_train, activity, by.x="Activity_id", by.y="Activity_id", all=TRUE)





###### step h.
## h. Combine all the files for the "train" and create one final big train set
#
# create a unique dataset for the complete test part
train_set = cbind(st_train, y_train_m, X_train_f);

###### remove unnecessary data from memory
rm(X_train_f);
rm(y_train);
rm(y_train_m);
rm(st_train);
gc();





###### step i.
## i. load all the files concerning the Test data set
#
fileLocation <- ".\\test\\X_test.txt";
  X_test <- read.table(fileLocation);
fileLocation <- ".\\test\\y_test.txt";
  y_test <- read.table(fileLocation);
fileLocation <- ".\\test\\subject_test.txt";
  st_test <- read.table(fileLocation);





###### step j.
## j. apply the filter on the X_test data set, get only the columns for "mean" and "std"
#
#
# in the assignment, this cover the point 2: 
# "2.Extracts only the measurements on the mean and standard deviation for each measurement."
X_test_f <- X_test[, idx];


# remove unnecessary data from memory
rm(X_test);
gc();




###### step k.
## k. give proper column names to the test set
#
# apply descriptive column names
names(X_test_f) <- features_f;
names(y_test)   <- "Activity_id";
names(st_test)  <- "Subject";





###### step m
## m. merging the activity id with the correspondent name
#
# combine the y with the correspondent name of the activity
# this is the step 3-4 
# "3.Uses descriptive activity names to name the activities in the data set
#  4.Appropriately labels the data set with descriptive activity names. "
y_test_m <- merge(y_test, activity, by.x="Activity_id", by.y="Activity_id", all=TRUE)





###### step n
## n. Combine all the files for the "train" and create one final big train set
#
# create a unique dataset for the complete test part
test_set = cbind(st_test, y_test_m, X_test_f);


# remove unnecessary data from memory
rm(X_test_f);
rm(y_test);
rm(y_test_m);
rm(st_test);
gc();





###### step o
## o. combine all the dataset. Reaching the temp tidy set
#
# finally combine the two sets. 
# this is the step 1. 
# "1.Merges the training and the test sets to create one data set."
temp_tidy_set = rbind(train_set, test_set);


# remove unnecessary data from memory
rm(activity);
rm(test_set);
rm(train_set);
rm(features_f);
rm(idx);
gc();





###### step p 
## p. create the grouped table for the temp tidy_set
#
# the assignment, point 5. says: 
# "5.Creates a second, independent tidy data set with 
#  the average of each variable for each activity and each subject. "
grouped_data <- aggregate(temp_tidy_set, by=list(temp_tidy_set$Subject, temp_tidy_set$Activity_id, temp_tidy_set$Activity_name), FUN=mean);

# rearrange the column and put proper column names
drops <- c("Subject","Activity_id", "Activity_name");
tidy_set <- grouped_data[,!(names(grouped_data) %in% drops)]
names(tidy_set)[1:3] <- drops;
tidy_set <- tidy_set[order(tidy_set$Subject, tidy_set$Activity_id), ];

##remove useless variables
rm(temp_tidy_set);
rm(grouped_data);
rm(drops);
gc();






###### step q
## q. Writing the final tidy set
#
fileLocation <- "tidySet.csv";
write.table(tidy_set, fileLocation, append=FALSE, sep = ",", col.names = colnames(tidy_set));


