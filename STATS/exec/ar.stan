data {
  int<lower=0> N;
  real y[N];
  int<lower=1> P;
}
parameters {
  real<lower=0> sigma;  // outcome noise
  real phi[P];
}
transformed parameters {
  real pred[N];
  for(i in 1:P) {
    pred[i] = 0;
  }
  for(i in (P+1):N) {
    pred[i] = 0;
    for(j in 1:P) {
      pred[i] = pred[i] + phi[j]*y[i-j];
    }
  }
}
model {
  y[P:N] ~ normal(pred[P:N], sigma);
  sigma ~ cauchy(0, 5);
  phi ~ normal(0,1);
}
