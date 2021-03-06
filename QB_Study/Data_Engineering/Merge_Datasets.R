# Author: Will Concannon
# Date: 4/16/18
# Purpose: Merge all the datasets from the Scraped_Data folder

# Set directory for getting the csv files
rm(list=ls())
setwd("~/Developer/GitHub/CPSS-4300-Football/QB_Study/Data_Engineering")
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

# Check for duplicates in the Name portion of the combine data
number_of_rows <- dim(qbr)[1]
number_of_unique_names <- length(unique(qbr$Name))

if(number_of_rows == number_of_unique_names){
  print("No duplicates in qbr data")
} else {
  print("There ARE duplicates in qbr data")
}

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
names(combine)[names(combine) == "College"] <- "School"

# Fix issue where it used 9.99 for blank values
combine$Forty_Yard[combine$Forty_Yard %in% 9.99] <- NA
combine$Shuttle[combine$Shuttle %in% 9.99] <- NA
combine$Three_Cone[combine$Three_Cone %in% 9.99] <- NA

# Drop POS (Position) column because they are all QBs
combine$POS <- NULL

# Drop Sixty_Shuttle, Bench Press, and Wonderlic because very few participated
combine$Sixty_Shuttle <- NULL
combine$Bench_Press <- NULL
combine$Wonderlic <- NULL

# Clean up QBR
names(qbr)[names(qbr) == "QBR"] <- "NFL_QBR"

# Merge databases by the 'Name' Attribute
full.data <- merge(combine, qbr, by='Name')

# Check for duplicates in the Name portion of full.data
number_of_rows <- dim(full.data)[1]
number_of_unique_names <- length(unique(full.data$Name))

if(number_of_rows == number_of_unique_names){
  print("No duplicates in full.data")
} else {
  print("There ARE duplicates in full.data")
}

# Next, merge Data_College_QB_Stats with full.data

stats <- read.csv('Data_College_QB_Stats.csv')

# Clean up floating point numbers
stats$Completion_Percentage <- round(stats$Completion_Percentage, 2)
stats$Y.A <- round(stats$Y.A, 1)
stats$College_QBR <- round(stats$College_QBR, 1)
stats$Rushing_Avg <- round(stats$Rushing_Avg, 1)

# Check for duplicates in the Name portion of the stats data
number_of_rows <- dim(stats)[1]
number_of_unique_names <- length(unique(stats$Name))
number_of_unique_players <- dim(stats[ ! duplicated( stats[ c("Name" , "School") ] ) , ])[1]

if(number_of_rows == number_of_unique_players){
  print("No duplicates in stats data")
} else {
  print("There ARE duplicates in stats data")
}

# Do a left outer merge by name
full.data <- merge(full.data, stats, by=c('Name', 'School'), all.x =TRUE)

# Check for duplicates in the Name portion of the full.data
number_of_rows <- dim(full.data)[1]
number_of_unique_names <- length(unique(full.data$Name))
number_of_unique_players <- dim(full.data[ ! duplicated( full.data[ c("Name" , "School") ] ) , ])[1]

if(number_of_rows == number_of_unique_players){
  print("No duplicates in stats data")
} else {
  print("There ARE duplicates in stats data")
}

# Add College Team Success Info
# Poll Data is what their team was ranked in the final week of their Senior year of College

polls <- read.csv('../Scraped_Data/Data_Polls.csv')

# Decrement year by 1 to match up with the polls for merging
full.data$Year <- full.data$Year - 1

# Merge sets by year and school
full.data <- merge(full.data, polls, by=c("Year", "School"), all.x=TRUE)

# Quantify Rank Feature
full.data$Rank[is.na(full.data$Rank)] <- 0
full.data$Rank[full.data$Rank <= 10] <- 2
full.data$Rank[11 <= full.data$Rank & full.data$Rank<= 25] <- 1
full.data$Rank <- factor(full.data$Rank)

# Get rid of School because it's unneccessary for the model
full.data$School <- NULL

# Remove values with more than 10 NA values
full.data <- full.data[!rowSums(is.na(full.data)) > 10, ]
# Feature Engineering

# Using a binary variable to represent playing a power five conference and also can now remove school
power.five = c("ACC", "Big 10", "SEC", "Big 12","Pac-10","Pac-12")
full.data$Power_Five <- full.data$Conference %in% power.five

# Create a dataset where every row comtains the response (NFL_QBR)
response.data <- subset(full.data, !is.na(full.data$NFL_QBR))

colSums(is.na(response.data))


# Remove features with lots of NAs
response.data$Three_Cone <- NULL
response.data$Shuttle_Run <- NULL
response.data$Vertical_Leap <- NULL
response.data$Broad_Jump <- NULL


#Repair features with lots of NAs by using an average value
for(i in 1:ncol(response.data)){
  response.data[is.na(response.data[,i]), i] <- mean(response.data[,i], na.rm = TRUE)
}

# Write main dataframes to csvs
write.csv(response.data, '../EDA/Response_Dataset.csv')
write.csv(full.data, '../EDA/Dataset.csv')





