# Coursera Getting and Cleaning Data project
===============

## Variables and data.frame objects
```
activity_labels.txt +-------------------activity_labels-------------------------+----------------------+    
features.txt  +-----+-----------allfeatures-------------------------------------+                      |    
    \test                                                                       |                 Activities
         \subject_test.txt +---> subject_test +--^-cbind---> testingdata     Col Names                 |    
         \X_test.txt +---------> x_test +--------|               +              v                      v    
         \y_test.txt +---------> y_test +--------+               +--rbind---> fulldata +--subset--> tidydata
    \train                                                       +              +            ^              
         \subject_train.txt +--> subject_train +-+-cbind---> trainingdata       |            |              
         \X_train.txt +--------> x_train +-------|                            grepl          |              
         \y_train.txt +--------> y_train +-------+                              |            |              
                                                                                |            |              
                                                                                v            |              
                                                                            keep_cols +------+              

```
## Steps involved in creating a tidy dataset

1. It is assumed that the script resides in the directory where the zip file from the assignment was unpacked. So, the directly must contain a `UCI HAR Dataset` at the same level.
2. The script reads the description files into corresponding `data.frame` objects using `read.table()`
3. The script reads the `test` and `train` data into corresponding `data.frame` objects using `read.table()`
4. The `subject` and `activity` data is merged with the observation data in each area using `cbind()`
5. `testingdata` and `trainingdata` are appended to each other by using `rbind()`
6. Appropriate column names are assigned by using labels from `features.txt` (via `allfeatures`)
7. From these column names, a list is created of those column names that contain `activity` or `subject` or `mean()` or `std()` using the `grepl()` function.
8. A subset of the columns from the completedata is created to keep only the desired columns, using `subset()`
9. The activity descriptions, read from `activity_labels.txt` are merged to this tidy dataset and written to a file.
10. This tidy data contains 10,299 observations of 66 variables and 3 description columns (Activity Label, Activity Code and Subject Identifier)
10. Next, the `aggregate()` function is called for each data column in `tidydata` to calculate the average of the values for each `subject` and `activity`
11. Appropriate column names are assigned from the source dataset.
12. The resultant dataset consists of averages for 66 variables and 3 description columns(Activity Label, Activity Code and Subject Identifier) for each subject (30), and for each activity(6), for a total of 30x6=180 rows.
13. This resultant dataset is written to a file using `write.table()` in a comma-delimited form.


## List of variables using in the script
```
activity_descriptions
activity_labels
allfeatures
allmeans
checkMeans
checkTidy
colmean
first_time
fulldata
keep_cols
rootdir
subject_test
subject_train
testdir
testingData
tidydata
traindir
trainingData
x_test
x_train
y_test
y_train
```