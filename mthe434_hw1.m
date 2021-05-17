clc
clear all
close all

N = 250;

x = zeros(1,N);
y = zeros(1,N);
for i = 1:N
    x(i) = 10*rand(1,1);
    y(i) = 10*rand(1,1);
end

x;
%y

% Sums of x
sxi = zeros(1,8);
syi = zeros(1,8);
syixi = zeros(1,8);
syixi2 = zeros(1,8);
syixi3 = zeros(1,8);

for j = 1:8     % sum_x_i^j
    %sxi(4) = 0;
    for i = 1:N
       sxi(j) = sxi(j) + x(i)^j; 
       syi(j) = syi(j) + y(i)^j;
       syixi(j) = syixi(j) + y(i)*x(i)^j;
       syixi2(j) = syixi2(j) + y(i)^j;
       syixi3(j) = syixi3(j) + y(i)^j;
    end
end

syms a0 a1 a2 a3 a4
eqn1 = sxi(4)*a4 + sxi(3)*a3 + sxi(2)*a2 + sxi(1)*a1 + a0 - syi(1) == 0;
eqn2 = sxi(5)*a4 + sxi(4)*a3 + sxi(3)*a2 + sxi(2)*a1 + sxi(1)*a0 - syixi(1) == 0;
eqn3 = sxi(6)*a4 + sxi(5)*a3 + sxi(4)*a2 + sxi(3)*a1 + sxi(2)*a0 - syixi(2) == 0;
eqn4 = sxi(7)*a4 + sxi(6)*a3 + sxi(5)*a2 + sxi(4)*a1 + sxi(3)*a0 - syixi(3) == 0;
eqn5 = sxi(8)*a4 + sxi(7)*a3 + sxi(6)*a2 + sxi(5)*a1 + sxi(4)*a0 - syixi(4) == 0;

[A,B] = equationsToMatrix([eqn1, eqn2, eqn3, eqn4, eqn5], [a0, a1, a2, a3, a4]);

X = linsolve(A,B);

%X(1)
figure(1)
hold on
scatter(x,y)
fplot(@(x) X(5)*x^4+X(4)*x^3+X(3)*x^2+X(2)*x+X(1), [0 10])
