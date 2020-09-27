// Bayes' rule

// p(θ|y) ∝ p(θ)p(y|θ)
// posterior ∝ prior * likelihood
// y 데이터
// θ 모수

data {
  int<lower=0> N; //관찰된 데이터수 
  vector[N] y; // 관찰된 데이터값
}

parameters {
  real mu; // 평균
  real<lower=0> sigma;  // 표준편차
}

model {
  y ~ normal(mu, sigma); // 가능도
  mu ~ normal(0, 100); // 사전분포
}

transformed parameters

generated quantities
