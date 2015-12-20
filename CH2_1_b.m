function g = CH2_1_b(x, u, sigma, P)
% g = CH2_1_b(x, u, sigma, P)
% Discriminant function of a Gaussian distribution and a prior probability
% Inputs:
%   x     - Input number
%   u     - Mean of a Gaussian distribution
%   sigma - Covariance matrix
%   P     - Prior probability
%
% Ouputs:
%  g      - Discriminant result 

g = -0.5*(x - u)'*inv(sigma)*(x - u) - size(u, 1)/2.0*log(2*pi) - 0.5*log(det(sigma)) + log(P);
end