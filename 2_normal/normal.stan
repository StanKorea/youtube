data{
  int N; // # obs. 
  real y[N]; // speed data
}

parameters{
  real mu;
  real<lower = 0> sigma;
}

model{
  y ~ normal(mu, sigma); // likelihood
}

generated quantities{
  real y_pred;
  y_pred = normal_rng(mu, sigma);
}
