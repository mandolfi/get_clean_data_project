###get_clean_data_project
======================

##Instructions: 
======================
1. Download the file given in the assignment:  [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
2. Extract the folder anywhere in your laptop.
I have done as well and I have executed a 'dir' command from CMD.  
``` 
C:\Users\Marco\Desktop\Temp\PeerAssignment>dir
 Directory di C:\Users\Marco\Desktop\Temp\PeerAssignment

21/04/2014  17.25    <DIR>          .
21/04/2014  17.25    <DIR>          ..
20/04/2014  09.27                80 activity_labels.txt
20/04/2014  09.27            15.785 features.txt
20/04/2014  09.27             2.809 features_info.txt
20/04/2014  09.27             4.453 README.txt
20/04/2014  09.27    <DIR>          test
20/04/2014  09.27    <DIR>          train
``` 
3. Placed in this directory the file "run_analysis.R".
4. Open your R Studio and set your working directory properly, in my case the command follow: 
``` 
setwd("C:\\Users\\Marco\\Desktop\\Temp\\PeerAssignment");
``` 
5. Run the script. At the end of the execution the folder will look like this: 
``` 
C:\Users\Marco\Desktop\Temp\PeerAssignment>dir
 Directory di C:\Users\Marco\Desktop\Temp\PeerAssignment

21/04/2014  17.25    <DIR>          .
21/04/2014  17.25    <DIR>          ..
21/04/2014  11.10             4.608 .Rhistory
20/04/2014  09.27                80 activity_labels.txt
20/04/2014  09.27            15.785 features.txt
20/04/2014  09.27             2.809 features_info.txt
20/04/2014  09.27             4.453 README.txt
21/04/2014  17.31             7.342 run_analysis.R
20/04/2014  09.27    <DIR>          test
21/04/2014  17.25            52.116 tidySet.csv
20/04/2014  09.27    <DIR>          train
``` 

###Approach
Basically I used the approach described at: 
* points 1-4: [https://class.coursera.org/getdata-002/forum/thread?thread_id=291#post-1233] (https://class.coursera.org/getdata-002/forum/thread?thread_id=291#post-1233)
* points   5: [https://class.coursera.org/getdata-002/forum/thread?thread_id=146#post-516](https://class.coursera.org/getdata-002/forum/thread?thread_id=146#post-516)

My approach is: 
* a. load the features 
* b. filter the features-names getting only the one for "mean" and "std"
* c. load the activities labels
* d. load all the files concerning the Train data set
* e. apply the filter on the X_train data set, get only the columns for "mean" and "std"
* f. give proper column names to the train set
* g. merging the activity id with the correspondent name
* h. Combine all the files for the "train" and create one final big train set
* i. load all the files concerning the Test data set
* j. apply the filter on the X_test data set, get only the columns for "mean" and "std"
* k. give proper column names to the test set
* m. merging the activity id with the correspondent name
* n. Combine all the files for the "train" and create one final big train set
* o. combine all the dataset. Reaching the temp tidy set
* p. create the grouped table for the temp tidy_set
* q. Writing the final tidy set



The steps described above can be followed on the code.
In between I have removed repeatedly unused variables, 
in order to keep a low usage of the memory (I have a small machine).
