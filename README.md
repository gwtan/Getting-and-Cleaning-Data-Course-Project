# Getting-and-Cleaning-Data-Course-Project

run_analysis.R obtains the dataset provided and does the following:

- download and unzip dataset from given url into working directory reading datasets into R

- labels appropriate activity and subject columns and merging test and training datasets

- labels features columns described by features.txt file

- extracts measurements with mean and std into separate data frame

- descriptive labelling of activities based on activity_labels.txt

- creates a second, independent tidy data set with the average of each variable for each activity and each subject

- writes tidy data set as txt file and save in working directory

- prints df_tidy dataframe
