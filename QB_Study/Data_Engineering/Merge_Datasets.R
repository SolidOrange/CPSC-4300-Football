# Author: Will Concannon
# Date: 4/16/18
# Purpose: Merge all the datasets from the Scraped_Data folder

# Set directory for getting the csv files
rm(list=ls())
setwd('../Scraped_Data')

# Import datasets
qbr <- read.csv("Data_NFL_QBR.csv")
combine <- read.csv('Data_Combine.csv')

# Check for duplicates in the Name portion of the combine data
number_of_rows <- dim(combine)[1]
number_of_unique_names <- length(unique(combine$Name))

if(number_of_rows == number_of_unique_names){
  print("No duplicates in combine data")
} else {
  print("There ARE duplicates in combine data")
}

# No duplicates in combine data 


# Check for duplicates in the Name portion of the combine data
number_of_rows <- dim(qbr)[1]
number_of_unique_names <- length(unique(qbr$Name))

if(number_of_rows == number_of_unique_names){
  print("No duplicates in qbr data")
} else {
  print("There ARE duplicates in qbr data")
}

# No duplicates in QBR data

# Clean up Combine

names(combine)[names(combine) == "Height..in."] <- "Height"
names(combine)[names(combine) == "Weight..lbs."] <- "Weight"
names(combine)[names(combine) == "Hand.Size..in."] <- "Hand_Size"
names(combine)[names(combine) == "Arm.Length..in."] <- "Arm_Length"
names(combine)[names(combine) == "X40.Yard"] <- "Forty_Yard"
names(combine)[names(combine) == "Bench.Press"] <- "Bench_Press"
names(combine)[names(combine) == "Vert.Leap..in."] <- "Vertical_Leap"
names(combine)[names(combine) == "Broad.Jump..in."] <- "Broad_Jump"
names(combine)[names(combine) == "X3Cone"] <- "Three_Cone"
names(combine)[names(combine) == "X60Yd.Shuttle"] <- "Sixty_Shuttle"

# Drop POS (Position) column because they are all QBs
combine$POS <- NULL

# Drop Year because it is basically useless
combine$Year <- NULL

# Drop College because Data_College_QB_Stats contains the conference, which should be better for the model
combine$College <- NULL

# Drop Sixty_Shuttle, Bench Press, and Wonderlic because very few participated
combine$Sixty_Shuttle <- NULL
combine$Bench_Press <- NULL
combine$Wonderlic <- NULL

# Clean up QBR
names(qbr)[names(qbr) == "QBR"] <- "NFL_QBR"
qbr$NFL_QBR <- round(qbr$NFL_QBR, digits=1)

# Merge databases by the 'Name' Attribute
full.data <- merge(combine, qbr, by='Name')

# Data_Combine and Data_NFL_QBR are merged.

# Next, merge Data_College_QB_Stats with full.data

stats <- read.csv('Data_College_QB_Stats.csv')

# No duplicates in 








