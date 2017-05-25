#BOOSTING AND BAGGING

#1: AdaBoost in R
if(F){
	#install.packages("adabag")
	#install.packages("stringi")
	library(adabag)
	library(caret)
	
	?iris
	ia <- boosting(Species ~., data=iris, mfinal=10, control=rpart.control(maxdepth=1))
	str(ia$class)
	plot(iris[,3],iris[,4],col=factor(ia$class))
	plot(iris[,3],iris[,4],col=iris$Species)
	table(ia$class, iris$Species)
}

#2: Bagging
if(T){
	library(adabag)
	head(iris)
	#ib <- bagging.cv(Species ~., data=iris, mfinal=10) #default is 100 mfinal computations
	ib$confusion
	plot(iris[,3], iris[,4], col=factor(ib$class))
	print(sum(ib$class==iris$Species) / length(iris$Species)) #94% accuracy
	table(ib$class, iris$Species)
}