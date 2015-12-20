function r = CH2_1_a(u, sigma, n)
% function r = CH2_1_a(u, sigma, n)
% Generate random vectors from the multivariate normal distribution.
% Inputs:
%   u     - Mean of distribution
%   sigma - Covariance matrix of distribution
%   n     - Number of vectors
%
% Outputs:
%   r     - Matrix of random vectors

r = mvnrnd(u, sigma, n);
end