## Author: Handing Zhang
## Purpose of the script: Fit a Random Forest on Z_416

set.seed(100)
library(tree)

Z_416$Y <- as.factor(Z_416$Y)
tree_Z_416 <- tree(Y~ . - Y - Y1 - Y2,  data = Z_416) 
summary(tree_Z_416)

plot(tree_Z_416)
text(tree_Z_416, pretty = 0)


train <- sample(1:nrow(Z_416), nrow(Z_416) / 2)
test <- Z_416[-train, ]
Y_test <- Z_416$Y[-train]

tree.pred <- predict(tree_Z_416, test,
                     type = "class")
table(tree.pred, Y_test)

(566 + 1930) / length(Y_test)







cv.z416 <- cv.tree(tree_Z_416, FUN = prune.misclass)
cv.z416$size


par(mfrow = c(1, 2))
plot(cv.z416$size, cv.z416$dev, type = "b")
plot(cv.z416$k, cv.z416$dev, type = "b")


par(mfrow = c(1,1))
prune_z416 <- prune.misclass(tree_Z_416, best = 11) 
plot(prune_z416)
text(prune_z416, pretty = 0)


tree.pred1 <- predict(prune_z416, test, type = "class")
table(tree.pred1, Y_test) 







