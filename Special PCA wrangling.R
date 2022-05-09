PCA_wrangle <- function(df){
  name <- paste0(deparse(substitute(df)), "_PCA_", num_PC, "_sf")
  
  df <- df %>% mutate(time=row_number())
  df1<- filter(df, Y==1)
  df0 <- filter(df, Y==0)
  
  a1 <- as.matrix(df1[, -c(1:3)])
  b1 <- as.matrix(pca_first_n(df1))
  
  temp1 <- as.data.frame(cbind(df1[,1], a1 %*% b1[, c(1:num_PC)]))
  dimnames(temp1)[[2]][1] <- "Y"
  time <- df1[,"time"]
  temp1 <- cbind(temp1,time)
  
  a0 <- as.matrix(df0[, -c(1:3)])
  b0 <- as.matrix(pca_first_n(df0))
  temp0 <- as.data.frame(cbind(df0[,1], a0 %*% b0[, c(1:num_PC)]))
  dimnames(temp0)[[2]][1] <- "Y"
  time <- df0[,"time"]
  temp0 <- cbind(temp0,time)
  
  temp <- rbind(temp0,temp1)
  temp <- temp[order(temp$time),]
  rownames(temp) <- c(1:nrow(temp))
  temp <- temp[,c(1:(ncol(temp)-1))]

  assign(name, temp,envir = globalenv())
  #return(name)
}
# PCA_wrangle(Z_416)

