# Today I try to access data with an API. I'm still no totally clear what this is.


# "API is short for Application Programming Interface. 
# Basically, it means a way of accessing the functionality of a program from inside another program. 
# So instead of performing an action using an interface that was made for humans, 
# a point and click GUI for instance, an API allows a program to perform that action automatically."

# install.packages(c("httr", "jsonlite", "lubridate")) # I have definitely done this in online classes
# but never (semi) alone like this
library(httr)
library(jsonlite)
library(lubridate)

username <- 'angelddaz'
url_git <- 'https://api.github.com/'

repos <- GET(url = paste0(url_git,'users/',username,'/repos'))
names(repos)