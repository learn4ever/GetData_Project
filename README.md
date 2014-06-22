## Coursera Getting and Cleaning Data project
===============

# Variables and data.frame objects
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
