## Author: Handing Zhang
## Purpose of the script: 1. Read in the original data.
##                        2. Basic data wrangling.


## Sourcing this script, one should have all data as data frames in the environment.
## Naming Protocol:            "First Letter of the folder"_"Last three digits of the number of the mouse"
## In each of the dataframe:   the first two columns: Response Y
##                             the rest of the columns: Predictor X





# Loading packages. ####
pacman::p_load(R.matlab, tidyverse, magrittr, mice, reshape)


# Reading in the data. ####
# I sort them by four folders: 1.Data 2. Dir 3. Opp 4. Zero
# Each of the later three folders contains multiple mice. I name their data by LAST THREE DIGITS of their assigned number.
# Two types of data: 1. binned_behavior (list of 1) named by bh  2. binned_zscores. (large list) named by zs
# Naming Protocol: Foldername_DataType_MouseNumber

# The data in main "Data" folder
# Here I ignore the foldername in naming.
bh_1 <- readMat("data/binned_behavior .mat")
bh_2 <- readMat("data/binned_behavior-2 .mat")
zs_1 <- readMat("data/binned_zscore .mat")
zs_2 <- readMat("data/binned_zscore-2 .mat")

# The data from Dir
D_bh_409 <- readMat("data/Dir_Interact/608034_409/Day_1/Trial_002_0/binned_behavior.mat")
D_zs_409 <- readMat("data/Dir_Interact/608034_409/Day_1/Trial_002_0/binned_zscore.mat")

D_bh_412 <- readMat("data/Dir_Interact/608102_412/Day_1/Trial_002_0/binned_behavior.mat")
D_zs_412 <- readMat("data/Dir_Interact/608102_412/Day_1/Trial_002_0/binned_zscore.mat")

D_bh_414 <- readMat("data/Dir_Interact/608102_414/Day_1/Trial_002_0/binned_behavior.mat")
D_zs_414 <- readMat("data/Dir_Interact/608102_414/Day_1/Trial_002_0/binned_zscore.mat")

D_bh_416 <- readMat("data/Dir_Interact/608103_416/Day_1/Trial_002_0/binned_behavior.mat")
D_zs_416 <- readMat("data/Dir_Interact/608103_416/Day_1/Trial_002_0/binned_zscore.mat")


D_bh_417 <- readMat("data/Dir_Interact/608103_417/Day_1/Trial_002_0/binned_behavior.mat")
D_zs_417 <- readMat("data/Dir_Interact/608103_417/Day_1/Trial_002_0/binned_zscore.mat")

D_bh_418 <- readMat("data/Dir_Interact/608103_418/Day_1/Trial_002_0/binned_behavior.mat")
D_zs_418 <- readMat("data/Dir_Interact/608103_418/Day_1/Trial_002_0/binned_zscore.mat")


# The data from OPP
O_bh_409 <- readMat("data/Opp_Sex/608034_409/Day_1/Trial_002_0/binned_behavior.mat")
O_zs_409 <- readMat("data/Opp_Sex/608034_409/Day_1/Trial_002_0/binned_zscore.mat")

O_bh_412 <- readMat("data/Opp_Sex/608102_412/Day_1/Trial_002_0/binned_behavior.mat")
O_zs_412 <- readMat("data/Opp_Sex/608102_412/Day_1/Trial_002_0/binned_zscore.mat")

O_bh_414 <- readMat("data/Opp_Sex/608102_414/Day_2/Trial_002_0/binned_behavior.mat")
O_zs_414 <- readMat("data/Opp_Sex/608102_414/Day_2/Trial_002_0/binned_zscore.mat")

O_bh_416 <- readMat("data/Opp_Sex/608103_416/Day_2/Trial_002_0/binned_behavior.mat")
O_zs_416 <- readMat("data/Opp_Sex/608103_416/Day_2/Trial_002_0/binned_zscore.mat")


O_bh_417 <- readMat("data/Opp_Sex/608103_417/Day_2/Trial_002_0/binned_behavior.mat")
O_zs_417 <- readMat("data/Opp_Sex/608103_417/Day_2/Trial_002_0/binned_zscore.mat")

O_bh_418 <- readMat("data/Opp_Sex/608103_418/Day_2/Trial_002_0/binned_behavior.mat")
O_zs_418 <- readMat("data/Opp_Sex/608103_418/Day_2/Trial_002_0/binned_zscore.mat")


