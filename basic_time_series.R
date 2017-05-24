#TIME SERIES
#1: Time Series
if(FALSE){
  tsdata <- ts(sample(1:100, 24), start=c(2013,1), end=c(2014, 12), frequency=12, deltat=1/12) #12 datapoints per year
  plot(tsdata)
}

#2: The R forecast package
if(TRUE){
  str(AirPassengers)
  f <- stl(AirPassengers, s.window="period")
  plot(f)
  #install.packages("forecast")
  library(forecast)
  f <- ets(AirPassengers)
  plot(forecast(f,12))
  f <- auto.arima(AirPassengers)
  plot(forecast(f,12)) # A lot was abstracted in this lesson.
  #Probably true in previous lessons as well but I don't know time-series very well so
  #It felt more true in this one.
}