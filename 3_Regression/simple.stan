data{
  int N; // obs. number
  vector[N] y;// y variable (Score)
  vector[N] x;// x variable (GDP)
  int M; // prediction
  vector[M] xreg; // prediction
}

parameters{
  real alpha;
  real beta;
  real<lower = 0> sigma;
}

model{
  y ~ normal(alpha + x*beta, sigma);
}

generated quantities{
  vector[M] ypred;
  for(m in 1:M){
    ypred[m] = normal_rng(alpha + xreg[m]*beta, sigma);
    }
}
