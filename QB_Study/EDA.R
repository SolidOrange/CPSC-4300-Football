# Name: Will Concannon
# Date: February 7th, 2018
# Purpose: Exploratory Analysis of Combine Data

rm(list = ls())

# Import Library
library(ggplot2)

# Get dataset
setwd('/Users/Will/Developer/R/CombineStudy')
data <- read.csv("combine_data.csv")
draft <- read.csv('draft_order.csv')

# Rename variables
names(data)[names(data) == "Height..in."] <- "Height"
names(data)[names(data) == "Weight..lbs."] <- "Weight"
names(data)[names(data) == "Hand.Size..in."] <- "Hand_Size"
names(data)[names(data) == "Arm.Length..in."] <- "Arm_Length"
names(data)[names(data) == "X40.Yard"] <- "Forty_Yard"
names(data)[names(data) == "Bench.Press"] <- "Bench_Press"
names(data)[names(data) == "Vert.Leap..in."] <- "Vertical_Leap"
names(data)[names(data) == "Broad.Jump..in."] <- "Broad_Jump"
names(data)[names(data) == "Three-Cone"] <- "Three_Cone"
names(data)[names(data) == "X60Yd.Shuttle"] <- "Sixty_Shuttle"
names(data)[names(data) == "Name"] <- "Player"

# The webscraped page used the value 9.99 instead of NA
data[data==9.99] <- NA

# Remove duplicate columns before merge
draft$Position <- NULL
draft$College <- NULL

full <- merge(data, draft, by="Player")


ggplot(data=full) +
  geom_point(mapping=aes(x=Height, y=Pick))









