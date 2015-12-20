function Perror = Bhattacharyya(u1, sigma1, u2, sigma2, P1)
% function Perror = Bhattacharyya(mu1, sigma1, mu2, sigma2, p1)
% Find the Bhattacharyya bound given means and covariances of single
% gaussian distributions.
% Inputs:
%   u1         - Mean of class1
%   sigma1     - Covariance matrix of class1
%   u2         - Mean of class2
%   sigma2     - Covariance matrix of class2
%   P1         - Probability of class1
%
% Outputs
%	Perror  	- Error bound

k_half = 1/8*(u2 - u1)'*inv((sigma1 + sigma2)/2)*(u2 - u1) + 1/2*log(det((sigma1+sigma2)/2)/sqrt(det(sigma1)*det(sigma2)));
Perror = sqrt(P1*(1 - P1))*exp(-k_half);

