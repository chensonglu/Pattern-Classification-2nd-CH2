function E_dist = CH2_1_c(x1, x2)
% function E_dist = CH2_1_c( x1, x2 )
% Calculate the Euclidean distance between two vectors.
% Inputs:
%   x1     - Vector x1
%   x2     - Vector x2
%
% Outputs:
%   E_dist - Euclidean distance

E_dist = sqrt(sum((x1 - x2).^2));
end