# The data from Zero
Z_bh_409 <- readMat("data/Zero_Maze/608034_409/Day_1/Trial_001_0/binned_behavior.mat")
Z_zs_409 <- readMat("data/Zero_Maze/608034_409/Day_1/Trial_001_0/binned_zscore.mat")

Z_bh_412 <- readMat("data/Zero_Maze/608102_412/Day_1/Trial_001_0/binned_behavior.mat")
Z_zs_412 <- readMat("data/Zero_Maze/608102_412/Day_1/Trial_001_0/binned_zscore.mat")

Z_bh_414 <- readMat("data/Zero_Maze/608102_414/Day_1/Trial_001_0/binned_behavior.mat")
Z_zs_414 <- readMat("data/Zero_Maze/608102_414/Day_1/Trial_001_0/binned_zscore.mat")

Z_bh_416 <- readMat("data/Zero_Maze/608103_416/Day_1/Trial_001_0/binned_behavior.mat")
Z_zs_416 <- readMat("data/Zero_Maze/608103_416/Day_1/Trial_001_0/binned_zscore.mat")

Z_bh_417 <- readMat("data/Zero_Maze/608103_417/Day_1/Trial_001_0/binned_behavior.mat")
Z_zs_417 <- readMat("data/Zero_Maze/608103_417/Day_1/Trial_001_0/binned_zscore.mat")

Z_bh_418 <- readMat("data/Zero_Maze/608103_418/Day_1/Trial_001_0/binned_behavior.mat")
Z_zs_418 <- readMat("data/Zero_Maze/608103_418/Day_1/Trial_001_0/binned_zscore.mat")

Z_bh_251 <- readMat("data/Zero_Maze/616669_251/Day_1/Trial_001_0/binned_behavior.mat")
Z_zs_251 <- readMat("data/Zero_Maze/616669_251/Day_1/Trial_001_0/binned_zscore.mat")

Z_bh_256 <- readMat("data/Zero_Maze/619539_256/Day_1/Trial_001_0/binned_behavior.mat")
Z_zs_256 <- readMat("data/Zero_Maze/619539_256/Day_1/Trial_001_0/binned_zscore.mat")

Z_bh_257 <- readMat("data/Zero_Maze/619539_257/Day_1/Trial_001_0/binned_behavior.mat")
Z_zs_257 <- readMat("data/Zero_Maze/619539_257/Day_1/Trial_001_0/binned_zscore.mat")

Z_bh_258 <- readMat("data/Zero_Maze/619539_258/Day_1/Trial_001_0/binned_behavior.mat")
Z_zs_258 <- readMat("data/Zero_Maze/619539_258/Day_1/Trial_001_0/binned_zscore.mat")

Z_bh_274 <- readMat("data/Zero_Maze/619541_274/Day_1/Trial_001_0/binned_behavior.mat")
Z_zs_274 <- readMat("data/Zero_Maze/619541_274/Day_1/Trial_001_0/binned_zscore.mat")

Z_bh_254 <- readMat("data/Zero_Maze/619542_254/Day_1/Trial_001_0/binned_behavior.mat")
Z_zs_254 <- readMat("data/Zero_Maze/619542_254/Day_1/Trial_001_0/binned_zscore.mat")

Z_bh_255 <- readMat("data/Zero_Maze/619542_255/Day_1/Trial_001_0/binned_behavior.mat")
Z_zs_255 <- readMat("data/Zero_Maze/619542_255/Day_1/Trial_001_0/binned_zscore.mat")



## Convert data from list into data frames. ####
## Notice proper column names are to be assigned into the converted data frames later.
## Observe that the original data are all list of length of 1, where the one object is the our data.


# The data in main "Data" folder

#
# str(bh_1$binned.behavior)
# bh_1 <- data.frame(matrix(bh_1$binned.behavior, byrow = T, nrow = 6300))


# A function that converts our list of length one into dataframe with correct number of rows.
# Input lt: list name   type: binned.behavior   or   binned.zscore
# Output df: the lt converted to dataframe with name unchanged.


