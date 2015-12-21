function [error, Bbound, Cbound] = CH2_6(u1, sigma1, u2, sigma2, P1, P2)
% function error = CH2_6(u1, sigma1, u2, sigma2, P1, P2)
% Calculate the classification error of two classes.
% Inputs:
%   u1     - Mean of class1
%   sigma1 - Covariance matrix of class1
%   u2     - Mean of class2
%   sigma2 - Covariance matrix of class2
%   P1     - Prior probability of class1
%   P2     - Prior probability of class2
%
% Outputs:
%   error  - Classification error
%   Bbound - Bhattacharyya bound
%   Cbound - Chernoff bound

%% plot Gauss distribution
% Gauss distribution
[x1_1, x1_2] = meshgrid(linspace(-4, 6, 100)', linspace(-5, 5, 100)');
x1 = [x1_1(:) x1_2(:)];
p1 = P1*mvnpdf(x1, u1', sigma1);
surf(x1_1, x1_2, reshape(p1, 100, 100));
hold on;
[x2_1, x2_2] = meshgrid(linspace(-6,4,100)', linspace(-5,5,100)');
x2 = [x2_1(:) x2_2(:)];
p2 = P2*mvnpdf(x2, u2', sigma2);
surf(x2_1, x2_2, reshape(p2, 100, 100));
xlabel('x1'), ylabel('x2'), zlabel('p');
% Obviously, surf x1 = 0 is the Bayes decision boundary.

%% classification error, Bhattacharyya bound, Chernoff bound
figure;
Bbound = Bhattacharyya(u1, sigma1, u2, sigma2, P1);
Cbound = Chernoff(u1, sigma1, u2, sigma2, P1);
for n = 100:100:1000
    r1 = CH2_1_a(u1, sigma1, n/2);
    r2 = CH2_1_a(u2, sigma2, n/2);
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
    error(n/100) = (error1_2 + error2_1)/n;
end
plot(100:100:1000, Bbound*ones(1, 10), '-r*', ...
    100:100:1000, Cbound*ones(1, 10), '--bo', ...
    100:100:1000, error, '-.gs');
xlabel('n'), ylabel('error');
legend('Bhattacharyya bound', 'Chernoff bound', 'Classification error');
end







