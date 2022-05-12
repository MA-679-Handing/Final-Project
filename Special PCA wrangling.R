#Normal PCA
pca_first_n <- function(df){
  pr.out <- prcomp(df[, -c(1:3)])
  out1 <- pr.out$rotation 
  
  pr.var <- pr.out$sdev^2
  pve <- pr.var / sum(pr.var)
  # out2 <- pve
  # 
  # out3 <- sum(pve[1:num_pc])
  # print(out1)
  # print(out2)
  # print(out3)
  return(out1)
} 

num_PC <- 26

PCA_wrangle <- function(df){
  a <- as.matrix(df[, -c(1:3)])
  b <- as.matrix(pca_first_n(df))
  name <- paste0(deparse(substitute(df)), "_PCA_", num_PC)
  temp <- as.data.frame(cbind(df[,1], a %*% b[, c(1:num_PC)]))
  dimnames(temp)[[2]][1] <- "Y"
  assign(name, temp,envir = globalenv())
}

PCA_wrangle(Z_409)
PCA_wrangle(Z_257)
PCA_wrangle(Z_274)
PCA_wrangle(Z_258)
PCA_wrangle(Z_251)
PCA_wrangle(Z_412)
PCA_wrangle(Z_416)
PCA_wrangle(Z_418)

#Special PCA
PCA_wrangle_sf <- function(df){
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
# PCA_wrangle_sf(Z_416)