list_to_dataframe <- function(lt, type = "behavior"){
  if (type == "behavior"){
  n_row <- dim(lt[[1]])[2]
  df <- data.frame(matrix(lt[[1]], byrow = T, nrow = n_row))
  }
  else if(type == "zscore"){
    n_row <- dim(lt[[1]])[1]
    df <- data.frame(matrix(lt[[1]], byrow = T, nrow = n_row))
  }
return(df)
}


# Data Folder
bh_1 <- list_to_dataframe(bh_1)
bh_2 <- list_to_dataframe(bh_2)

zs_1 <- list_to_dataframe(zs_1, type = "zscore")
zs_2 <- list_to_dataframe(zs_2, type = "zscore")


# Dir Folder
D_bh_409 <- list_to_dataframe(D_bh_409)
D_zs_409 <- list_to_dataframe(D_zs_409, type = "zscore")

D_bh_412 <- list_to_dataframe(D_bh_412)
D_zs_412 <- list_to_dataframe(D_zs_412, type = "zscore")

D_bh_414 <- list_to_dataframe(D_bh_414)
D_zs_414 <- list_to_dataframe(D_zs_414, type = "zscore")

D_bh_416 <- list_to_dataframe(D_bh_416)
D_zs_416 <- list_to_dataframe(D_zs_416, type = "zscore")

D_bh_417 <- list_to_dataframe(D_bh_417)
D_zs_417 <- list_to_dataframe(D_zs_417, type = "zscore")


D_bh_418 <- list_to_dataframe(D_bh_418)
D_zs_418 <- list_to_dataframe(D_zs_418, type = "zscore")



# Opp Folder
O_bh_409 <- list_to_dataframe(O_bh_409)
O_zs_409 <- list_to_dataframe(O_zs_409, type = "zscore")

O_bh_412 <- list_to_dataframe(O_bh_412)
O_zs_412 <- list_to_dataframe(O_zs_412, type = "zscore")

O_bh_414 <- list_to_dataframe(O_bh_414)
O_zs_414 <- list_to_dataframe(O_zs_414, type = "zscore")

O_bh_416 <- list_to_dataframe(O_bh_416)
O_zs_416 <- list_to_dataframe(O_zs_416, type = "zscore")

O_bh_417 <- list_to_dataframe(O_bh_417)
O_zs_417 <- list_to_dataframe(O_zs_417, type = "zscore")


O_bh_418 <- list_to_dataframe(O_bh_418)
O_zs_418 <- list_to_dataframe(O_zs_418, type = "zscore")

# Zero Foldr

Z_bh_409 <- list_to_dataframe(Z_bh_409)
Z_zs_409 <- list_to_dataframe(Z_zs_409, type = "zscore")

Z_bh_412 <- list_to_dataframe(Z_bh_412)
Z_zs_412 <- list_to_dataframe(Z_zs_412, type = "zscore")

Z_bh_414 <- list_to_dataframe(Z_bh_414)
Z_zs_414 <- list_to_dataframe(Z_zs_414, type = "zscore")

Z_bh_416 <- list_to_dataframe(Z_bh_416)
Z_zs_416 <- list_to_dataframe(Z_zs_416, type = "zscore")

Z_bh_417 <- list_to_dataframe(Z_bh_417)
Z_zs_417 <- list_to_dataframe(Z_zs_417, type = "zscore")

Z_bh_418 <- list_to_dataframe(Z_bh_418)
Z_zs_418 <- list_to_dataframe(Z_zs_418, type = "zscore")

Z_bh_251 <- list_to_dataframe(Z_bh_251)
Z_zs_251 <- list_to_dataframe(Z_zs_251, type = "zscore")

Z_bh_254 <- list_to_dataframe(Z_bh_254)
Z_zs_254 <- list_to_dataframe(Z_zs_254, type = "zscore")

Z_bh_255 <- list_to_dataframe(Z_bh_255)
Z_zs_255 <- list_to_dataframe(Z_zs_255, type = "zscore")

Z_bh_256 <- list_to_dataframe(Z_bh_256)
Z_zs_256 <- list_to_dataframe(Z_zs_256, type = "zscore")

Z_bh_257 <- list_to_dataframe(Z_bh_257)
Z_zs_257 <- list_to_dataframe(Z_zs_257, type = "zscore")

Z_bh_258 <- list_to_dataframe(Z_bh_258)
Z_zs_258 <- list_to_dataframe(Z_zs_258, type = "zscore")

