data{
  int N1;
  int N2;
  int N3;
  vector[N1] y1;
  vector[N2] y2;
  vector[N3] y3;
}


parameters{
  real mu[3];
  real<lower = 0> sigma[3];
}

model{
  y1 ~ normal(mu[1], sigma[1]);
  y2 ~ normal(mu[2], sigma[2]);
  y3 ~ normal(mu[3], sigma[3]);
}


generated quantities{
  real y_pred[3];
  for (i in 1:3){
    y_pred[i] = normal_rng(mu[i], sigma[i]);
  }
}
