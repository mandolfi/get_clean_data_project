get_clean_data_project
======================

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
