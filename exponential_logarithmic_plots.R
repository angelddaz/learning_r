par(mfrow=c(2, 1), mai = c(0.1, 0.1, 0.1, 0.1))
h <- function(x) exp(x)
x <- c(1:0.5:11)
plot(x, h(x), type='o', ylab='', xlab='', main='', xaxt='n', yaxt='n')

x <- c(1:100)
h <- function(x) log(x)
plot(x, h(x), type='o', ylab='', xlab='', main='', xaxt='n', yaxt='n')
