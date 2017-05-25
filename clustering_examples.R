#CLUSTERING

#1: Multidimensional Scaling
if(F){
    eurodist
    ?msr
    msr <- cmdscale(eurodist)
    plot(msr[,1],msr[,2])
    plot(msr[,1],msr[,2],type="n")
    text(msr[,1],msr[,2],rownames(msr))
    #the direction of the cities is wrong, so we flip the y coordinate.
    plot(msr[,1],-msr[,2],type="n")
    text(msr[,1],-msr[,2],rownames(msr))
}

#2: Hierarchical Clustering
if(F){
    head(mtcars)
    distmtcars <- dist(mtcars)
    hcmtcars <- hclust(distmtcars)
    plot(hcmtcars, hang=-1)
    nclusters <- 4 #arbitrary?
    clust <- cutree(hcmtcars, k=nclusters)
    df <- data.frame(cmdscale(distmtcars), factor(clust), size=nclusters)
    library(ggplot2)
    str(df)
    ggplot(df, aes(X1, X2)) + geom_point(aes(colour=factor.clust.)) #interesting
}

#3: Hierarchical Clustering with corclust
if(F){
    head(iris)
    #install.packages("klaR")
    library(klaR)
    corclust(iris[,-5],iris[,5], mincor=0.5,prnt=TRUE,method="complete") #default method
}

#4: K-Means Clustering
if(F){
    head(iris)
    r <- kmeans(iris[,1:4],3) #columns one through four and 3 species
    r$cluster
    plot(iris[,1], iris[,2], col=r$cluster) #Predicted
    plot(iris[,1], iris[,2], col=iris[,5])  #Actual. Pretty Close.
}

#5: Selecting K for kmeans clustering
if(F){
    head(iris)
    r <- kmeans(iris[,1:4],3) #what if we didn't know number of species?
    #install.packages("kselection")
    library(kselection)
    library(doParallel)
    registerDoParallel(cores=4)
    k <- kselection(iris[,-5], parallel=TRUE, k_threshold=0.9, max_centers=12)
    plot(iris[,3],iris[,4],col=r$cluster)
    plot(iris[,3],iris[,4],col=iris[,5])
    print(k$f_k)
}

#6: Clustering Large Applications (Clara)
if(F){
    library(cluster)
	xds <- rbind(cbind(rnorm(5000,0,8), rnorm(5000,0,8)), #two sets of n=5000, mu=0, sd=8
				 cbind(rnorm(5000, 50, 8), rnorm(5000, 50, 8))) #two sets of n=5000, mu=50, sd=8
	?cbind
	?rbind
	xcl <- clara(xds, 2, sample =100)
	clusplot(xcl)
	xpm <- pam(xds, 2) #pam method takes much longer
	clusplot(xpm)
	#There was a lot I didn't understand in this section
}

#7: Fuzzy C-Means Clustering
if(T){
	#install.packages("e1071")
	library(e1071)
	head(iris)
	xi <- cmeans(iris[,-5],3)
	plot(iris[,3],iris[,4],col=xi$cluster)
	plot(iris[,3],iris[,4],col=iris[,5])
	r <- (xi$cluster + 2) %% 3 + 2 #changing color scheme
	plot(iris[,3],iris[,4],col=r)
	
}
