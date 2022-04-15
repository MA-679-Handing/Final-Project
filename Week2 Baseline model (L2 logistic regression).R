library(tidyverse)
library(caret)
library(glmnet)

#Data warngle about Z_416
Z_416_modify <- Z_416
Z_416_modify %<>% 
  unite(col = "Y", Y1:Y2, remove = F, sep = "")


# This tells you distribution of combinations of Y.
Z_416_modify %<>% 
  filter(Y!= "00")

Z_416_modify %<>% 
  mutate(Y=recode(Y, '01' = 0, '10' = 1 ))

head(Z_416_modify)

Z_416_modify$Y1 <- NULL
Z_416_modify$Y2 <- NULL
head(Z_416_modify)


#L2 logistic regression

#split the data into training and test set
set.seed(2022)
training.samples <- Z_416_modify$Y %>% 
  createDataPartition(p = 0.8, list = FALSE)
train.data  <- Z_416_modify[training.samples, ]
test.data <- Z_416_modify[-training.samples, ]

# Create model matrix
x <- model.matrix(Y~., train.data)[,-1]
y <- train.data$Y

#Find the appropriate tuning parameter
cv.ridge <- cv.glmnet(x, y, alpha = 0, family = "binomial")

# Fit the final model on the training data
model <- glmnet(x, y, alpha = 0, family = "binomial",
                lambda = cv.ridge$lambda.min)

# Display regression coefficients
coef(model)

# Make predictions on the test data
x.test <- model.matrix(Y ~., test.data)[,-1]
probabilities <- model %>% predict(newx = x.test)
predicted.classes <- ifelse(probabilities > 0.5, 1, 0)

# Model accuracy
observed.classes <- test.data$Y
mean(predicted.classes == observed.classes)
