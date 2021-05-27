#### Linear Regression ####

## I. Simple Linear Regression
## II. Multiple Linear Regression

setwd("~/stan/youtube/3_Regression")

## Load data
dat = read.csv("worldbank.csv")
# 나라, 행복지수, GDP, 사회적 지지, 건강기대수명, 자유, 관용
head(dat) 

library(GGally)
GGally::ggpairs(dat[,-1])

dat[order(dat$Score, decreasing = TRUE),]

#### I. Simple Linear Regression ####

### In R

## Score ~ GDP
plot(dat$GDP, dat$Score)
korea <- dat[dat$Country=="South Korea",]; korea
points(korea$GDP, korea$Score, col = 2, pch = 16)

# fitting
fit1 <- lm(Score ~ GDP, dat)
summary(fit1)

plot(dat$GDP, dat$Score)
abline(fit1, col =4)

## predict 함수를 통한 예측
predict(fit1, data.frame(GDP = 10.6), interval = "confidence")

####Doing it with Stan!#####
library(rstan)

# Score ~ GDP
# Score(y) ~ N(a + GDP(x)*b, sigma^2)

## write stan file

## fitting
range(dat$GDP)
xreg = seq(7, 12, by = 0.2)
M = 26

data1 = list(N = nrow(dat), y = dat$Score, x = dat$GDP, xreg = xreg, M = M)
stanfit1 <- stan(file = "simple.stan", data = data1)

## result
stanfit1

fit1
sd(resid(fit1))

## extract MCMC samples
res1 <- extract(stanfit1)
res1

## estimated coefficients
alpha <- median(res1$alpha)
beta <- median(res1$beta)
sigma <- median(res1$sigma)
fit1

## predicted distribution
ypred <- res1$ypred

dim(ypred)
head(ypred)

ci <- apply(ypred, 2, function(x) quantile(x, probs = c(0.25, 0.5, 0.75)))

## fitted value plotting
plot(dat$GDP, dat$Score, xlim = c(7, 12), pch =18)
abline(a = alpha, b = beta, col = 3)
points(xreg, ci[2,], col = 4, type = 'b', pch = 16)
lines(xreg, ci[1,], lwd = 2, col = 4, lty = 3)
lines(xreg,ci[3,], lwd = 2, col = 4, lty = 3)


library(bayesplot)
mcmc_areas(stanfit1, regex_pars = "ypred",
           prob = 0.5, prob_outer = 0.9, invert = TRUE)

mcmc_hist(stanfit1, pars = c("alpha", "beta"))
mcmc_dens_overlay(stanfit1, pars = c("alpha", "beta"))


#### II. Multiple Linear Regression ####

## Stan
data2 = list(N = nrow(dat), y = dat$Score, x = dat[,3:7])
stanfit2 <- stan(file = "multiple.stan", data = data2)

plot(stanfit2)
stanfit2

## R
fit2 <- lm(Score ~., dat[,-1])
summary(fit2)

