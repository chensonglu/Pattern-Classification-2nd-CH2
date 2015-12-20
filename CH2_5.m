% The script is to prove that the average of a large number of
% independent random variables follows Gauss distribution.

% 10^4, 10^5, 10^6 samples
% 1. randomly pick xl and xu, -100 <= xl < xu <= 100
% 2. randomly pick n, 0 <= n <= 1000
% 3. randomly pick n numbers from [xl xu]
% 4. calculate the average of the n numbers
for i = 4:6
    h = zeros(1, 0);
    y = zeros(1, 0);
    while size(h, 2) < 10^i
       x = randi([-100 100], 1, 2);
       if min(x) == max(x)
           continue;
       end
       xl = min(x);
       xu = max(x);
       n = randi([0 1000], 1, 1);
       v = randi([xl xu], 1, n);
       y = [y mean(v)];
       h = [h y];
    end
    % hist
    subplot(2, 2, i - 3);
    hist(y, 50);
    xlabel('x'), ylabel('num of x');
    title(['10^',num2str(i),' samples']);
    fprintf('10^%d samples:\n', i);
    fprintf('mean:%f  std:%f\n\n', mean(y), std(y));
end