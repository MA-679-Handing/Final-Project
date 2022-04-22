###RNN for mouse dataset####

library(keras) # for deep learning
library(tidyverse) # general utility functions
library(caret)

Z_416 <- Z_416[,-c(2:3)]
z416matrix <- data.matrix(Z_416)
test <-c(4001:6155)
train <- c(1:4000)

lagm <- function(x, k = 1) {
  n <- nrow(x)
  pad <- matrix(NA , k, ncol(x))
  rbind(pad , x[1:(n - k), ])
}

arframe <- data.frame(Y = z416matrix[, "Y"],
                      L1 = lagm(z416matrix , 1), L2 = lagm(z416matrix , 2),
                      L3 = lagm(z416matrix , 3), L4 = lagm(z416matrix , 4),
                      L5 = lagm(z416matrix , 5)
)
arframe <- arframe[-c(1:5),]
artrain <- arframe[c(1:4000),]
artest <- arframe[c(4001:6150),]

arfit <- glm(Y ~ ., data = artrain, family = "binomial")

arpred <- predict(arfit, artest,type = "response")
arpred <- ifelse(arpred > 0.5, 1, 0)

a<-mean(artest[,1] == arpred)
