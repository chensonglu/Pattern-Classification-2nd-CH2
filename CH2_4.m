function [M_dist, class] = CH2_4(x, patterns, targets, P)
% function [M_dist, class] = CH2_4(x, patterns, targets, P1, P2, P3)
% Calculate the Mahalanobis distance with three classes, then classify the
% vectors.
% Inputs:
%   x         - Input vector
%   patterns  - Input matrix
%   targets   - Input matrix classes
%   P         - Prior probability of class 1,2,3
% 
% Outputs:
%   M_dist    - Mahalanobis distance
%   class     - classification result

%% Mahalanobis distance
m = size(patterns, 1);
for i = 1:m
   p = patterns(:, targets == i);
   u{i} = mean(p, 2);
   sigma{i} = cov(p');
end
for i = 1:m
    M_dist(i) = CH2_1_d(x, u{i}, sigma{i});
end

%% classification
class = 0; max_g = -Inf;
for i = 1:m
    g = CH2_1_b(x, u{i}, sigma{i}, P(i));
    if g > max_g
        class = i;
        max_g = g;
    end
end

end