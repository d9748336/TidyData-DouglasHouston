rm(list = ls())

#Load the contents of the text files inot data frames
xtest <- read.table("test\\X_test.txt")
xtrain <- read.table("train\\X_train.txt")

ytest <- read.table("test\\y_test.txt")
ytrain <- read.table("train\\y_train.txt")

subjecttest <- read.table("test\\subject_test.txt")
subjecttrain <- read.table("train\\subject_train.txt")

xtable <- rbind(xtest, xtrain)
ytable <- rbind(ytest, ytrain)
subjecttable <- rbind(subjecttest, subjecttrain)

features <- read.table("features.txt")
features <- as.character(features[,2])

#Get only those features that are means or standard deviations
meansnstds <- grep("-mean|-std",features)
meansnstds_featurenames <- grep("-mean|-std",features, value=TRUE)

#Initilize a data frame to hold the mean and std mesurements extracted from the raw data
meansnstds_xtable <- data.frame(matrix(ncol = 79, nrow = 10299))

#Fill that data frame with the seleted measurement data
c <- 1
for (i in meansnstds) {
    print(i)
    meansnstds_xtable[,c] <- xtable[,i]
    c <- c + 1
}

#Rename the column headings so that they are more clear
meansnstds_measurements_named <- setNames(meansnstds_xtable, meansnstds_featurenames)

#Add to the numbers (labels) in ytable the activities they actually denote, as defined in activity_labels.txt
#First get the activity lables into a vector
activity_labels <- read.table("activity_labels.txt")

#Name the columns by using setNames to replace the default column headings with more descriptive names
activity_labels_named <- setNames(activity_labels, c("labels", "activity"))
activities_named <- setNames(ytable, "activity")
    
#Now name the table that denotes which labels denote which subjects (it only has one column)
subjecttable_named <- setNames(subjecttable, "subject")

#Fill the "activites" table with the actual names (strings) of the activities rather than their labels (integers)
activities <- character()
activities <- activity_labels_named[unlist(activities_named), 2]

#Create a complete table of subject, activity and all measurements
complete_table <- cbind(subjecttable_named, activities, meansnstds_measurements_named)

#Initialize a data frame to store the final tidy data
mean_table <- data.frame(matrix(ncol = 81, nrow = 1))
#Name the columns in this new table according to the columns in the old table, THIS time making them syntactically legal for added clarity
mean_table <- setNames(mean_table, make.names(colnames(complete_table)))

#For each subject, and for each activity, calculate the man of the selected measurements.
for (subject in 1:30) {
    for (activity in activity_labels_named[,2]) {
        #Reinitialise the row, so that the previous iteration's is wiped
        row <- vector()
        for (column in 3:81) {
            row <- append(row, mean(complete_table[,column][(which(complete_table$subject == subject & complete_table$activities == activity))]))
        }    
        mean_table <- rbind(mean_table,(c(subject, activity, row)))
    }
}

#Output the final tidy data, omitting the first blank row that was used to initialise the data frame.
write.table(mean_table[-1,], file = "tidy.txt", row.name=FALSE)
print(mean_table[-1,])


