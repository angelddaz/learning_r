browsers <- c("Chrome", "Internet\nExplorer", "Firefox", "Safari", "Opera", "Other")
share <- c(38, 19, 16.8, 16, 3.2, 6)
colors <- c("red", "yellow", "blue", "green", "orange", "cyan")
#pie(share, browsers, col=colors, radius = 0.95)

barplot(share, names.arg = browsers, col=colors, ylim=c(0,40))

if(FALSE){
  attach(morley)
  boxplot(Speed ~ Expt, morley, xlab="Experiment No.", ylab="Speed (km/s minus 299,000)")
  abline(h=792.458, col="red")
  text(3, 792.458, "true\nspeed")
}


colors <- c("red", "yellow", "blue", "green")

hist(airquality$Temp)
hist(airquality$Wind,
     freq=F,
     right=F,
     col=colors,
     breaks=16,
     main="New York Wind Speed",
     xlab="Wind Speed")

lines(density(airquality$Wind, bw=0.5),
      col="black",
      lwd=3)

v <- sample(1:100, 10)
plot(v, type="l", col="blue", ylim=c(0,100))
plot(v, type="o", col="blue", ylim=c(0,100))
x <- sample(1:100, 10)
lines(x, type="o", col="red")
title(main="Main Title", col.main="black")

x = airquality$Ozone
y = airquality$Wind
plot(x, y, xlab="Ozone (ppb)", ylab="Wind Speed (mph)")
abline(lm(y ~x))

library(ggplot2)
#exporting plots through the script rather than through GUI
sp <- ggplot(airquality, aes(x=airquality$Ozone, y=airquality$Wind))
sp + geom_point(shape=1) + geom_smooth(method=lm)

jpeg("AirPassengers.jpg")
plot(AirPassengers)
dev.off()

pdf("AirPassengers.pdf")
plot(AirPassengers)
dev.off()

win.metafile("AirPassengers.wmf")
plot(AirPassengers)
dev.off()

png("AirPassengers.png")
plot(AirPassengers)
dev.off()