library(dplyr)
library(readr)
url<-'http://people.terry.uga.edu/rwatson/data/manheim.txt'
df<-as_data_frame(read_delim(url, delim=','))

#9a: create a bar chart for sales of each model
colors<-c("blue", "orange", "gray")
barplot(table(df$model), col=colors, ylab="Number of Sales")

#9b: create a bar chart for sales by each form of sale
counts <- table(df$sale, df$model)
colors<-c("blue", "red")
barplot(table(df$sale), col=colors, ylab="Number of Sales")

#10: Use the 'Import Dataset' feature of RStudio to read
#a csv. Do a Box plot of cost. What do you conclude about
#cost?

library(readr)
electricityprices <- read_csv("http://people.terry.uga.edu/rwatson/data/electricityprices.csv")
df2<-as_data_frame(electricityprices)

boxplot(df2$cost, data=df2, main="Electricity Cost Box Plot"
        , ylab="Cost")