Z_bh_274 <- list_to_dataframe(Z_bh_274)
Z_zs_274 <- list_to_dataframe(Z_zs_274, type = "zscore")



# Combine behavior and zscore for each mouse in each experiment. ####
# Naming protocol: Foder_MouseNumber


# Data Folder

Data_1 <- cbind(bh_1, zs_1)
Data_2 <- cbind(bh_2, zs_2)

# Dir Folder

D_409 <- cbind(D_bh_409, D_zs_409)
D_412 <- cbind(D_bh_412, D_zs_412)
D_414 <- cbind(D_bh_414, D_zs_414)
D_416 <- cbind(D_bh_416, D_zs_416)
D_417 <- cbind(D_bh_417, D_zs_417)
D_418 <- cbind(D_bh_418, D_zs_418)


# Opp Folder

O_409 <- cbind(O_bh_409, O_zs_409)
O_412 <- cbind(O_bh_412, O_zs_412)
O_414 <- cbind(O_bh_414, O_zs_414)
O_416 <- cbind(O_bh_416, O_zs_416)
O_417 <- cbind(O_bh_417, O_zs_417)
O_418 <- cbind(O_bh_418, O_zs_418)

# Zero Folder

Z_409 <- cbind(Z_bh_409, Z_zs_409)
Z_412 <- cbind(Z_bh_412, Z_zs_412)
Z_414 <- cbind(Z_bh_414, Z_zs_414)
Z_416 <- cbind(Z_bh_416, Z_zs_416)
Z_417 <- cbind(Z_bh_417, Z_zs_417)
Z_418 <- cbind(Z_bh_418, Z_zs_418)
Z_251 <- cbind(Z_bh_251, Z_zs_251)
Z_254 <- cbind(Z_bh_254, Z_zs_254)
Z_255 <- cbind(Z_bh_255, Z_zs_255)
Z_256 <- cbind(Z_bh_256, Z_zs_256)
Z_257 <- cbind(Z_bh_257, Z_zs_257)
Z_258 <- cbind(Z_bh_258, Z_zs_258)
Z_274 <- cbind(Z_bh_274, Z_zs_274)




# Change the names of the first two columns to avoid duplication. ####
v_list <-  list(D_409, D_412, D_414, D_416, D_417, D_418, Data_1, Data_2, O_409, O_412, O_414, O_416,
                O_417, O_418, Z_251, Z_254, Z_255, Z_256, Z_257, Z_258, Z_274, Z_409, Z_412, 
                Z_414, Z_416, Z_417, Z_418)


for (i in 1:length(v_list)){
  v_list[[i]] %<>%
    dplyr::select(Y1 = 1, Y2 = 2, dplyr::everything())
}


D_409 <- v_list[[1]]
D_412 <- v_list[[2]]
D_414 <- v_list[[3]]
D_416 <- v_list[[4]]
D_417 <- v_list[[5]]
D_418  <- v_list[[6]]
Data_1  <- v_list[[7]]
Data_2  <- v_list[[8]]
O_409  <- v_list[[9]]
O_412  <- v_list[[10]]
O_414  <- v_list[[11]]
O_416 <- v_list[[12]]
O_417 <- v_list[[13]]
O_418  <- v_list[[14]]
Z_251  <- v_list[[15]]
Z_254  <- v_list[[16]]
Z_255 <- v_list[[17]]
Z_256  <- v_list[[18]]
Z_257  <- v_list[[19]]
Z_258  <- v_list[[20]]
Z_274  <- v_list[[21]]
Z_409  <- v_list[[22]]
Z_412  <- v_list[[23]]
Z_414 <- v_list[[24]]
Z_416  <- v_list[[25]]
Z_417  <- v_list[[26]]
Z_418 <- v_list[[27]]







# Clear Environment, leaving final datasets we need. ####
rm(list= ls()[!(ls() %in% c("Data_1", "Data_2", "D_409", "D_412", "D_414", "D_416", "D_417", "D_418", "O_409",
"O_412", "O_414", "O_416", "O_417", "O_418", "Z_409", "Z_412", "Z_414", "Z_416", "Z_417", "Z_418", "Z_251", "Z_254",
"Z_255", "Z_256", "Z_257", "Z_258", "Z_274"))])





