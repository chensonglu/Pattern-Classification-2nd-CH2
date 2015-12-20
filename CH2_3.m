load CH2.mat
error_vec = zeros(3, 1);
Bbound_vec = zeros(3, 1);
% calculate classification error and Bhattacharyya bound
% same to CH2_2_test
% modify two classes and two prior probabilities
for i = 1:3
    [model, error, Bbound] = CH2_2(patterns, targets, 1, 3, 0.5, 0.5, i);
    model_cell{i} = model;
    error_vec(i) = error;
    Bbound_vec(i) = Bbound;
end
% plot 
plot(1:3, error_vec, '--ro', 1:3, Bbound_vec, '-g*');
xlabel('dim');
ylabel('error');
legend('classification error', 'Bhattacharyya bound');