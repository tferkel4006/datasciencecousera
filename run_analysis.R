#R script for Getting and Cleaning Data course project
#
#load libraries we need
library(dplyr)

#set the directory we want to work in
wdir<-c("./course3project")

#Check to see if the directory we want already exists, if not create it
if(!file.exists(wdir)){dir.create(wdir)}

#make the working directory the same
setwd(wdir)

#check to see if we already got the data
if(!file.exists("data.zip")){
  
  #download the raw data zip file
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile="data.zip")

  #unzip the file and put all the files into the working directory
  unzip("data.zip", junkpaths=TRUE, exdir=".")
}

#read activity labels
activitylabels<-read.table("activity_labels.txt")

#give it some column names
colnames(activitylabels)<-c("code","activityname")

#read in features
features<-read.table("features.txt")

#read in train files including subject, activity and measures and combine them
trainsubject<-read.table("subject_train.txt")
trainactivity<-read.table("y_train.txt")
trainmeasures<-read.table("x_train.txt")
train<-cbind(trainsubject,trainactivity,trainmeasures)

#read in test files including subject, activity and measures
testsubject<-read.table("subject_test.txt")
testactivity<-read.table("y_test.txt")
testmeasures<-read.table("x_test.txt")
test<-cbind(testsubject,testactivity,testmeasures)

#combine the two datasets
alldata<-rbind(train,test)

#create a character vector for columns name
colnames<-c("subject","code",features[,"V2"])
colnames<-tolower(colnames)

#set the column names
colnames(alldata)<-colnames

#subset the dataframe for just the mean and std deviation measures
subdata<-alldata[,c("subject","code",grep("mean\\(\\)",colnames,value=TRUE),grep("std()",colnames,value=TRUE))]

#cleanup the column names
colnames<-names(subdata)
colnames<-gsub("-","",colnames)
colnames<-gsub("\\(\\)","",colnames)
colnames(subdata)<-colnames

#add the activity labels with data
subdata<-cbind(activityname=" ",subdata)
for (n in 1:6) {
  subdata[subdata$code==n,1]<-activitylabels[n,2]
}

#convert to data frame tbl
datatbl<-as_tibble(subdata)

#now drop the code column
datatbl<-select(datatbl,-code)

#create a new table to store the average by activity and person for all measures
grpdatatbl<-datatbl%>%group_by(activityname,subject)

#now summarize the average for all measures by activity and person, drop the groups so we get a clean table
avgtbl<-summarize(grpdatatbl,across(c(3:ncol(grpdatatbl)-2), mean),.groups="drop")

#now update the column names to show that they are the mean of the variables
colnames<-names(avgtbl)
colnms<-c(colnames[1:2],paste0("meanof",colnames[3:ncol(avgtbl)-2]))
colnames(avgtbl)<-colnms

#now write out the avg tidy dataset
write.table(avgtbl,file="avg_tidy_data.txt",row.names=FALSE)

#now go back to original working directory
setwd("../")


