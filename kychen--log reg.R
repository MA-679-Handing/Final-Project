# Combine Y1 Y2 into Y, so we only need to analyze one output.
library(dplyr)
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

#Z_416_temp--logistic regression model
Z_416_modify$Y<-as.factor(Z_416_modify$Y)
str(Z_416_modify)

summary(Z_416_modify)

split<- sample(c(rep(0, 0.7 * nrow(Z_416_modify)), rep(1, 0.3 * nrow(Z_416_modify))))


Z_416_modify_train<-Z_416_modify[split==0,]
Z_416_modify_test<-Z_416_modify[split==1,]

head(Z_416_modify_train)


lr_Z416<-glm(Y~.,data=Z_416_modify_train,family="binomial")
summary(lr_Z416)

#Z_416_temp--CI by profiled log-likelihood/se

confint(lr_Z416)
confint.default(lr_Z416)

#wald.test
library(aod)
wald.test(b=coef(lr_Z416),Sigma=vcov(lr_Z416),Terms=2:26)

#odds ratio/95%CI
exp(cbind(OR=coef(lr_Z416),confint(lr_Z416)))


#predict
predict_Z416_lr<-predict(lr_Z416,Z_416_modify_test, type = 'response')

summary(predict_Z416_lr)

# confusion matrix
table_cm <- table(Z_416_modify_test$Y, predict_Z416_lr > 0.5)
table_cm

#Accuracy

accuracy_Test <- sum(diag(table_cm)) / sum(table_cm)
accuracy_Test