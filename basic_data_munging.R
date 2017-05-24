#DATA MANAGEMENT

#1: Reshaping Data
df <- data.frame(ID=c(1:3), name=c("Steve", "Frank", "Mary"), c(56,89,65), c(80,90,100))
colnames(df) <- c("ID", "Name", "2013", "2014")

if(FALSE){
  df2 <- reshape(df, varying=c("2013", "2014"), v.names="Percent", timevar="Year", times=c("2013", "2014"),
                 new.row.names=1:6, direction="long")
  #method 2 transforming from wide to long format:
  #install.packages("reshape")
  library(reshape)
  df3 <- melt(df, id=c("ID", "Name"))
  df3
}

#2: Merging Data
if(FALSE){
  df <- data.frame(name=c("Steve", "Joe", "Frank"), ID=c(1:3))
  df2 <- data.frame(ID=c(1:3),country=c("United States", "Canada", "Mexico"))
  df3 <- merge(df, df2, by="ID")
  df3
}

#3: Transposing Data
if(FALSE){
  mtcars
  carmpg <- mtcars[order(-mtcars$mpg),]
  head(carmpg)
  
  carmpg <- carmpg[1:10, c(1, 2, 4, 6)]
  carmpg
  carmpg <- data.frame(t(carmpg))
  carmpg
  carmpg$Toyota.Corolla
}

#4: Aggregating Data
if(FALSE){
  ?aggregate
  ag <- aggregate(mtcars$mpg, list(mtcars$cyl), mean)
  ag
  df <- read.csv("https://health.data.ny.gov/api/views/jxy9-yhdk/rows.csv?accessType=DOWNLOAD")
  summary(df)
  head(df)
  df2 <- df[,c(2,5)]
  head(df2)
  df2 <- aggregate(df$Count, list(df$First.Name), sum)
  head(df2)
}

#5: Basic Imputation
if(FALSE){
  head(airquality) #there are NA observations
  df <- na.omit(airquality)
  str(airquality) #43 observations more
  complete.cases(airquality) #FALSE if contains any NA points
  head(airquality[,c(1,3,4,5,6)])
  
  airquality[complete.cases(airquality[,c(1,3,4,5,6)]),]
  df <- data.frame(email=c("steve@email.com", "jim@email.com", "mary@email.com"), newsletter=
                     c(F, NA, T))
  df
  df[is.na(df)] <- F #Changing NA values to False
  df
}

#6: Linear Fitted Imputation
if(FALSE){
  install.packages("Hmisc")
  ??aregImpute
  library(Hmisc)
  head(airquality)
  df <- aregImpute(~Ozone + Solar.R + Wind + Temp + Month + Day,
                   data=airquality, match='closest', type='pmm', boot.method='simple', n.impute=10)
  df$imputed
  df$imputed$Solar.R #10 different sets of 7 NA values . 5 is default
}

#7: Categorize Continuous Variables
if(FALSE){
  a = c(1:3)
  cut(a, breaks=c(0,2,4), right=TRUE, labels=c("lower","upper")) #There are two intervals
  
  cut(airquality$Temp, breaks=c(0,70,90,150), labels=c("cold","nice","hot"))
  #categorizing into qualitative from quantitative using the cut R function
}