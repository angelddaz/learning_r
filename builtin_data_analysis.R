#DATA ANALYSIS

#Key:
  #lm = linear model, glm = generalized linear model, aov = analysis of variance
  #coef = coefficients, residuals = residuals (not helpful),
  #fitted = fitted values, confint = conf interval
  #t.test, TukeyHSD = Tukey's honest significant difference, predict = predicated values

#1: LINEAR MODELING
if(FALSE){
  lm1 <- lm(trees$Volume ~ trees$Height + trees$Girth)
  summary(lm1)
  plot(lm1)
  
  head(mtcars)
  lm2 <- lm(mpg ~ cyl + disp + hp + wt, data=mtcars) #This class does not deal with collinearity
  summary(lm2) #Cars with higher horse power may also have higher engine displacement
  plot(lm2)
}
  
#2: Analysis of Variance
if(FALSE){
  boxplot(Speed ~ Expt, data=morley)
  a <- aov(Speed ~ Expt, data=morley)
  summary(a)
  qqnorm(residuals(a))
  qqline(residuals(a))
  plot(fitted(a), residuals(a))
  abline(h=0) #median line
}

#3: The R coef Function
if(FALSE){
  head(trees)
  lv <- log(trees$Volume)
  lg <- log(trees$Girth)
  lmf <- lm(lv ~ lg + trees$Height)
  #summary(lmf)
  x <- coef(lmf)
  x #all coefficients
  #x[1] #intercept
  #x[-1] #all coefficients but the intercept
}

#4: The R fitted Function
if(FALSE){
  head(mtcars)
  lmf <- lm(mpg ~ disp, data=mtcars)
  fitted(lmf)
  plot(fitted(lmf), residuals(lmf))
  abline(h=0, col="red") #ideally, all the residuals would be close to zero for every i of fitted value
  #I surprisingly understand what happened in this section.
}

#5: The R residuals Function
if(FALSE){
  lmf <- lm(mtcars$mpg ~ mtcars$disp)
  residuals(lmf)
  summary(lmf)
  plot(fitted(lmf), residuals(lmf))
  abline(h=0, col="red")
  histogram(residuals(lmf), col="NA")
  qqnorm(residuals(lmf)) #a good model would be a straight line. Not the best model.
}

#6: The Variance-Covariance Matrix
if(FALSE){
  #trees built in dataset
  lmf <- lm(Volume ~ Girth + Height, data=trees)
  vcov(lmf) #The main diagonal represents the variances.
  #Upper triangle and lower triangle are the same, they are the covariance values.
}

#7: Confidence Intervals:
if(FALSE){
  ?faithful
  plot(faithful$eruptions, faithful$waiting)
  lme <- lm(eruptions ~ waiting, data=faithful)
  summary(lme)
  
  ci <- confint(lme, level=0.95)
  ci
  lower_est = ci[1] + ci[2]*50 #prediciting 50 mins
  upper_est = ci[3] + ci[4]*50
  print(lower_est)
  print(upper_est)
  #Predicting a wait time of 50 minutes, the eruption will last between 1.37 mins and 2.44 mins with a .95 conf
}

#8: Fitting Generalized Linear Models
if(FALSE){
  #predict number of cylinders based on mpg, disp, hp
  head(mtcars) #n=32 so small dataset
  m <- glm(cyl ~ disp + hp, data=mtcars, family=poisson)
  params <- data.frame(hp=110, disp=160) #Parameters are here
  predict(m, params, type="response")
}

#9: Plotting Linear Models
if(FALSE){
  library(ggplot2)
  head(faithful)
  plot(faithful$eruptions, faithful$waiting)
  qplot(eruptions, waiting, data=faithful, color=waiting, size=eruptions) #color and size based on x and y values
  qplot(eruptions, waiting, data=faithful, color=waiting, size=eruptions, 
        geom=c("point", "smooth"), method="lm") + coord_flip()#color and size based on x and y values
}

#10: T-Test
if(FALSE){
  r <- rnorm(100, 1000, 100)
  summary(r)
  tt <- t.test(r, mu=1000)
  str(tt)
  tt
  
  tt2 <- t.test(r, mu=1000, alternative="greater")
  tt2
}

#11: The TukeyHSD Test
if(FALSE){
  head(morley)
  table(morley$Expt)
  a <- aov(Speed ~ factor(Expt), data=morley)
  summary(a)
  TukeyHSD(a)
  plot(TukeyHSD(a))
}

#12: The predict Function
if(TRUE){
  head(faithful)
  plot(eruptions ~ waiting, data=faithful)
  lme <- lm(eruptions ~ waiting, data=faithful)
  dfe <- data.frame(waiting=50) #This is the parameter for the predict function.
  summary(lme)
  predict(lme, dfe, interval = "predict", level = 0.95)
}