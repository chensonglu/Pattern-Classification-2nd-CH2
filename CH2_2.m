function [model, error, Bbound] = CH2_2(patterns, targets, c1, c2, P1, P2, dim)
% function [model, error, Bbound] = CH2_2(patterns, targets, c1, c2, P1, P2, dim)
% Generate classification model of two classes, then calculate the classification
% error and the Bhattacharyya bound.
% Inputs:
%   patterns - Input matrix
%   targets  - Input matrix classes
%   c1       - Class1
%   c2       - Class2
%   P1       - Prior probability of c1
%   P2       - Prior probability of c2
%   dim      - Dimensions of input vector
%
% Outputs:
%   model    - Classification model
%   error    - Classification error
%   Bbound   - Bhattacharyya bound

%% Generate classification model
% matrices of two classes
x1 = patterns(1:dim, targets == c1);
x2 = patterns(1:dim, targets == c2);
% mean of two matrices
u1 = mean(x1, 2);
u2 = mean(x2, 2);
% covariance matrix of two matrices
sigma1 = cov(x1');
sigma2 = cov(x2');
% generate model
model.u1 = u1;
model.u2 = u2;
model.sigma1 = sigma1;
model.sigma2 = sigma2;
model.P1 = P1;
model.P2 = P2;

%% Calculate the classification error
col1 = size(x1, 2);
col2 = size(x2, 2);
result1 = zeros(col1, 1);
result2 = zeros(col2, 1);
% classification result
for i = 1:col1
    if CH2_1_b(x1(:, i), model.u1, model.sigma1, model.P1) >=  CH2_1_b(x1(:, i), model.u2, model.sigma2, model.P2)
        result1(i) = c1;
    else
        result1(i) = c2;
    end
end
for i = 1:col2
    if CH2_1_b(x2(:, i), model.u2, model.sigma2, model.P2) >=  CH2_1_b(x2(:, i), model.u1, model.sigma1, model.P1)
        result2(i) = c2;
    else
        result2(i) = c1;
    end
end
% classification error
error_num = size(find(result1 == c2), 1) + size(find(result2 == c1), 1);
error = error_num/(col1 + col2);

%% Bhattacharyya bound
Bbound = Bhattacharyya(u1, sigma1, u2, sigma2, P1);

