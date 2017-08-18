# data from here: https://catalog.data.gov/dataset/college-scorecard
# data glossary and dictionary from here: https://collegescorecard.ed.gov/data/documentation/
df <- read.csv('Most-Recent-Cohorts-Scorecard-Elements.csv')
nrow(df)
ncol(df)
# 122 columns and 7703 rows. Much more data than I'm used to dealing with.
colnames(df)
# So I don't know what any of these mean.
glossary <- read.csv('educ_glossary.csv')
col_defs <- read.csv('educ_data_dict.csv')
# View(glossary)
# View(col_defs)
# It looks like I only want columns 1, 4, and 5 from col_defs
col_defs <- col_defs[,c(1,4,5)]
# View(col_defs)

col_defs <- subset(col_defs, !is.na(col_defs$VARIABLE.NAME))
# does nothing to my dataset
(col_defs[14,])
# an example row to look at. just blanks
as.character(col_defs[14,])
# empty strings. "". nothing in between.
# gsub("", NA, col_defs$VARIABLE.NAME) # well THAT didn't work haha
#View(col_defs)

is.na(col_defs)[14,]
as.character(col_defs[14,])

col_defs <- subset(col_defs, col_defs$VARIABLE.NAME != "")
# OK that worked! It took a few hours but it is nice to have it fixed.
nrow(col_defs)
# I am wondering why I have 1734 definitions for variable names and only
ncol(df)
# 122 columns in my dataset
# Time to look at which few columns I want to ask / hopefully answer questions about
colnames(df)
# The first colname got morphed along the way
colnames(df)[1] <- 'UNITID'
# What if I merged these colnames with the definitions in col_defs in a new dataframe?
library(sqldf)
?sqldf

cols <- colnames(df)
cols <- as.data.frame(cols) # 122 column names and I don't know what any of them mean
col_defs <- col_defs[,c(3,1,2)] # re-ordering the columns for arbitrary aesthetic purposes
colnames(col_defs)[1:3] <- c("name", "definition", "data_type") # easier names for SQL
colnames(cols)[1] <- "colname" # because the df has only one column, the [1] is unnecessary but clearer

col_defs <- sqldf("SELECT colname, definition, data_type
				  FROM cols LEFT JOIN col_defs
				  ON colname = name") # GOT IT. A left join to not exclude any of the dataset 122 cols
column_dictionary <- col_defs
rm(cols, col_defs) # cleaning up after myself.
# I am pretty happy with this now.
# Now it's really actually time to decide which columns I'm most curious about.

column_dictionary$definition[1:122] # wow A lot of interesting columns here

# My biggest struggles were in removing blank rows and then having definitions for my
# columns in an easy to read location. 1700+ rows of definitions and names was not preferred

# This is a good place to stop in terms of munging.
# FROM here, I would recommend to myself to "select" a few columns 
# and start looking at the numbers across all observations.