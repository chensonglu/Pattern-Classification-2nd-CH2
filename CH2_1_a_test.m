% generate a normal distribution
u1 = [0, 0];
sigma1 = [2 0; 0 2];
r1 = CH2_1_a(u1, sigma1, 500);
plot(r1(:, 1), r1(:, 2), 'r+');
hold on;

% generate another normal distribution
u2 = [5, 5];
sigma2 = [.5 0; 0 2];
r2 = CH2_1_a(u2, sigma2, 500);
plot(r2(:, 1), r2(:, 2), '*');