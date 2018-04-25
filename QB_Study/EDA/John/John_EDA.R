rm(list = ls())

# Author: John Grider
# Date: April 19, 2018
# Purpose: EDA for Variables and NFL QBR

library(ggplot2)

setwd("~/Developer/GitHub/CPSS-4300-Football/QB_Study/EDA/John")
setwd("../")
data = read.csv("Response_Dataset.csv")

#Adding TD/INT ratio
data$TdInt  = data$TD / data$INT


#View(data)

notUsable = NULL

for(i in 1:197) {
  if(data[i, 12] < 0) {
    notUsable = c(notUsable, i)
  }
}

data = data[-c(17, 30, 31, 46, 50, 79), ]

par(mfrow=c(3,3))

plot(data$Height, data$NFL_QBR)
abline(lm(data$NFL_QBR ~ data$Height), col = "blue")
cor(data$Height, data$NFL_QBR)

plot(data$Weight, data$NFL_QBR)
abline(lm(data$NFL_QBR ~ data$Weight), col = "blue")
cor(data$NFL_QBR, data$Weight)

plot(data$Hand_Size, data$NFL_QBR)
abline(lm(data$NFL_QBR ~ data$Hand_Size), col = "blue")
cor(data$Hand_Size, data$NFL_QBR)

plot(data$Arm_Length, data$NFL_QBR)
abline(lm(data$NFL_QBR ~ data$Arm_Length), col = "blue")
cor(data$Arm_Length, data$NFL_QBR)

plot(data$Forty_Yard, data$NFL_QBR)
abline(lm(data$NFL_QBR ~ data$Forty_Yard), col = "blue")
cor(data$Forty_Yard, data$NFL_QBR)

plot(data$Vertical_Leap, data$NFL_QBR)
abline(lm(data$NFL_QBR ~ data$Vertical_Leap), col = "blue")
cor(data$Vertical_Leap, data$NFL_QBR)

plot(data$Broad_Jump, data$NFL_QBR)
abline(lm(data$NFL_QBR ~ data$Broad_Jump), col = "blue")
cor(data$Broad_Jump, data$NFL_QBR)

plot(data$Shuttle, data$NFL_QBR)
abline(lm(data$NFL_QBR ~ data$Shuttle), col = "blue")
cor(data$Shuttle, data$NFL_QBR)

plot(data$Games, data$NFL_QBR)
abline(lm(data$NFL_QBR ~ data$Games), col = "blue")
cor(data$Games, data$NFL_QBR)

plot(data$Completion_Percentage, data$NFL_QBR)
abline(lm(data$NFL_QBR ~ data$Completion_Percentage), col = "blue")
cor(data$Completion_Percentage, data$NFL_QBR)

plot(data$Yards, data$NFL_QBR)
abline(lm(data$NFL_QBR ~ data$Yards), col = "blue")
cor(data$Yards, data$NFL_QBR)

plot(data$Y.A, data$NFL_QBR)
abline(lm(data$NFL_QBR ~ data$Y.A), col = "blue")
cor(data$Y.A, data$NFL_QBR)

plot(data$TD, data$NFL_QBR)
abline(lm(data$NFL_QBR ~ data$TD), col = "blue")
cor(data$TD, data$NFL_QBR)

plot(data$INT, data$NFL_QBR)
abline(lm(data$NFL_QBR ~ data$INT), col = "blue")
cor(data$INT, data$NFL_QBR)

plot(data$College_QBR, data$NFL_QBR)
abline(lm(data$NFL_QBR ~ data$College_QBR), col = "blue")
cor(data$College_QBR, data$NFL_QBR)

plot(data$Rushing_Yds, data$NFL_QBR)
abline(lm(data$NFL_QBR ~ data$Rushing_Yds), col = "blue")
cor(data$Rushing_Yds, data$NFL_QBR)

plot(data$Rushing_Avg, data$NFL_QBR)
abline(lm(data$NFL_QBR ~ data$Rushing_Avg), col = "blue")
cor(data$Rushing_Avg, data$NFL_QBR)

plot(data$Rushing_Td, data$NFL_QBR)
abline(lm(data$NFL_QBR ~ data$Rushing_Td), col = "blue")
cor(data$Rushing_Td, data$NFL_QBR)


plot(data$TdInt, data$NFL_QBR)
abline(lm(data$NFL_QBR ~ data$TdInt), col = "blue")
cor(data$TdInt, data$NFL_QBR)

fit = glm(data$Power_Five ~ data$NFL_QBR, family = binomial)
p <- ggplot(data, aes(x = NFL_QBR, y = Power_Five)) +
  geom_point() + 
  geom_smooth(method = "glm",
              method.args = list(family = "binomial"), 
              se = FALSE)
print(p)

