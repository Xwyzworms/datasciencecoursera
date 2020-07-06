## Ola Gan ##
## Created by : XwyzWorm{Are you 0 or 1 ?}
## Date :: 06-07-2040 ##

## Creating Directory For the Downloaded file
if(! base::dir.exists("DownloadFolder")){base::dir.create("DownloadFolder")}
## DownloadIng the file
ZipFileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
utils::download.file(url = ZipFileUrl , destfile = ".\\DownloadFolder\\Dataset.zip")

#Checking file
base::list.files("DownloadFolder")
##Extract & Storing Files 
utils::unzip(".\\DownloadFolder\\Dataset.zip" ,exdir = ".\\File" )

##

"""- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.
"""

## When I Check The file ,There's A lot Of Train and Test Data
### Which the Things we should merges into 1 dataset
## So I m going to create List inside the list theres a column called file loc
## Where To store each file location 
## For The Number Of Rows , try to open The File With Notepad++

## ### ###
library(dplyr)

data <- list(
  fileLoc = list(
    activity_labels = "File\\UCI HAR Dataset\\activity_labels.txt",
    features = "File\\UCI HAR Dataset\\features.txt",
    subject_test =".\\File\\UCI HAR Dataset\\test\\subject_test.txt",
    x_test = "File\\UCI HAR Dataset\\test\\X_test.txt",
    y_test = "File\\UCI HAR Dataset\\test\\y_test.txt",
    subject_train = "File\\UCI HAR Dataset\\train\\subject_train.txt",
    x_train = "File\\UCI HAR Dataset\\train\\X_train.txt",
    y_train = "File\\UCI HAR Dataset\\train\\y_train.txt"
  ),
  ColClasses = list(
    activity_labels = c("integer" , "character"), ##each for coressponding col and so on
    features = c("integer","character"),
    subject_test = "integer",
    x_test = rep("numeric" ), ## Look at Features.txt
    y_test = "integer",
    subject_train = "integer",
    x_train = rep("numeric"),
    y_train = "integer"
  ),
  nrows = list(
    activity_labels = 6,
    features = 561 ,
    subject_test = 2947,
    x_test = 2947,
    y_test = 2947,
    subject_train = 7352,
    x_train = 7352,
    y_train = 7352
  )
)

df <- base::with(data,
                 base::Map(read.table,file = fileLoc , 
                                      colClasses = ColClasses,
                                      nrows = nrows ,
                                      stringsAsFactors = FALSE
                                    )) ## For Each File !!

Merged <-base:;with(df,
                  base::rbind(cbind(subject_train, y_train, x_train),
                  base::cbind(subject_test,  y_test,  x_test)))



## END OF THE NUMBER 1 ##

#Num 2: Extracts only the measurements on the mean and standard deviation
#         for each measurement.

##At Num 3 Lecturer want us to Uses descriptive activity names to name the activities in the data set
##Thus adding 2 Indexes ,correspond to subject and activity 
target_indexes <- base::grep("mean\\(\\)|std\\(\\)",
                              x = df$features$V2)
target_indexes
names(Merged)
target_indexes <- c(1,2,target_indexes + 2)
ExtractedData <- Merged[, target_indexes]

Merged$V1 ## This guy Correspond to Activity
#### End Of The NUMBER 2###

#NUM 3:Uses descriptive activity names to name the activities in the data set

ExtractedData$V1.1 <- base::factor(x = ExtractedData$V1.1,
                                   labels = df$activity_labels$V2)
ExtractedData$V1.1
###ENT OF THE NUMBER 3 ###


##Num4 <- Appropriately labels the data set with descriptive variable names.
Var_names <- df$features$V2[target_indexes]
## Take A look ,Theres a repetitive Words 
Var_names
Var_names <- base::gsub(pattern = "BodyBody" , replacement="Body" , Var_names)
# Only Renamed The Columns
tidy_data <- ExtractedData
names(tidy_data)
tidy_data <- dplyr::rename (ExtractedData , subject = V1,activity = V1.1,variable_names = V1.2)
names(tidy_data)
## END OF THE NUMBER 4

# NUm 5 <- am lazy
tidy_Final <- tidy_data %>%
  group_by(subject, activity) %>%
  summarise_all(list(mean))

new_names <- c(names(tidy_Final[, c(1,2)]),
                           paste0("Average-", names(tidy_Final[, -c(1, 2)])))
names(tidy_Final) <- new_names
tidy_Final[,-c(1,2)]
write.table(tidy_Final, "tidy_data.txt", row.names = FALSE)
