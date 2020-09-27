data{
  int N; // number of trials
  int<lower=0, upper=1> y[N]; // observed data
}

parameters{
  real<lower=0, upper=1> p; // probability of ⋋
}


model{
  for (n in 1:N)
    y[n] ~ bernoulli(p); // likelihood
  // y ~ bernoulli(p);
  p ~ beta(1,1); // prior(uniform)
}

