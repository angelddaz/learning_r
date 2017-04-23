library(dplyr)
library(readr)
url<-'http://people.terry.uga.edu/rwatson/data/manheim.txt'
df<-as_data_frame(read_delim(url, delim=','))

#1.a Use the table function to compute the number of
#sales for each type of model
table(df$model)

#1.b Use the table function to compute the number of 
#sales for each type of sale
table(df$sale)

#1.c Report the mean price for each model
df2<- data.frame(df$model, df$price)
aggregate(.~df.model, data=df2, mean)

#1.d Report the mean price for each type of sale
df3<-data.frame(df$sale, df$price)
aggregate(.~df.sale, data=df3, mean)

#removing data objects for a clean environment for #2
rm(df, df2, df3)

#2.a What is the maximum cost
url<-'http://people.terry.uga.edu/rwatson/data/electricityprices.csv'
df<-as_data_frame(read_delim(url, delim=','))
max(df$cost)
#2.b what is the minimum cost
min(df$cost)
#2.c what is the mean cost
mean(df$cost)
#2.d what is the median cost
median(df$cost)