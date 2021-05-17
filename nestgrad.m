% This file aims to compare the performance of the Nesterov algorithm
% to a more standard gradient descent algorithm covered in class.

clc
clear all
close all

% initialize variables
y1 = -6;
y2 = -10;

% f = c1*y1 + c2*y2
c1 = 1;
c2 = 1;

k=0;
a=1;
x1=y1;
x2=y2;

z1=0;
z2=0;

% We start with the one-dimesional case.
y = [y1; y2];
z = [z1; z2];
alpha = norm(y-z)/norm(2*y-2*z);

% iterative steps
N=50; % may change this to a while loop with Nesterov end condition

values1 = zeros(1,N);
values2 = zeros(1,N);
values = zeros(1,N);
track1 = zeros(1,N);
track2 = zeros(1,N);

% initiate gradient descent
y_1 = y1;
y_2 = y2;       % need to track separately from Nesterov algorithm

% These track the gradient descent algorithm
track_1 = zeros(1,N);
track_2 = zeros(1,N);
values_ = zeros(1,N);
for k=1:N
    % update variables
    %f = y^2;             %f = y1^2+y2^2;
    %gradf = 2*y;         %gradf = [2*y1; 2*y2];
    
    i =0;
    while (c1*y1^2+c2*y2^2-c1*(y1-0.5^i*alpha*2*c1*y1)^2-c2*(y2-0.5^i*alpha*2*c2*y2)^2 <= 0.5^(i+1)*alpha*norm([2*c1*y1; 2*c2*y2])^2)
        i = i+1;
    end
    %i = i+1;
    % We have our new i and can update our variables now
    
    alpha = 0.5^i*alpha;
    a_prev = a;
    a = 0.5*(1 + sqrt(4*a*a+1));
    
    x1_prev = x1;
    x2_prev = x2;
    
    x1 = y1 - alpha*2*c1*y1;
    x2 = y2 - alpha*2*c2*y2;
    
    y1 = x1 + (a_prev-1)*(x1-x1_prev)/a;
    y2 = x2 + (a_prev-1)*(x2-x2_prev)/a;
    
    values1(k) = y1^2;
    values2(k) = y2^2;
    values(k) = c1*y1^2 + c2*y2^2;
    track1(k) = y1;
    track2(k) = y2;
    
    % Perform gradient descent:
    
    del_y1 = -2*c1*y_1;      % negative gradient of f at y1,y2
    del_y2 = -2*c2*y_2;
    t=0;
    while (c1*(y_1+t)^2 + c2*(y_2+t)^2 < c1*y_1^2 + c2*y_2^2)
        t = t+0.05;
    end
    t = t+0.05;
    % We should now have (approximately) optimal t
    % Now we update our y values (descent method step 3)
    y_1 = y_1 + t*del_y1;
    y_2 = y_2 + t*del_y2;
    
    % Track gradient descent
    track_1(k) = y_1;
    track_2(k) = y_2;
    values_(k) = c1*y_1^2 + c2*y_2^2;
end

l = 1:N;
%plot(l,track1)

%figure(2)
%plot(l,track2)

%figure(3)
%plot(track1, track2)

figure(4)
plot3(track1, track2, values)
hold on
plot3(track_1, track_2, values_)
hold off

%figure(5)
%plot(l, values-values_)

figure(6)
%plot(track1, values)
plot(l, values)
hold on
plot(l, values_)
%plot(track_1, values_)
%
hold off
figure(7)
plot(track1, values)
hold on
plot(track_1, values_)

