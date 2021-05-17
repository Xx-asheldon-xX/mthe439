% This file differs from the first Nesterov script only in that it applies
% the Nesterov algorithm on a two-dimensional function, rather than 1D. 

clc
clear all
close all

% initialize variables
y1 = 40;
y2 = 4;

% f = c1*y1 + c2*y2
c1 = 1;
c2 = 1;

k=0;
a=1;
x1=y1;
x2=y2;

z1=1;
z2=-1;


y = [y1; y2];
z = [z1; z2];
alpha = norm(y-z)/norm(2*y-2*z);
alpha_prev = alpha;
% iterative steps
N=40; % may change this to a while loop with Nesterov end condition

values1 = zeros(1,N);
values2 = zeros(1,N);
values = zeros(1,N);
track1 = zeros(1,N);
track2 = zeros(1,N);

for k=0:N-1
    % update variables
    %f = y^2;             %f = y1^2+y2^2;
    %gradf = 2*y;         %gradf = [2*y1; 2*y2];
    
    i =0;
    while (c1*y1^2+c2*y2^2-c1*(y1-0.5^i*alpha_prev*2*c1*y1)^2-c2*(y2-0.5^i*alpha_prev*2*c2*y2)^2 <= 0.5^(i+1)*alpha_prev*norm([2*c1*y1; 2*c2*y2])^2)
        i = i+1;
    end
    %i = i+1;
    % We have our new i and can update our variables now
    alpha_prev = alpha;
    alpha = 0.5^i*alpha;
    a_prev = a;
    a = 0.5*(1 + sqrt(4*a*a+1));
    
    x1_prev = x1;
    x2_prev = x2;
    
    x1 = y1 - alpha*2*c1*y1;
    x2 = y2 - alpha*2*c2*y2;
    
    y1 = x1 + (a_prev-1)*(x1-x1_prev)/a;
    y2 = x2 + (a_prev-1)*(x2-x2_prev)/a;
    
    p=k+1;
    values1(p) = y1^2;
    values2(p) = y2^2;
    values(p) = c1*y1^2 + c2*y2^2;
    track1(p) = y1;
    track2(p) = y2;
end

l = 1:N;
%plot(l,track1)

%figure(2)
%plot(l,track2)

%figure(3)
%plot(track1, track2)

figure(4)
plot3(track1, track2, values)

figure(5)
plot(l, values)

