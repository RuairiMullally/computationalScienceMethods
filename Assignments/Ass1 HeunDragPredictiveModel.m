%Red Bull Data plotted.
close all
clear 

% Read data from file
% First column is time in secs
% Second column is velocity
% Third column is theoretical terminal velocity at that time
jumpdata = csvread('RedBullJumpData.csv');
t_redbull = jumpdata(:,1);
v_redbull = jumpdata(:,2);
terminal_velocity = jumpdata(:,3); % You need to use this in the last question
N_timestamps = length(t_redbull);

%Calculate freefall velocity vector here
g = 9.81;
v_freefall = g * t_redbull;
%rand(size(t_redbull)) * 20 + 100;

% Part 1
figure(1);
h_part1 = plot(t_redbull, v_redbull, 'r-x', 'linewidth', 2.0);
shg;
hold on;

% Part 2
h_part2 = plot(t_redbull, v_freefall, 'k--', 'linewidth', 2.0); 
shg;
grid on;
axis([0 180 0 400]);
xlabel('Time (secs)', 'fontsize', 24);
ylabel('Velocity (m/s)', 'fontsize', 24);


% Part  3
v_err = abs(((v_redbull - v_freefall)./v_redbull) .* 100);
array_location = find(v_err >= 2);
hit_instant = t_redbull(array_location);

fprintf('Mr. B hits the earth''s atmoshpere at %f secs after he jumps\n',...
       hit_instant(1));



% Part 4
% Now starting from the velocity and time = 56 secs 

g = 9.81;
v_numerical_1 = zeros(N_timestamps, 1);
drag_constant = 3/60;
start = find(t_redbull == 56);
% Starting from this time instant, calculate the velocity required
%v_numerical_1(1:start - 1) = v_redbull(1:start - 1);
v_numerical_1(start) = v_redbull(start);

for i = start : N_timestamps - 1
    slope = g - drag_constant * v_numerical_1(i);
    v_numerical_1(i+1) =v_numerical_1(i) + (t_redbull(i+1) - t_redbull(i))*slope;
end

% Plot using the dashed green line with (+) markers
h_part4 = plot(t_redbull(start: length(v_numerical_1)), v_numerical_1(start: length(v_numerical_1)), 'go--','linewidth',2.0, 'MarkerSize', 2.5);shg



% Part 5 
% Calculate the percentage error as required
per_error = zeros(1, 2); 
pe_1 = find(t_redbull == 69); 
pe_2 = find(t_redbull == 180);
per_error(1) = ((v_numerical_1(pe_1) - v_redbull(pe_1)) / v_redbull(pe_1)) * 100;
per_error(2) = ((v_numerical_1(pe_2) - v_redbull(pe_2)) / v_redbull(pe_2)) * 100;
fprintf('The percentage error at 69 and 180 secs is %1.1f and\n', per_error(1));
fprintf('%3.1f  respectively \n', per_error(2));



% Part 6 
% Also update the drag constant at every timestamp

ending = find(t_redbull == 100);
v_numerical_2 = zeros(size(t_redbull));
v_numerical_2(start) = v_redbull(start);

% Heun loop, predicts from t=56 to t=100
for i = start : ending
    h = t_redbull(i+1) - t_redbull(i);

    drag_const = g/((terminal_velocity(i+1))^2);
    dydt = g - drag_const * (v_numerical_2(i)^2);
    tempy = v_numerical_2(i) + h*dydt ;

    drag_const = g/((terminal_velocity(i+2))^2);
    dydt2 = g - drag_const * (tempy^2);

    slope = (dydt+ dydt2) / 2;
    v_numerical_2(i+1) = v_numerical_2(i) + h*slope;
   
end

% This is the handle plot for part 6 (Black line). 
h_part6 = plot(t_redbull(start:ending), v_numerical_2(start:ending), 'k+-', 'LineWidth', 2.0);
shg

%estimated error for Heun model at t = 100.
est_error = abs( ((v_numerical_2(ending) - v_redbull(ending)) / v_redbull(ending)) * 100);
fprintf('The error at t = 100 secs using my estimated drag information is %f\n', est_error);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Check for existence of variables
if (~exist('v_freefall', 'var'))
  error('The variable v_freefall does not exist.')
end;
if (~exist('hit_instant', 'var'))
  error('The variable hit_instant does not exist.')
end;
if (~exist('per_error', 'var'))
  error('The variable per_error does not exist.')
end;
if (exist('per_error', 'var'))
  l = size(per_error);
  if ( sum(l - [1 2]) ~= 0)
    error('per_error is not a 2 element vector. Please make it so.')
  end;
end;
if (~exist('v_numerical_1', 'var'))
  error('The variable v_numerical_1 does not exist.')
end;  
if (~exist('est_error', 'var'))
  error('The variable est_error does not exist.')
end;  
if (~exist('h_part1', 'var'))
  error('The plot handle h_part1 is missing. Please create it as instructed.')
end;
if (~exist('h_part2', 'var'))
  error('The plot handle h_part2 is missing. Please create it as instructed.')
end;
if (~exist('h_part4', 'var'))
  error('The plot handle h_part4 is missing. Please create it as instructed.')
end;
if (~exist('h_part6', 'var'))
  error('The plot handle h_part6 is missing. Please create it as instructed.')
end;
