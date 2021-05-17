clc
clear all
close all
hold on
T = 500;

% x and u both binary (either 0 or 1)

beta = 1;
indicator = 0;
eta = 0.5;
cost = 1:T;
%totalCost = 1:101;
totalCost = 1:T;
totalCost(1) = 0;
i=1;

% These initialization values are probably wrong...

x = 0;
u = 0;
p = 0.5;

sigma = 0;

for t = 1:T
%     if (x == 1 && u == 1)
%         indicator = 1;
%     else
%         indicator = 0;
%     end

% Time step t+1 
% Update x
% Probability of x_{t+1} = G (= 1)
    if (x == 1 && u == 1)
        p = 0.3;
    elseif (x == 1 && u == 0)
        p = 0.8;
    elseif (x == 0 && u == 1)
        p = 0.5;
    elseif (x == 0 && u == 0)
        p = 0.95;
    else
        fprintf("Error!")
    end
        
    % Update u (with knowledge/access to previous u, x)
    % u = binornd(1,(1-p));
%     if p > eta
%         u = 1;
%     else
%         u = 0;
%     end

    % Q-learning stuff
    
    
    % Update x
    x = binornd(1,p);
    
    % Update indicator
    if (x == 1 && u == 1)
        indicator = 1;
    else
        indicator = 0;
    end
    
    
    % Compute cost
    cost(t) = beta^t*(-1*indicator + eta*u);
    totalCost(t+1) = totalCost(t) + cost(t);
end
t = 1:T+1;
plot(t,totalCost)


















