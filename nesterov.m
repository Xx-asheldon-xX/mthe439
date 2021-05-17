clc
clear all
close all

% initialize variables
y = 65;
%y2 = 2;

k=0;
a=1;
x=y;
%x2=y2;

z=100;
%z2=6;

% We start with the one-dimesional case.

alpha = abs(y-z)/norm(2*y-2*z);

% iterative steps
N=50; % may change this to a while loop with Nesterov end condition

values = zeros(1,N);
track = zeros(1,N);


for k=1:N
    % update variables
    %f = y^2;             %f = y1^2+y2^2;
    %gradf = 2*y;         %gradf = [2*y1; 2*y2];
    
    i =0;
    while (y^2-(y-0.5^i*alpha*2*y)^2 < 0.5^(i+1)*alpha*norm(2*y)^2)
        i = i+1;
    end
    i = i+1;
    % We have our new i and can update our variables now
    
    alpha = 0.5^i*alpha;
    a_prev = a;
    a = 0.5*(1 + sqrt(4*a*a+1));
    
    x_prev = x;
    x = y - alpha*2*y;
    y = x + (a_prev-1)*(x-x_prev)/a;
    
    values(k) = y^2;
    track(k) = y;
end

l = 1:N;
%plot(l,values)
figure(2)
plot(l,track)




