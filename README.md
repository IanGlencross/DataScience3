# DataScience3
This is the repos of my project files for a course in Data Science : Getting &amp; Cleaning Data

##What is in this repository?
•	CodeBook.md: information about raw and tidy data set and the process used to tranform the raw data into the tidy data

•	LICENSE: license terms for text and code

•	README.md: this file

•	run_analysis.R: R script to transform raw data set in a tidy one

##How to create the tidy data set
1.	clone this repository to your local computer.  To do this type : `git clone git@github.com:IanGlencross/DataScience3.git` at the system prompt.
2.	download the [compressed raw data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 
3.	unzip raw data and copy the directory <i>UCI HAR Dataset</i> to the cloned repository root directory
4.	open a R console and set the working directory to the repository root using 'setwd()'
5.	run the *run_analisys.R* script.  To to this type `source('run_analysis.R')` at the R Consle prompt
	

In the repository root directory you find the file `avg_by_activity_subject.txt` containing the tidy data set.

