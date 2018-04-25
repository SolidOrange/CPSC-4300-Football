rm(list = ls())

create.folds = function(N.data, number.folds) {    
  fold.assignment = ceiling(seq(1,N.data)/(N.data/number.folds))
  return(fold.assignment)
}

set.seed(42)
library(ISLR)
library(boot)

# Author: John Grider
# Date: April 24, 2018
# Purpose: Select a model for predicting NFL QB success

setwd("/Users/Will/Developer/GitHub/CPSS-4300-Football/QB_Study/EDA")
data <- read.csv("Response_Dataset.csv")

m.height = lm(data$NFL_QBR ~ data$Height)
m.weight = lm(data$Weight ~ data$NFL_QBR)
m.hand_size = lm(data$Hand_Size ~ data$NFL_QBR)
m.arm_length = lm(data$Arm_Length ~ data$NFL_QBR)
m.forty = lm(data$Forty_Yard ~ data$NFL_QBR)
m.shuttle = lm(data$Shuttle ~ data$NFL_QBR)
m.games = lm(data$Games ~ data$NFL_QBR)
m.completions = lm(data$Completions ~ data$NFL_QBR)
m.attempts = lm(data$Attempts ~ data$NFL_QBR)
m.complper = lm(data$Completion_Percentage ~ data$NFL_QBR)
m.yards = lm(data$Yards ~ data$NFL_QBR)
m.yardattempt = lm(data$Y.A ~ data$NFL_QBR)
m.TD = lm(data$TD ~ data$NFL_QBR)
m.INT = lm(data$INT ~ data$NFL_QBR)

ints = data$INT
for(i in 1:197) {
  if(ints[i] == 0) {
    ints[i] = 1
  }
}

data$TDINT = data$TD / ints
m.TDINT = lm(data$TDINT ~ data$NFL_QBR)
m.collQBR = lm(data$College_QBR ~ data$NFL_QBR)
m.rushatt = lm(data$Rush_Attempts ~ data$NFL_QBR)
m.rushyar = lm(data$Rushing_Yds ~ data$NFL_QBR)
m.rushavg = lm(data$Rushing_Avg ~ data$NFL_QBR)
m.rushtd = lm(data$Rushing_Td ~ data$NFL_QBR)

# Lowest p-values include: completion percentage, completions, attempts, TD, and yards

m.joint = lm(data$NFL_QBR ~ data$Completion_Percentage + data$Completions + data$Yards)

# K-Fold cross validation:
# Manual cross validation

NFL_QBR = data$NFL_QBR
Completion_Percentage = data$Completion_Percentage
Completions = data$Completions
Yards = data$Yards
QBR = NULL

N = nrow(data)
k = 10
fold = ceiling(seq(1,N)/(N/k))
# fold = create.folds(N, k)
randomized.index = sample(N,N)
accuracy = rep(NA, k)
for(i in 1:k) {
  train = randomized.index[fold!=i]
  difference = setdiff(randomized.index, train)
  howLong = length(difference)
  for(j in 1:howLong) {
    z = difference[j]
    QBR[j] = data$NFL_QBR[z]
  }
  fit = glm(NFL_QBR ~ Completion_Percentage + Completions + Yards, subset=train)
  # calculate predicted probabilities
  pred.QBR = predict(fit, data[-train, ], type = "response")    
  # calculate accuracy
  if(pred.QBR[i] > QBR[i]) {
    accuracy[i] = pred.QBR[i] - QBR[i]
  }
  if(pred.QBR[i] <= QBR[i]) {
    accuracy[i] = QBR[i] - pred.QBR[i]
  }
}
error.rate <- 1 - accuracy

