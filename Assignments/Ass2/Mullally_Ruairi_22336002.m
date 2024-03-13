close all
clear

% Answer each task in the places shown. The code at the end checks that you
% have created the right variables requested

raw_data = xlsread("muscle_data_2023.xlsx");
strain = raw_data(:, 3);
stress = raw_data(:, 4);

% Task 1
figure(1);
h_fig1 = plot(strain, stress, "b", 'LineWidth', 3.0);
xlabel("Strain", "FontSize", 15);
ylabel("Stress (kPa)", "FontSize", 15);
hold on;



% Task 2

m = 1 : 5;
sse_per_m = zeros(1, 5);

for i = m
    P = polyfit(strain, stress, i);
    y_predicted = polyval(P, strain);
    sse_per_m(i) = sum((stress - y_predicted) .^ 2);

end

figure(2);
h_fig2 = plot(m, sse_per_m, 'r', 'LineWidth', 3);
xlabel("Order of Polynomial", 'FontSize', 15);
ylabel("Sum Squared Error (SSE)", 'FontSize', 15);
title("SSE against Model Order", "FontSize", 20)

my_m = 3;


% Task 3
P = polyfit(strain, stress, my_m);
est_stress = polyval(P, strain);
figure(1);
plot(strain, est_stress, "r");
hold on;

% Task 4

figure(3);
hist((stress - est_stress), 20);
xlabel("Error in Polynomial Fit", "FontSize", 15);
ylabel("Frequency", "FontSize", 15);
title("Distrbution of Model Error", "FontSize", 20);

Sr = sum((stress - y_predicted) .^ 2);
St = sum((stress - mean(stress)) .^ 2);
ccoef_p = (St - Sr) / St;


% Task 5

fun_abs = @(a) sum(abs(polyval(a, strain) - stress));

a = fminsearch(fun_abs, [0.2, 0.2, 0.2, 0.2, 0.2]);
abs_error_estimate = polyval(a, strain);

figure(1);
plot(strain, abs_error_estimate, "k--");


% Task 6
mse_nl = mean((abs_error_estimate(25 : 70) - stress(25 : 70)) .^ 2);
P = polyfit(strain, stress, 4);
est_sig = polyval(P, strain);
mse_ls = mean((est_sig(25 : 70) - stress(25 : 70)) .^ 2);

fprintf('\nMSE of LS fit = %f', mse_ls);
fprintf('\nMSE of Robust fit = %f', mse_nl);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The lines below here just check that you have addressed the variables
% required in the assignment.
%% Check my variables
if (~exist('a'))
  fprintf('\nVariable "a" does not exist.')
end;
if (~exist('mse_nl'))
  fprintf('\nVariable "mse_nl" does not exist.')
end;
if (~exist('mse_ls'))
  fprintf('\nVariable "mse_ls" does not exist.')
end;
if (~exist('ccoef_p'))
  fprintf('\nVariable "ccoef_p" does not exist.')
end;
if (~exist('est_stress'))
  fprintf('\nVariable "est_stress" does not exist.')
end;
if (~exist('my_m'))
  fprintf('\nVariable "my_m" does not exist.')
end;
if (~exist('sse_per_m'))
  fprintf('\nVariable "sse_per_m" does not exist.')
end;
fprintf('\n');