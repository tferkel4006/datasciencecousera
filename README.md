---
title: "README - Instructions For Processing Samsung Data"
author: "Tim Ferkel"
date: "3/26/2021"
output: html_document
---

Name of R script: run_analysis.R  
Execution Environment: RStudio  
Data Source: [link]https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

To run the script:   
1. Prerequisite for script: dplyr package.  If you don't have this installed you will need to install.packages("dplyr").  The script will load the dplr package for you  
2. Make sure you are in your working directory  
3. Run the script by clicking on Source in RStudio  
4. Note: you can run the script multiple times if you want  
5. Note: if for some reason you get an error when running the script you will need to manually change back to your working directory  

What the script will do:  
1. Create a new directory in your working directory called /course3project if it doesn't already exist  
2. Change the working directory to /course3project  
3. Download the Samsung zip file as data.zip and unzip it into the new folder if the data.zip file doesn't already exist  
4. Note: when it unzips the file it does not retain the directory structure and puts all the files in the /course3project directory  
5. Run the logic to create the tidy dataset, the resulting file is called avg_tidy_data.txt and will be placed in the /course3project directory  
6. Changes the working directory back to your original working directory  

Output file avg_tidy_data.txt specifics:  
1. Generated with write.table and row.names=False  
2. Contains average of all mean() AND std() measurements from the original dataset  
3. Each observation is for a specific activity for a specific person, there will be 6 rows for each person in the file  
4. Sorted by activity and then person  
5. You can read the files using read.table(filename,header=TRUE)

Notes on CodeBook:  
1. You will want to run the R script before trying to knit the codebook as it will look for files in the /course3project directory  

This script was run multiple times successfully.  Here is the sessionInfo:  
R version 4.0.4 (2021-02-15)  
Platform: x86_64-w64-mingw32/x64 (64-bit)  
Running under: Windows 10 x64 (build 19042)  