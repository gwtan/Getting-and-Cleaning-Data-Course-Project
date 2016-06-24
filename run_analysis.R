##download and unzip dataset from given url into working directory
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "./dataset.zip")
unzip("./dataset.zip")
library(dplyr)

##reading datasets into R
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt", 
                    stringsAsFactors = FALSE)
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt", 
                    stringsAsFactors = FALSE)
stest <- read.table("./UCI HAR Dataset/test/subject_test.txt", 
                    stringsAsFactors = FALSE)
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt", 
                     stringsAsFactors = FALSE)
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt", 
                     stringsAsFactors = FALSE)
strain <- read.table("./UCI HAR Dataset/train/subject_train.txt", 
                     stringsAsFactors = FALSE)
features <- read.table("./UCI HAR Dataset/features.txt", 
                       stringsAsFactors = FALSE)

##labeling appropriate activity and subject columns and merging test 
## and training datasets
names(ytest) <- "activity"
names(stest) <- "subject"
xtest <- mutate(xtest, data_set = "test")
dftest <- cbind(xtest,stest,ytest)
names(ytrain) <- "activity"
names(strain) <- "subject"
xtrain <- mutate(xtrain, data_set = "training")
dftrain <- cbind(xtrain,strain,ytrain)
df_merge <- rbind(dftest,dftrain)

##labeling features columns described by features.txt file
names(df_merge)[1:561] <- features$V2

##extracting measurements with mean and std into separate data frame
cols <- grep("[Mm]ean|[Ss]td", names(df_merge), value=F)
df_extract <- df_merge[, c(cols, 563, 564)]

##descriptive labelling of activities
walking <- which(match(df_extract$activity, 1) == TRUE)
w_up <- which(match(df_extract$activity, 2) == TRUE)
w_down <- which(match(df_extract$activity, 3) == TRUE)
sitting <- which(match(df_extract$activity, 4) == TRUE)
standing <- which(match(df_extract$activity, 5) == TRUE)
laying <- which(match(df_extract$activity, 6) == TRUE)
df_extract$activity[walking] <- "WALKING"
df_extract$activity[w_up] <- "WALKING_UPSTAIRS"
df_extract$activity[w_down] <- "WALKING_DOWNSTAIRS"
df_extract$activity[sitting] <- "SITTING"
df_extract$activity[standing] <- "STANDING"
df_extract$activity[laying] <- "LAYING"

##creates a second, independent tidy data set with the average of each variable 
##for each activity and each subject
df_tidy <- df_extract %>% group_by(activity, subject) %>% summarise_each(funs(mean))

##writes tidy data set as txt file and save in working directory
write.table(df_tidy, file = "data_set.txt", row.names = FALSE)

##prints df_tidy dataframe
df_tidy                                                                         


