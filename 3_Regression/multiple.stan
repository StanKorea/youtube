data{
  int N; // obs. number
  vector[N] y; // y variable (Score)
  matrix[N,5] x; // x variable (mulitple)
}

parameters{
  real alpha;
  vector[5] beta;
  real<lower = 0> sigma;
}

model{
  y ~ normal(alpha + x*beta, sigma);
}
