#Code Book
This codebook looks at both the raw and transformed data sets used in the Getting & Cleaning Data project.

##Raw data 
###Collection of data
The raw data used in this project can be obtained from UCI Machine Learning repository. In particular we used the Human Activity Recognition Using Smartphones Data Set.  This data was used to conduct experiments exploiting the Support Vector Machine (SVM).  A compressed copy of this data is availble on [cloudfront](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The collectors used smartphones as sensing tools, utilising the embedded sensors such as microphones, dual cameras, accelerometers and  gyroscopes.   The 3-axial time domain signals from accelerometer and gyroscope in each smart phone were captured at a constant rate of 50 Hz 

The data set was built from experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (walking, walking upstairs, walking downstairs, sitting, standing, laying) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity were captured at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually.

The obtained data set has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.


###Variables
The data from each sensor was filtered to remove noise or to discriminate between body and gravity acceleration signals. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals.  The magnitude of these three-dimensional signals were then calculated using the Euclidean norm. 

A Fast Fourier Transform (FFT) was applied to some of these time domain signals to obtain frequency domain signals.
The signals were sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window at 50 Hz). From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

The set of variables that were derived from these signals are:
*	mean(): Mean value
*	std(): Standard deviation
*	mad(): Median absolute deviation
* max(): Largest value in array
*	min(): Smallest value in array
*	sma(): Signal magnitude area
*	energy(): Energy measure. Sum of the squares divided by the number of values.
*	iqr(): Interquartile range
*	entropy(): Signal entropy
*	arCoeff(): Autoregression coefficients with Burg order equal to 4
*	correlation(): Correlation coefficient between two signals
*	maxInds(): Index of the frequency component with largest magnitude
*	meanFreq(): Weighted average of the frequency components to obtain a mean frequency
*	skewness(): Skewness of the frequency domain signal
*	kurtosis(): Kurtosis of the frequency domain signal
*	bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
*	angle(): Angle between some vectors.

No units of measurement are used as all features were normalized and bounded within [-1,1].


##Transformed Data
The raw data sets are processed with *run_analisys.R* script to create a tidy data set.  This was done in a five step process.

###STEP 1.  Merge training and test sets
Test and training data (X_train.txt, X_test.txt), subject ids (subject_train.txt, subject_test.txt) and activity ids (y_train.txt, y_test.txt) are merged to obtain a single data set. Variables are labelled with the names assigned by original collectors (features.txt).

###STEP 2.  Extract mean and standard deviation variables
From the merged data set an intermediate data set is extracted with only the values of estimated mean (variables with labels that contain "mean") and standard deviation (variables with labels that contain "std").

###STEP 3.  Use descriptive activity names
A new column is added to intermediate data set with the activity description. Activity id column is used to look up descriptions in activity_labels.txt.

###STEP 4.  Label variables appropriately
Labels given from the original collectors were changed:
*	to obtain valid R names without parentheses, dashes and commas
*	to obtain more descriptive labels

###STEP 5. Create an independent summary as a new tidy data set
From the intermediate data set is created a final tidy data set where numeric variables are averaged for each activity and each subject.

The full tidy data set contains 10299 observations with 81 variables divided into:
*	an activity label (Activity): WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
*	an identifier of the subject who carried out the experiment (Subject): 1, 3, 5, 6, 7, 8, 11, 14, 15, 16, 17, 19, 21, 22, 23, 25, 26, 27, 28, 29, 30
*	a 79-feature vector that relates to 17 signals measure on three orthgonal axes in both the time and frequecy domains

The following table relates the 17 signals to the names used as prefix for the variables names present in the data set. ".XYZ" denotes three variables, one for each axis.

 Name |	Time domain	 | Frequency domain
---|---|---
Body Acceleration |	TimeDomain.BodyAcceleration.XYZ	 |FrequencyDomain.BodyAcceleration.XYZ 
Gravity Acceleration	| TimeDomain.GravityAcceleration.XYZ |             	
Body Acceleration Jerk	| TimeDomain.BodyAccelerationJerk.XYZ	| FrequencyDomain.BodyAccelerationJerk.XYZ |
Body Angular Speed	| TimeDomain.BodyAngularSpeed.XYZ	| FrequencyDomain.BodyAngularSpeed.XYZ 
Body Angular Acceleration |	TimeDomain.BodyAngularAcceleration.XYZ	 |           
Body Acceleration Magnitude |	TimeDomain.BodyAccelerationMagnitude	|FrequencyDomain.BodyAccelerationMagnitude |
Gravity Acceleration Magnitude |	TimeDomain.GravityAccelerationMagnitude	|  
Body Acceleration Jerk Magnitude |	TimeDomain.BodyAccelerationJerkMagnitude| FrequencyDomain.BodyAccelerationJerkMagnitude 
Body Angular Speed Magnitude |	TimeDomain.BodyAngularSpeedMagnitude |	FrequencyDomain.BodyAngularSpeedMagnitude 
Body Angular Acceleration Magnitude |	TimeDomain.BodyAngularAccelerationMagnitude | FrequencyDomain.BodyAngularAccelerationMagnitude 


For variables derived from mean and standard deviation estimation, the previous labels are augmented with the terms "Mean" or "StandardDeviation".


The final tidy data set is written to the file sensor_avg_by_act_sub.txt.


###References 
1.	Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. ESANN 2013 proceedings, European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning. Bruges (Belgium), 24-26 April 2013
2.	Tidy data set. URL: https://github.com/jtleek/datasharing#the-tidy-data-set. Accessed 05/21/2014

