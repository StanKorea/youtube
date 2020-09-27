###### 1. Bernoulli Trial - estimation of p ######
setwd("./STAN/video/1_bernoulli")
library(rstan)

# 0: ㅗ
# 1: ⋋
N <- 10 # 시행횟수 N
y <- c(1,1,0,0,1,0,1,1,1,1) # 관측데이터 y
data <- list(N=N, y=y)
fit1 <- stan(file='1.stan', data=data, seed = 123)
fit1

## MCMC warmup 보충
traceplot(fit1, inc_warmup = TRUE)
traceplot(fit1)

plot(fit1)
plot(fit1, show_density = TRUE)

### Now, we have 100 observations
N <- 100
y <- c(rep(0,30), rep(1,70))
# fit2 <- stan(file='1.stan', data=c("N", "y"), seed = 123)
model <- stan_model('1.stan')
fit2 <- sampling(model, data=c("N", "y"), seed=123)


plot(fit2, show_density = TRUE, ci_level = 0.8, fill_color = "pink")


### 베이즈 추정량

## extract() to get MCMC samples
res1 <- extract(fit1)
res2 <- extract(fit2)

## posterior mean (사후분포의 평균)
mean(res1$p)
mean(res2$p)

## 최대사후분포추정량(MAP, Maximum a Posteriori)
fit_pmode_prob <- optimizing(model,data=data1, seed=1234) # 0.7 # which is sample mean # MLE

## 사후분포의 중간값(Posterior median)
summary(fit1, prob=0.5)

## 베이지안 신뢰구간(Credible Set), 신용구간(Credible interval)
summary(fit1, prob = c(0.025, 0.975))

### Plotting

## mcmc histogram
par(mfrow=c(2,1))
hist(res1$p, xlim = c(0,1))
hist(res2$p, xlim = c(0,1))

## using bayesplot package
install.packages("bayesplot")
library(bayesplot)

## mcmc_areas: estimated posterior density curves
mcmc_areas(fit1,
           pars="p",
           prob = 0.8, # 80% intervals,
           #prob_outer = 0.99, # 99%
           point_est = "mean")
mcmc_hist(fit1)
mcmc_trace(fit1, facet_args = list(nrow = 2))


## posterior mode
#p_map=res1$p[which(res1$lp__==max(res1$lp__))]


### Bayes' Rule
 
# π(θ|y) ∝ π(θ)p(y|θ)
# posterior ∝ prior * likelihood
# θ 모수 
# y 데이터

### density graph
# prior: θ ~ beta(1,1) 
t1=seq(0,1, by=0.1)
ft1=dbeta(t1, 1,1)
plot(t1, ft1, type = "l", lwd=2, ylim = c(0,9))

## posterior: θ|y ~ Beta(8,4)
x1 <- seq(0,1, by=0.01)
fx1 <- dbeta(x1,8,4)
lines(x1, fx1, type="l", col=2, lwd=2)

## posterior: θ|y ~ Beta(71,31)
par(mfrow=c(1,1))
x2 <- seq(0,1, by=0.01)
fx2 <- dbeta(x2,71,31)
lines(x2, fx2, type= "l", col=3, xlab="p", ylab="density", lwd=2)
legend(x=0, y=8, 
       legend = c("prior: unif(0,1)", "posterior: beta(8,4)", "posterior: beta(71,31)"),
       pch = 15, col = c(1,2,3), cex = 1.3)

