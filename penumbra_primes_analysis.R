#READ ME from dataset source: https://github.com/robinsloan/penumbra-primes

# This repository contains the results of an odd prime number game.
# Here's how it works:
# As a player, you are invited to supply a prime number of your choosing. Then, if I'm crowning N winners, 
# I review the entries and identify the N lowest unique primes.
# So, if you pick 2 but seven other people pick 2: sorry. 
# If you pick 3 and no one else picks 3: you win! If you pick 4... don't pick 4. It's not prime!
# I love this game because there's a bit of math, a bit of psychology -- maybe even game theory -- 
# and then a large preponderance of luck.
# The included CSV file is organized like this: prime,count
# This weird dataset is offered to the world under a CC0 license.


url<-'https://raw.githubusercontent.com/robinsloan/penumbra-primes/master/prime-counts-may2017.csv'
library(readr)
# First step is probably looking at the head
df <- as_data_frame(read.delim(url, sep=',')) 
# the 'sep' param used to be 'delim' ?
# it took a minute to figure that out. it's important to read error messages calmly and slowly
head(df)
# The column names are vague. Time to change that
colnames(df) <- c("prime_number", "guesses_count")
head(df)
# nice.

# now it's time to visualize the data
plot(df$prime_number, df$guesses_count)
# holy outliers.

# I want to handle these outliers with some mathematical justification
# Not sure how.

# I can look at my environment GUI to see how many observations I have 
# or I can google how to find out the number of rows
nrow(df)

# 281 rows and it looks like around 125ish of them are quite large, single count for each.
tail(df, n = 125)
281-125

# choosing 281 - 125 = 156 is arbitrary and I don't like it but I trudge on for now.
df2 <- head(df, n = 156) # no idea if this is kosher. it worked?
boxplot(df2$prime_number) 
# that looks like something but I still don't like the arbitrary nature of it.
# let's forget this version of df2.

# maybe cutting off at the median will make it only slightly less arbitrary. maybe not.
median(df$prime_number)

# splitting the current df into df2 and df3
df2 <- subset(df, df$prime_number < median(df$prime_number))
df3 <- subset(df, df$prime_number >= median(df$prime_number))
head(df2)
head(df3)

boxplot(df2$prime_number)
boxplot(df3$prime_number) # this second boxplot is still largely skewed by large numbers.
# I wonder if this would be consistent if I looked at the top two quartiles of the original df


# Just out of curiosity I'm taking thsi aside.
nrow(df3) # with an add number of rows, 141, I have to be careful not to leave one obs out

mean(df3$prime_number)
median(df3$prime_number)
# our mean is much larger than the median. The data is right skewed.

df_3quartile <- subset(df3, df3$prime_number < median(df3$prime_number))
df_4quartile <- subset(df3, df3$prime_number >= median(df3$prime_number))

boxplot(df_3quartile$prime_number)
boxplot(df_4quartile$prime_number)
# The same visual pattern is repeated for these two boxplot as the previous two halves
# The first half is a "normal" looking boxplot and the second half is right skewed

# Maybe I should do quantile regression here. Either way, we are not there yet.

# I'm going to go back to the first two quartiles dataset named df2
plot(df2$prime_number, df2$guesses_count)
# that looks cool!
# now I'm really curious how the third quartile looks
plot(df_3quartile$prime_number, df_3quartile$guesses_count)
# very interesting as well but not as cool looking, polynomial regression suggesting, df2

# Now that I have a decent sense of how this data is "shaped"
# The most obvious question is, "Which number won lowest prime number guessed with guesses_count = 1 ?"
# Having most of my experience in SQL, it would be something like
# SELECT MIN(df$prime_number)
# FROM df
# HAVING df$guesses_count = 1

min_df <- subset(df, df$guesses_count==1) # HAVING clause
winner <- min_df[1,] # SELECTING the MIN
print(winner)

# The lowest prime number to be chosen uniquely is 409

# Time for some more advanced visualizations on the first half of the data, df2
colors <- c("red", "yellow", "blue", "green", "gray", "black")

hist(df2$prime_number)
hist(df2$guesses_count,
	 freq=F,
	 right=F,
	 col=colors,
	 main="Title",
	 xlab="xlab",
	 ylim=c(0,.15))
lines(density(df2$guesses_count, bw=0.5),
	  col="black",
	  lwd=3)
# This histogram provides shows a starker disparity in distrubition than even df2 scatter plot

# Would this many people have guessed low prime numbers if they knew how many participants there were?
# Did they have any idea of how many participants there were?

# I should have made x and y variables earlier but it's fine.
x = df2$prime_number
y = df2$guesses_count

plot(x, y, xlab="Prime Number", ylab="Count of Guesses")
summary(lm(y ~ x))
# a linear model may not provide the best fit here.
# the t scores and p values look good but our R^2 is 0.5172

library(ggplot2)
sp <- ggplot(df2, aes(x = df2$prime_number, y = df2$guesses_count))
sp + geom_point(shape=1) + geom_smooth(method=lm)
#prettier

# I am going to try to fit a polynomial regression curve on this df2

#model <- lm(y ~ x + I(x^2))
#summary(model) # looks good so far. p values are all very close to zero.
#confint(model, level=0.95) # no coefficient confidence interval includes zero at a 95% confidence level
plot(fitted(model), residuals(model)) 
# residuals increase as x gets bigger meaning our model becomes less accurate as prime number increases

plot(x, y)
#predicted.intervals <- predict(model, data.frame(x=x), interval='confidence', level=0.95)
# lines(sort(y), fitted(model)[order(x)], col='green', type='b')
# a bunch of this stuff isn't working. I'm going to try ggplot2

# fit <- lm(guesses_count ~ prime_number + I(prime_number^2), data = df2)
# prd <- data.frame(prime_number = seq(from = range(df2$prime_number)[1], 
# 						  to = range(df2$prime_number)[2], length.out = 100))
#err <- predict(fit, newdata = prd, se.fit = TRUE)

#this isn't working. lots of mistakes and it's hard to debug when I don't know this
#syntax very well.

#prd$lci <- err$fit - 1.96 * err$se.fit
#prd$fit <- err$fit
#prd$uci <- err$fit + 1.96 * err$se.fit

# ggplot(prd, aes(x = prime_number, y = fit)) +
# 	theme_bw() +
# 	geom_line() +
# 	geom_smooth(aes(ymin = lci, ymax = uci), stat = "identity") +
# 	geom_point(data = df2, aes(x = prime_number, y = guesses_count))

# gah nothing is working here. the struggle. Normally I would delete but this is good to leave up.

# attempt number three
fit <- lm(df2$guesses_count ~ df2$prime_number + I(df2$prime_number^2))
newdat = data.frame(x = seq(min(df2$prime_number), max(df2$prime_number), length.out = 140))
newdat$pred = predict(fit, newdata = newdat)

plot(guesses_count ~ prime_number, data = df2)
with(newdat, lines(x = df2$prime_number, y = pred))

# that worked!
summary(fit)
# R^2 goes up to 0.7159 and the rest of the statistics look good to me.
# Given, I had to cut the dataset in half because of the extreme right skewness
# but it was a good exercise nonetheless.
# To be critical of this polynomial model, the uptick at the end is not predictive
# given what we know about how sparse and spread out the data becomes as we move into the 3rd
# and 4th quartile of prime_number. The increasing absolute value of residuals is more evidence
# of this flaw in the model.

# I think this is a good place to stop. It got ugly figuring out polynomial regression syntax in R
# but I got through it and this was a fun dataset to mess with.