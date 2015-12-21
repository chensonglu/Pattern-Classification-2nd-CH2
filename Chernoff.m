function Perror = Chernoff(u1, sigma1, u2, sigma2, P1)
% function Perror = Chernoff(u1, sigma1, u2, sigma2, P1)
% Find the Chernoff bound given means and covariances of single gaussian distributions.
% Inputs:
%   u1         - Mean of class1
%   sigma1     - Covariance matrix of class1
%   u2         - Mean of class2
%   sigma2     - Covariance matrix for class2
%   P1         - Prior probability of class1
%
% Outputs
%	Perror  	- Error bound

beta = linspace(0, 1, 100);
k = zeros(1, length(beta));

% calculate k(beta)
for i = 1:length(beta),
    k(i) = beta(i)*(1 - beta(i))/2*(u2 - u1)'*inv(beta(i)*sigma1 + (1 - beta(i))*sigma2)*(u2 - u1) + ...
              1/2*log(det(beta(i)*sigma1 + (1 - beta(i))*sigma2)/(det(sigma1)^beta(i)*det(sigma2)^(1 - beta(i))));
end
      
% find the minimum of exp(-k)
[m, index] = min(exp(-k));
min_beta = beta(index);

Perror = P1^min_beta*(1 - P1)^(1 - min_beta)*exp(-k(index));
% fprintf('min beta:%f\n', min_beta);
% plot(beta, exp(-k));