rm(list = ls())

# Author: John Grider
# Date: April 19, 2018
# Purpose: EDA for Variables and NFL QBR

setwd("/Users/jdgride/Documents/Github/CPSC-4300-Football/QB_Study/EDA/")
data = read.csv("Response_Dataset.csv")

#Adding TD/INT ratio
TDINTRAT = data$TD / data$INT
data$TdInt = TDINTRAT

#View(data)

notUsable = NULL

for(i in 1:197) {
  if(data[i, 12] < 0) {
    notUsable = c(notUsable, i)
  }
}

data = data[-c(17, 30, 31, 46, 50, 79), ]

plot(data$NFL_QBR, data$Height)
abline(lm(data$Height ~ data$NFL_QBR), col = "blue")
cor(data$NFL_QBR, data$Height)

plot(data$NFL_QBR, data$Weight)
abline(lm(data$Weight ~ data$NFL_QBR), col = "blue")
cor(data$NFL_QBR, data$Weight)

plot(data$NFL_QBR, data$Hand_Size)
abline(lm(data$Hand_Size ~ data$NFL_QBR), col = "blue")
cor(data$NFL_QBR, data$Hand_Size)

plot(data$NFL_QBR, data$Arm_Length)
abline(lm(data$Arm_Length ~ data$NFL_QBR), col = "blue")
cor(data$NFL_QBR, data$Arm_Length)

plot(data$NFL_QBR, data$Forty_Yard)
abline(lm(data$Forty_Yard ~ data$NFL_QBR), col = "blue")
cor(data$NFL_QBR, data$Forty_Yard)

plot(data$NFL_QBR, data$Vertical_Leap)
abline(lm(data$Vertical_Leap ~ data$NFL_QBR), col = "blue")
cor(data$NFL_QBR, data$Vertical_Leap)

plot(data$NFL_QBR, data$Broad_Jump)
abline(lm(data$Broad_Jump ~ data$NFL_QBR), col = "blue")
cor(data$NFL_QBR, data$Broad_Jump)

plot(data$NFL_QBR, data$Shuttle)
abline(lm(data$Shuttle ~ data$NFL_QBR), col = "blue")
cor(data$NFL_QBR, data$Shuttle)

plot(data$NFL_QBR, data$Games)
abline(lm(data$Games ~ data$NFL_QBR), col = "blue")
cor(data$NFL_QBR, data$Games)

plot(data$NFL_QBR, data$Completion_Percentage)
abline(lm(data$Completion_Percentage ~ data$NFL_QBR), col = "blue")
cor(data$NFL_QBR, data$Completion_Percentage)

plot(data$NFL_QBR, data$Yards)
abline(lm(data$Yards ~ data$NFL_QBR), col = "blue")
cor(data$NFL_QBR, data$Yards)

plot(data$NFL_QBR, data$Y.A)
abline(lm(data$Y.A ~ data$NFL_QBR), col = "blue")
cor(data$NFL_QBR, data$Y.A)

plot(data$NFL_QBR, data$TD)
abline(lm(data$TD ~ data$NFL_QBR), col = "blue")
cor(data$NFL_QBR, data$TD)

plot(data$NFL_QBR, data$INT)
abline(lm(data$INT ~ data$NFL_QBR), col = "blue")
cor(data$NFL_QBR, data$INT)

plot(data$NFL_QBR, data$College_QBR)
abline(lm(data$College_QBR ~ data$NFL_QBR), col = "blue")
cor(data$NFL_QBR, data$College_QBR)

plot(data$NFL_QBR, data$Rushing_Yds)
abline(lm(data$Rushing_Yds ~ data$NFL_QBR), col = "blue")
cor(data$NFL_QBR, data$Rushing_Yds)

plot(data$NFL_QBR, data$Rushing_Avg)
abline(lm(data$Rushing_Avg ~ data$NFL_QBR), col = "blue")
cor(data$NFL_QBR, data$Rushing_Avg)

plot(data$NFL_QBR, data$Rushing_Td)
abline(lm(data$Rushing_Td ~ data$NFL_QBR), col = "blue")
cor(data$NFL_QBR, data$Rushing_Td)

plot(data$NFL_QBR, data$TdInt)
abline(lm(data$TdInt ~ data$NFL_QBR), col = "blue")
cor(data$NFL_QBR, data$TdInt)

fit = glm(data$Power_Five ~ data$NFL_QBR, family = binomial)
p <- ggplot(data, aes(x = NFL_QBR, y = Power_Five)) +
  geom_point() + 
  geom_smooth(method = "glm",
              method.args = list(family = "binomial"), 
              se = FALSE)
print(p)