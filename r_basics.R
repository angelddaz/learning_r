#IMPORTANT R BASICS 
#1: Data Frames
if(FALSE){
  first_name <- c("Steve", "Joe", "Frank")
  rank <- c(1:3)
  bool <- c(FALSE, FALSE, TRUE)
  
  df <- data.frame(first_name, rank, bool)
  dim(df)
  names(df)
  head(trees)
  nrow(trees)
  ncol(trees)
  summary(trees)
  summary(df)
  
  str(trees) #structure of a frame
}

#2: The Structure Function str
if(FALSE){
  str(AirPassengers)
  str(trees)
  str(airquality)
}

#3: Summary Statistics
if(FALSE){
  df <- read.csv("https://health.data.ny.gov/api/views/jxy9-yhdk/rows.csv?accessType=DOWNLOAD")
  str(df)
  head(df)
  summary(df)
  summary(df$First.Name)
  
  str(airquality)
  head(airquality)
  summary(airquality)
  summary(airquality$Temp)
  airquality$Temp <- (airquality$Temp - 32) * (5/9)
  summary(airquality$Temp)
}
#4: Import JSON Data
if(FALSE){
  library(jsonlite)
  jd <- jsonlite::fromJSON("https://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA")
}

#5: Foreach Looping
if(FALSE){
  #install.packages("foreach")
  library(foreach)
  foreach(i=1:10) %do% #loop on a single processor
    rnorm(i)
  # install.packages("doParallel")
  library(doParallel)
  cl <- makeCluster(4)
  registerDoParallel(cl)
  
  foreach(i-1:10) %dopar%
    rnorm(i)
  
  v <- foreach(i=1:10, .combine=c) %dopar%
    rnorm(i)
  v2 <- foreach(i=1:5, .combine=rbind) %do%
    i
  v2
  v3 <- foreach(i=1:5, .combine=cbind) %do%
    c(i, i^2)
  v3
}