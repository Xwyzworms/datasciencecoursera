set.seed(1)
rpois(5,2)
str(rpois)

set.seed(10)
x <- rep(0:1 , each = 5)
e <- rnorm(10 , mean = 0 ,sd = 20)
y <- 0.5 + 2 * x + e
plot(x,y)

library(datasets)
Rprof()
fit <- lm(y ~ x1 +x2)
Rprof(NULL)