# This is a compilation of state data on the affordable care act
# I got data here:
# https://aspe.hhs.gov/compilation-state-data-affordable-care-act

# There were multiple hierarchies of columns which I combined into one row of column names
# I thought it would be preferable to have a long name then to have multiple rows describing columns of data
# I did this in Excel. Forgive me Chris Albon.
# I promise the rest will be in Rstudio.

df <- read.csv('coverage.csv')
# ok right off the bat I'm not used to dealing with this many columns (73!)
# time to pick a few columns to see the state of changes with states
head(df)
# There are five sections to these 25 columns other than the State Names:
# 1. Coverage rates 
# 2-5. Coverage types: 
# Employer coverage, Medicaid, Individual Market Coverage, & Medicare

# For now I'm just going to focus on coverage rates
colnames(df)
# which looks like columns 2 - 5
df <- df[,1:5]
head(df)
# ok my first question is why we have 52 observations with 50 states.
# the first row is "United States" so that explains one. I'm guessing D.C. for the 52nd?
# maybe it's in the "tail" of the dataset
tail(df)
# nope.
# I'm going to look into the whole column alone
print(df$State)
# OK I see District of Columbia here.
print(df[1:2,]) 
# I want to look at the United States data and see if I want to keep it for this step.
# Maybe I want to focus this thought process and exploration to states only for now.
states <- df[2:52,]
country <- df[1,]
# splitting up the data so that the exploration remains focused
head(states)
head(country)
# I really don't like what these columns are named. 
# I know I made them when combining multiple row hierarchy of column names but
# since the conversation is being narrowed: states, coverage rates, I think it's fair to focus the
# column names as well.
colnames(states)
cols <- colnames(states[,2:5])
cols <- gsub("Coverage.Gains.", "", cols)
a = data.frame("data" = cols, "data2" = 1:4)
a$data <- as.character(a$data)
a$data = substr(a$data, 1, nchar(a$data) - 4) # removing dots
cols[2:5] <- a$data
cols[1] <- colnames(states)[1] # not sure why the first one didn't stay the same.
cols
# haha wow so that took a while. Removed those trailing periods.
# time to replace the colnames with these new ones
colnames(states) <- cols
colnames(country) <- cols
head(states)

# column 4 is cols 2 minus 3
# Did any states lose net coverage?
# I am forgetting the syntax for subset.
?subset
# So a good way to check is if any uninsured rates increased from 2010 to 2015
negatives <- subset(states, states$Uninsured.Rate.2015 > states$Uninsured.Rate.2010)
negatives
# 0 rows. not a single state, nor D.C., increase uninsured rates

# I wonder which states saw the biggest decreases
# states$Percentage.Point.Decrease.in.Uninsured.Rate.2010.2015
# wow what a clunky column name
ordered_states <- states[order(-states[,4]), ]
df <- ordered_states
colnames(df)[4] <- '% Decrease in Uninsured (2010-2015)'
head(df)
plot(df$Uninsured.Rate.2010, df$Uninsured.Rate.2015, xlim = c(0, 25), ylim = c(0, 25), 
	 xlab = 'Uninsured % Rate (2010)', ylab = 'Uninsured % Rate (2015)')
text(df$Uninsured.Rate.2010, df$Uninsured.Rate.2015, labels=df$State)
# COOL!  but kind of a mess even if you zoom in.
df2 <- head(df, n = 15) # picking top 15

# I want to concatenate the order in which these appear in the dataframe (Rate decrease order)
df2$Index <- 1:15
df2$sep <- ": "
df2$State <-paste(df2$Index, df2$sep, df2$State, sep="")
plot(df2$Uninsured.Rate.2010, df2$Uninsured.Rate.2015, xlim = c(0, 25), ylim = c(0, 25), 
	 xlab = 'Uninsured % Rate (2010)', ylab = 'Uninsured % Rate (2015)')
text(df2$Uninsured.Rate.2010, df2$Uninsured.Rate.2015, labels=df2$State)
# ok they still kind of crash into each other a little bit but we get the idea.

# Trying a similar view. We have the starting points on the horizontal axes and the vertical axis
# shows which ones decreases the most. They points crash into each other more.
plot(df2$Uninsured.Rate.2010, df2$`% Decrease in Uninsured (2010-2015)`, xlim = c(0, 25), ylim = c(0, 25), 
	 xlab = 'Uninsured % Rate (2010)', ylab = '% Decrease in Uninsured')
text(df2$Uninsured.Rate.2010, df2$`% Decrease in Uninsured (2010-2015)`, labels=df2$State)
# Nevada looks like the worst starting point, assuming higher uninsured is worse, and most improved
# also assuming that less insured is an improvement.


# I think this is a good stopping point for the question of which
# states saw the biggest decreases in uninsured rates.
# There are so many more columns and comparisons to make between coverage types, states,
# 2010 and 2015 that I hope to revisit this dataset. I've only covered a sliver of it.