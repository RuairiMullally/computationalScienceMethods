% close all

% Initialise your variables

% Task 1

k12 = 0.58;
k21 = 1.87;
m10 = 87.5;
m20 = 280 - m10;

% Task 2

iterations_e3 = (0 : 0.25 : 5);
[m1_e3, m2_e3] = eulerMethod(k12, k21, m10, m20, iterations_e3, 0.25);
m1pe = m1_e3(3/0.25);
m2pe = m2_e3(3/0.25);

% Task 3
iterations_e1 = (0 : 1/12 : 5);
[m1_e1, m2_e1] = eulerMethod(k12, k21, m10, m20, iterations_e1, 1/12);

% Task 4
figure(1);

h_fig1 = plot(iterations_e3, m1_e3, 'b+-', iterations_e3, m2_e3, 'b+-');
hold on;
plot(iterations_e1, m1_e1, 'g.-', iterations_e1, m2_e1, 'g.-', 'MarkerSize', 8);


% Task 5

% Task 6
k12 = k12 * 1.05;
[m1_e1_hot, m2_e1_hot] = eulerMethod(k12, k21, m10, m20, iterations_e1, 1/12);

figure(2);
h_fig2 = plot(iterations_e1, m1_e1_hot, 'r.-', iterations_e1, m2_e1_hot, 'r.-', 'MarkerSize', 8);
hold on;
plot(iterations_e1, m1_e1, 'kx-', iterations_e1, m2_e1, 'kx-');


% Task 7

m1_change_hot = 100 * abs( (m1_e1_hot(3 / (1/12)) - m1_e1(3 / (1/12))) / m1_e1(3 / (1/12)));
m2_change_hot = 100 * abs( (m2_e1_hot(3 / (1/12)) - m2_e1(3 / (1/12))) / m2_e1(3 / (1/12)));



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This tests your functions. Do not change this
testdata = rand(4, 1);
uppertest = upperOcean(testdata(1), testdata(2), testdata(3), testdata(4));
lowertest = lowerOcean(testdata(1), testdata(2), testdata(3), testdata(4));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Function definitions go below here
% You can edit these as you like. Note that you should use better 
% names for the arguments so that they make sense 
% And remember that the arguments have to be in the same order and with the 
% same meaning as in the lab description
function dm1 = lowerOcean(k12, k21, m1, m2)
  dm1 = (-k12 * m1) + (k21 * m2);
end

function dm2 = upperOcean(k12, k21, m1, m2)
  dm2 = (k12 * m1) - (k21 * m2);
end

function [m1_e3, m2_e3] = eulerMethod(k12, k21, m1, m2, iterations, h)

m1_e3(1) = m1;
m2_e3(1) = m2;

    for i = 1 : length(iterations) - 1
        dm1 = lowerOcean(k12, k21, m1_e3(i), m2_e3(i));
        dm2 = upperOcean(k12, k21, m1_e3(i), m2_e3(i));
        m1_e3(i+1) = m1_e3(i) + dm1 * h;
        m2_e3(i+1) = m2_e3(i) + dm2 * h;

    end
end


