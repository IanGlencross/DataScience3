# DataScience3
Location of assignment files for a course in Data Science : Getting &amp; Cleaning Data

##What you find in this repository
•	CodeBook.md: information about raw and tidy data set and elaboration made to transform them
•	LICENSE: license terms for text and code
•	README.md: this file
•	run_analysis.R: R script to transform raw data set in a tidy one

##How to create the tidy data set
1.	clone this repository: git clone git@github.com:IanGlencross/DataScience3.git
2.	download compressed raw data
3.	unzip raw data and copy the directory <i>UCI HAR Dataset</i> to the cloned repository root directory
4.	open a R console and set the working directory to the repository root (use setwd())
5.	source run_analisys.R script (it requires the plyr package): source('run_analysis.R')
	

In the repository root directory you find the file avg_by_activity_subject.txt containing the tidy data set.

