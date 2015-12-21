function [Eerror, Bbound, Cerror] = CH2_7(u1, sigma1, u2, sigma2, P1, P2)
% function [Eerror, Bbound, Cerror] = CH2_7(u1, sigma1, u2, sigma2, P1, P2)
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
%   Eerror - Estimated error
%   Bbound - Bhattacharyya bound
%   Cerror - Classification error

%% calculate the curve intersection point
eq1 = ['y = ' num2str(P1) '*1/sqrt(2*pi*' num2str(sigma1) ')*exp(-(x - '  num2str(u1) ')^2/(2*' num2str(sigma1) '))'];
eq2 = ['y = ' num2str(P2) '*1/sqrt(2*pi*' num2str(sigma2) ')*exp(-(x - '  num2str(u2) ')^2/(2*' num2str(sigma2) '))'];
[inter_x, inter_y] = solve(eq1, eq2);
inter_x = double(inter_x);
inter_y = double(inter_y);

%% plot Gauss distribution
% Gauss distribution
x = (-5:0.1:5)';
y1 = P1*1/sqrt(2*pi*sigma1)*exp(-(x - u1).^2/(2*sigma1));
y2 = P2*1/sqrt(2*pi*sigma2)*exp(-(x - u2).^2/(2*sigma2));
plot(x, [y1 y2]);
hold on;
plot(inter_x, inter_y, 'rx', 'LineWidth', 2, 'MarkerSize', 10);
for i = 1:size(inter_x, 1)
    text(inter_x(i) + 0.2, inter_y(i), ['\leftarrow (' num2str(inter_x(i)) ', ' ...
        num2str(inter_y(i)) ')']);
end
xlabel('x'), ylabel('y');
legend('N(-0.5, 1)', 'N(0.5, 1)', 'intersection point');

%% Bhattacharyya bound
Bbound = Bhattacharyya(u1, sigma1, u2, sigma2, P1);

%% estimated error using numerical integration
% the intersection area of two Gauss distribution means error
syms x;
if size(inter_x, 1) == 1
    Eerror = double(int(P1*1/sqrt(2*pi*sigma1)*exp(-(x - u1)^2/(2*sigma1)), inter_x, Inf)) + ...
        double(int(P2*1/sqrt(2*pi*sigma2)*exp(-(x - u2)^2/(2*sigma2)), -Inf, inter_x));
else if size(inter_x, 1) == 2
    Eerror = double(int(P1*1/sqrt(2*pi*sigma1)*exp(-(x - u1)^2/(2*sigma1)), inter_x(1), inter_x(2))) + ...
        double(int(P2*1/sqrt(2*pi*sigma2)*exp(-(x - u2)^2/(2*sigma2)), -Inf, inter_x(1))) + ...
        double(int(P2*1/sqrt(2*pi*sigma2)*exp(-(x - u2)^2/(2*sigma2)), inter_x(2), Inf));  
    end
end

%% classification error
m = 1;
vec = [10 50 100 200 500 1000];
for n = vec
    r1 = CH2_1_a(u1, sigma1, round(P1*2*n));
    r2 = CH2_1_a(u2, sigma2, 2*n - round(P1*2*n));
    % error1_2: number of class1 misclassified to class2
    % error2_1: number of class2 misclassified to class1
    error1_2 = 0;
    error2_1 = 0;
    for i = 1:size(r1, 1)
        % class1 misclassified to class2
        if(CH2_1_b(r1(i, :)', u1, sigma1, P1) < CH2_1_b(r1(i, :)', u2, sigma2, P2))
            error1_2 = error1_2 + 1;
        end
    end
    for j = 1:size(r2, 1)
       % class2 misclassified to class1
        if(CH2_1_b(r2(j, :)', u2, sigma2, P2) < CH2_1_b(r2(j, :)', u1, sigma1, P1))
            error2_1 = error2_1 + 1;
        end 
    end
    Cerror(m) = (error1_2 + error2_1)/(2*n);
    m = m + 1;
end
figure;
plot(2*vec, Eerror*ones(1, size(vec, 2)), '--gv', ...
    2*vec, Bbound*ones(1, size(vec, 2)), '-.b*', 2*vec, Cerror, '-kd');
xlabel('n'), ylabel('error');
legend('Estimated error', 'Bhattacharyya bound', 'Classification error');
end




