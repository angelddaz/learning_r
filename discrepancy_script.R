df <- read.csv("aligning.csv")
df2 <- read.csv("aligning2.csv")

print(head(df))

#there are three iteration buckets that are the easiest to check if they match across datasets
first_iteration_count <- sum(df$Iteration.Name == "Ends:06.27.2017")
second_iteration_count <- sum(df$Iteration.Name == "Ends:07.11.2017")
third_iteration_count <- sum(df$Iteration.Name == "Ends:07.25.2017")

counts1 <- c(first_iteration_count, second_iteration_count, third_iteration_count)
print(counts1)

first_iteration_count2 <- sum(df2$Iteration.Name == "06.27.2017")
second_iteration_count2 <- sum(df2$Iteration.Name == "07.11.2017")
third_iteration_count2 <- sum(df2$Iteration.Name == "07.25.2017")

counts2 <- c(first_iteration_count2, second_iteration_count2, third_iteration_count2)
print(counts2)


counts <- rbind(counts1, counts2)
colnames(counts) <- c("1st Iter", "2nd Iter", "3rd Iter")
rownames(counts) <- c("tableau data", "SQL Server Data")
print(counts)

#subsetting the data into the only iteration which has a discrepancy in counts
newdf <- subset(df, df$Iteration.Name == "Ends:06.27.2017")
newdf2 <- subset(df2, df2$Iteration.Name == "06.27.2017")

#cleaning up variables
remove(counts1, counts2, first_iteration_count, first_iteration_count2, second_iteration_count
	   , second_iteration_count2, third_iteration_count, third_iteration_count2, counts
	   , df, df2)

#dropping a column from newdf
newdf <- newdf[, c(1, 2, 4, 5, 6)]

#extracting one column to change the string so that "Ends:" is removed from Tableau dataset
newdf$Iteration.Name <- gsub("Ends:", "", newdf$Iteration.Name)


newdf$included_tab <- TRUE
newdf2$included_sql <- TRUE
res <- merge(newdf, newdf2, all=TRUE)

#A way to extract the differences.
res2 <- subset(res, is.na(res$included_tab))# || res$included_sql != TRUE)
res3 <- subset(res, is.na(res$included_sql))
res4 <- merge(res2, res3, all=TRUE)

#Here is another way to do it which is a lot less code.
#install.packages("sqldf")
require(sqldf)
diff2 <- sqldf('SELECT * FROM newdf EXCEPT SELECT * FROM newdf2')