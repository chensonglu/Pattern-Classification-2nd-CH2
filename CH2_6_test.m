u1 = [1 0]';
sigma1 = [1 0; 0 1];
u2 = [-1 0]';
sigma2 = [1 0; 0 1];
[error, Bbound, Cbound] = CH2_6(u1, sigma1, u2, sigma2, 0.5, 0.5);