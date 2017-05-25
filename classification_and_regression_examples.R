#CLASSIFICATION AND REGRESSION

#1: Classification Trees with rpart in R
if(FALSE){
	library(rpart)
	?kyphosis #dataset from rpart.
	head(kyphosis)
	
	#Adding a new binary variable column for fun.
	df0 <- data.frame(kyphosis)
	df0$isPresent[df0$Kyphosis=="present"] <- 1
	df0$isPresent[df0$Kyphosis=="absent"] <- 0
	#Just for fun. Back to the class now.
	
	f <- rpart(Kyphosis ~ Age + Number + Start, data=kyphosis, method="class") #classification tree method
	plot(f) # ugly and uniformative
	plot(f, uniform=TRUE)
	par(mfrow=c(1,1),xpd=TRUE)
	text(f, use.n=TRUE, all=TRUE, cex=0.8)
}

#2: Regression Tree with rpart
if(F){
	library(rpart)
	?car90 #dataset from the rpart library
	?cu.summary #subset of the car90 dataset
	f <- rpart(Price ~ Mileage + Type + Country + Reliability, cu.summary, method="anova")
	par(xpd=TRUE)
	plot(f, uniform=T)
	text(f, use.n=T, all=T, cex=0.8)
}

#3: Classification Trees with the tree Package
if(F){
	#install.packages("tree")
	library(tree)
	?iris
	f <- tree(Species ~., iris)
	plot(f, type="uniform")
	text(f)
}

#4: Regression Trees with the tree Package
if(F){
	library(tree)
	?mtcars #1974 dataset from Motor Trend Magazine
	head(mtcars)
	f.a <- tree(mpg ~., mtcars)
	plot(f.a, type="uniform")
	text(f.a)
	
	#pruned tree
	f.b <- prune.tree(f.a, best=3)
	plot(f.b, type="uniform")
	text(f.b) #Only three levels.
}

#5: K-Nearest Neighbor Classification
if(F){
	library(class)
	?iris3 #3 sets of n=50 per species. 
	#We will use 25 each for training set and the other 25 for predicting
	print(head(iris3))
	train <- rbind(iris3[1:25,,1], iris3[1:25,,2], iris3[1:25,,3])
	test <- rbind(iris3[26:50,,1], iris3[26:50,,2], iris3[26:50,,3])
	
	cl <- factor(c(rep("s", 25), rep("c", 25), rep("v", 25)))
	r <- knn(train, test, cl, k=3, prob=TRUE)
	print(r)
	print(cl)
	sum(r==cl) #70 correct
	sum(r==cl) / length(cl) #correct 92% of them time
}

#6: The randomForest Package
if(F){
	#install.packages("randomForest")
	library(randomForest)
	?mtcars
	head(mtcars)
	set.seed(437123)
	rf <- randomForest(mpg ~ ., data=mtcars, ntree=1000, importance=TRUE) #1000 is a common number
	varImpPlot(rf, main = "Random Forest:\nThese variables contribute the most to MPG")
}

#7: Combining Random Forests
if(F){
	library(randomForest)
	head(iris)
	rf1 <- randomForest(Species ~., iris, ntree=100, proximity=TRUE, importance=TRUE)
	rf2 <- randomForest(Species ~., iris, ntree=100, proximity=TRUE, importance=TRUE)
	rf3 <- randomForest(Species ~., iris, ntree=100, proximity=TRUE, importance=TRUE)
	irf <- combine(rf1, rf2, rf3)
	MDSplot(irf, iris$Species)
	varImpPlot(irf) #most importance is placed on petal facts and not sepal facts
}

#8: Random Forests for Proximity Classification
if(F){
	library(randomForest)
	head(iris)
	irf <- randomForest(iris[,1:4], proximity=TRUE, type="unsupervised")
	MDSplot(irf, iris$Species)
	plot(iris[,3],iris[,4],col=iris[,5])
}

#9: Partitioning Around Medoids (PAM)
if(F){
	library(cluster)
	p <- pam(iris[,-5], 3)
	clusplot(p)
	ik <- kmeans(iris[-5], 3)
	plot(iris[,1], iris[,2], col=ik$cluster)
}

#10: Naive Bayes Classifier
if(F){
	library(MASS)
	library(klaR)
	inb <- NaiveBayes(Species ~ .,data=iris) 
	#A lot of abstraction of theoretical math here. 
	#Naive assumes each observation is independent if I remember correctly.
	plot(inb) #first one plots density of each column
	plot(iris[,3], iris[,4], col=iris[,5])
	
	#method 2:
	library(e1071)
	inb2 <- naiveBayes(Species ~., data=iris)
	table(predict(inb2, iris), iris[,5]) #94% accurate on versicolor and virginica.
}

#11: Linear Discriminant Analysis (LDA)
if(F){
	?iris
	library(MASS)
	ib <- lda(Species ~., data=iris)
	p <- predict(ib, iris)
	pc <- p$class
	summary(p$class) #pretty close
	plot(iris[,3],iris[,4],col=iris[,5]) #actual
	plot(iris[,3],iris[,4],col=pc) #tiny change 
}

#12: Quadratic Discriminant Analysis (QDA)
if(F){
	library(MASS)
	?iris
	r <- qda(Species ~., data=iris)
	p <- predict(r, iris)
	plot(iris[,3], iris[,4], col=factor(p$class))
	plot(iris[,3], iris[,4], col=iris$Species) #very close
	table(p$class, iris$Species)
}

#13: Mixture Discriminant Analysis
if(F){
	#install.packages("mda")
	library(mda)
	ix <- mda(Species ~., data=iris)
	ix$confusion
	plot(ix)
	p <- predict(ix, iris)
	print(summary(p))
	table(p, iris$Species) #close again
}

#14: Support Vector Machines (SVMs)
if(F){
	library(e1071)
	head(iris)
	m <- svm(Species ~., data=iris)
	plot(iris[,3],iris[,4],col=m$fitted)
	plot(iris[,3],iris[,4],col=iris$Species)
	table(m$fitted, iris$Species) #very close. again.
}

#15: Loess Regression
if(F){
	plot(mpg ~ wt, data=mtcars)
	lw1 <- loess(mpg ~ wt, data=mtcars)
	lines(mtcars$wt[order(mtcars$wt)], lw1$fitted[order(mtcars$wt)], col="blue", lwd=2)
}

#16: Partial Least Squares Regression (PLS)
if(F){
	#install.packages("pls")
	library(pls)
	head(mtcars) #careful of overfitting.
	r <- plsr(mpg ~., data=mtcars)
	summary(r)
	plot(r)
	p <- predict(r, mtcars)
	print(summary(p))
	summary(mtcars$mpg)
}

#17: Smoothing Splines
if(T){
	#install.packages("splines")
	library(splines)
	head(mtcars)
	attach(mtcars)
	plot(mpg ~ wt)
	f <- smooth.spline(mpg ~ wt, df=5) #why 5?
	lines(f, col="blue", lwd=2)
	f2 <- smooth.spline(mpg ~ wt, cv=T)
	lines(f2, col="red", lwd=3)
	print(f2)
}