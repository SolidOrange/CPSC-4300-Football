rm(list=ls())

response.data <- read.csv('Response_Dataset.csv')
attach(response.data)

fit <- lm(NFL_QBR ~ Height + Weight + Hand_Size, data=response.data)
step <- stepAIC(fit, direction="both")
step$anova # display results

lm.fit <- lm(NFL_QBR ~ Height + Weight + Arm_Length + Hand_Size + Forty_Yard + Shuttle  
             + Games + Completions + Attempts + Completion_Percentage + Yards
             + Y.A + TD + INT + College_QBR + Rush_Attempts + Rushing_Yds + Rushing_Avg
             + Rushing_Td + Rank + Power_Five)
summary(lm.fit)
confint(lm.fit)

qbr <-  ((8.4 * 1812) + (330 * 16) + (100 * 152) - (200 * 6)) / 270

test.data <- data.frame(data=c(77,237, 33.25, 10.13, 4.75, 4.4, 11, 152, 270, 56.3, 1812, 
                                6.7, 16, 6, qbr, 92, 204, 2.2, 5, 0, FALSE))
predict(lm.fit, test.data, interval='predict')
