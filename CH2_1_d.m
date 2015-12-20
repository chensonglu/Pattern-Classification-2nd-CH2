function M_dis = CH2_1_d(x, u, sigma)
% function M_dis = CH2_1_d(x, u, sigma)
% Calculate the Mahalanobis distance of a vector.
% Inputs:
%   x      - Input Vector
%   u      - Mean of distribution
%   sigma  - Covariance matrix of distribution
%
% Outputs:
%   M_dis  - Mahalanobis distance

M_dis = sqrt((x - u)'*inv(sigma)*(x - u));
end

