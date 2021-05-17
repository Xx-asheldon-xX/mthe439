clc
clear all
%close all

N = 100;        % why not

%u = randi([1 N]);  % random value between 1 and N
cost = 0;
time = 0;
figure(2)
hold on
for count = 1:20
    indicator = 0;
    cost = 0;
    time = 0;
    for t = 0:N-1
        p = rand;
        %p(t) = p;
        x = 1-1/(nthroot(2,(N-t)));     % order statistic
        
        if p > x
            u = 0;
        elseif indicator == 1
            u = 0;
        else
            u = 1;
            indicator = 1;
            time = t;
        end
        cost = cost + u*p;
    end
    %t = 1:N;
    scatter(time, cost)
end

