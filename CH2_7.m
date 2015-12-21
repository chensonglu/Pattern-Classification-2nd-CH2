function [Aerror, Eerror, Bbound, Cerror] = CH2_7(u1, sigma1, u2, sigma2, P1, P2)
% function [Aerror, Eerror, Bbound, Cerror] = CH2_7(u1, sigma1, u2, sigma2, P1, P2)
% Calculate the Bhattacharyya bound, actual error, estimated error and a
% series of classification error of two Gauss distribution.
% Inputs:
%   u1     - Mean of class1
%   sigma1 - Covariance matrix of class1
%   u2     - Mean of class2
%   sigma2 - Covariance matrix of class2
%   P1     - Prior probability of class1
%   P2     - Prior probability of class2
%
% Outputs:
%   Aerror - Actual error 
%   Eerror - Estimated error
%   Bbound - Bhattacharyya bound
%   Cerror - Classification error

%% plot Gauss distribution
% Gauss distribution
x = (-5:0.1:5)';
y1 = gaussmf(x, [sigma1 u1]);
y2 = gaussmf(x, [sigma2 u2]);
plot(x, [y1 y2]);
% boundary line
l = zeros(11,1);
y3 = 0:0.1:1;
hold on;
plot(l, y3, '--r');
xlabel('x'), ylabel('y');
legend('N(-0.5, 1)', 'N(0.5, 1)', 'boundary line');

%% Bhattacharyya bound
Bbound = Bhattacharyya(u1, sigma1, u2, sigma2, P1);

%% actual error using error function
Aerror = (1 - erf(sqrt(2)/4))/2;

%% estimated error using numerical integration
% the intersection area of two Gauss distribution means error
syms x;
Eerror = (1- double(int(1/sqrt(2*pi*sigma1)*exp(-x^2/(2*sigma1)), -0.5, 0.5)))/2;

%% classification error
m = 1;
vec = [10 50 100 200 500 1000];
for n = vec
    r1 = CH2_1_a(u1, sigma1, n);
    r2 = CH2_1_a(u2, sigma2, n);
    % error1_2: number of class1 misclassified to class2
    % error2_1: number of class2 misclassified to class1
    error1_2 = 0;
    error2_1 = 0;
    for i = 1:size(r1, 1)
        % class1 misclassified to class2
        if(CH2_1_b(r1(i, :)', u1, sigma1, P1) < CH2_1_b(r1(i, :)', u2, sigma2, P2))
            error1_2 = error1_2 + 1;
        end
        % class2 misclassified to class1
        if(CH2_1_b(r2(i, :)', u2, sigma2, P2) < CH2_1_b(r2(i, :)', u1, sigma1, P1))
            error2_1 = error2_1 + 1;
        end
    end
    Cerror(m) = (error1_2 + error2_1)/(2*n);
    m = m + 1;
end
figure;
plot(2*vec, Aerror*ones(1, size(vec, 2)), '-rs', 2*vec, Eerror*ones(1, size(vec, 2)), '--gv', ...
    2*vec, Bbound*ones(1, size(vec, 2)), '-.b*', 2*vec, Cerror, '-kd');
xlabel('n'), ylabel('error');
legend('Actual error', 'Estimated error', 'Bhattacharyya bound', 'Classification error');
end




