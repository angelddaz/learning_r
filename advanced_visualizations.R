#ADVANCED VISUALIZATIONS

#1: Scatterplot Matrix in R
if(FALSE){
	library(caret)
	head(iris)
	featurePlot(iris[,-5], iris[,5], plot="pairs")
	#install.packages("AppliedPredictiveModeling")
	library(AppliedPredictiveModeling)
	transparentTheme(trans=0.5)
	featurePlot(iris[,-5], iris[,5], plot="pairs")
	#install.packages("ellipse")
	library(ellipse)
	featurePlot(iris[,-5], iris[,5], plot="ellipse")
}
	
#2: Overlay Density Plots
if(FALSE){
	library(caret)
	head(iris)
	featurePlot(iris[,-5],iris[,5], plot="density", adjust=1.5, 
				scales=list(x = list(relation="free"), y = list(relation="free")))
	library(AppliedPredictiveModeling)
	transparentTheme(trans = 0.8) #new color theme
	featurePlot(iris[,-5],iris[,5], plot="density", adjust=1.5, 
				scales=list(x = list(relation="free"), y = list(relation="free")))
}

#3: Scatterplot 3D Visualization in R
if(TRUE){
	?trees
	#install.packages("scatterplot3d")
	library(scatterplot3d)
	attach(trees)
	s <- scatterplot3d(Girth, Height, Volume, type="h") #there are three different types
	s <- scatterplot3d(Girth, Height, Volume, type="h", highlight.3d = TRUE, angle=110)
	f <- lm(Volume ~ Girth + Height)
	print(f)
	s$plane3d(f) #NICE.
}