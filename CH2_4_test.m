v = [1 2 1; 5 3 2; 0 0 0; 1 0 0]';
%% P = [1/3 1/3 1/3]
P = [1/3 1/3 1/3];
fprintf('The prior probability of three classes is : [1/3 1/3 1/3]\n');
for i = 1:size(v, 2)
    x = v(:, i);
    [M_dist, class] = CH2_4(x, patterns, targets, P);
    fprintf('The Mahalanobis distance between vector %d and three classes is %f, %f, %f\n', ...
        i, M_dist(1), M_dist(2), M_dist(3));
    fprintf('Vector %d belongs to class %d\n\n', i, class);
end
fprintf('\n\n\n');
%% P = [0.8 0.1 0.1]
P = [0.8 0.1 0.1];
fprintf('The prior probability of three classes is : [0.8 0.1 0.1]\n');
for i = 1:size(v, 2)
    x = v(:, i);
    [M_dist, class] = CH2_4(x, patterns, targets, P);
    fprintf('The Mahalanobis distance between vector %d and three classes is %f, %f, %f\n', ...
        i, M_dist(1), M_dist(2), M_dist(3));
    fprintf('Vector %d belongs to class %d\n\n', i, class);
end

