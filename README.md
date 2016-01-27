## Getting and Cleaning Data Project

The purpose of this project is to demonstrate student's ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.
One of the most exciting areas in all of data science right now is wearable computing - see for example this article. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

### How to Run

There is one script (run_analysis.R) in this project which conviniently organizes and averages the key measurements provides in files in data folder. The result is tidyData.txt file which contains the aggregate of all measurements grouped by subjectId and activityId.
The script is self-contained and does not need any arguments. Only thing required is to set the working directory to the path where script is located. It is enough to source the script into R environment then.
```
setwd("path to script file");
source("run_analysis.R");
```
