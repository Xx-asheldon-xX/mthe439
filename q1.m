clc
clear all
close all

A = [0.5 1 0;
    0 0.5 1;
    0 0 0.5];
AT = transpose(A);

C = [1 0 0];
CT = transpose(C);

I = eye(3);
T = 1000;
V = 1;

%% Generate sigma
%sigma = I;

%% Plot x

%sigma = A*sigma*AT + I - 1/(C*sigma*CT + 1)*(A*sigma*sigma*AT)
t_array = 1:1001;
xt1 = 1:1000;
xt2 = 1:1000;
xt3 = 1:1000;

xt1(1) = normrnd(0,1);
xt2(1) = normrnd(0,1);
xt3(1) = normrnd(0,1);

%figure(1)
%hold on
for t = 1:1000
   w = normrnd(0,[1;1;1]);
   xt = [xt1(t); xt2(t); xt3(t)];
   xt = A*xt + normrnd(0, [1;1;1]);
   xt1(t+1) = xt(1);
   xt2(t+1) = xt(2);
   xt3(t+1) = xt(3);
end
%plot(t_array,xt1,t_array,xt2,t_array,xt3)
subplot(3,3,1)
plot(t_array,xt1)
axis([-inf inf -15 15])
subplot(3,3,4)
plot(t_array,xt2)
axis([-inf inf -15 15])
subplot(3,3,7)
plot(t_array,xt3)
axis([-inf inf -15 15])

%% Plot m

m_0 = [0;0;0];
mtil_1 = A*m_0;

mtil1 = 1:1000;
mtil2 = 1:1000;
mtil3 = 1:1000;
y = 1000;
mtil1(1) = mtil_1(1);
mtil2(1) = mtil_1(2);
mtil3(1) = mtil_1(3);
sigma = I;
mt = [normrnd(0,1);normrnd(0,1);normrnd(0,1)];

%figure(2)
hold on
for s = 1:1000
   mtil = [mtil1(s); mtil2(s); mtil3(s)];
   v = normrnd(0, [1;1;1]);
   y = xt1(s) + v;
   sigma = A*sigma*AT + I - 1/(C*sigma*CT + 1)*(A*sigma*sigma*AT);
   mt = A*mt + A*sigma*CT.*(y-mt(1))/(sigma(1,1)+V);
   mtil = A*mtil + sigma*CT.*(y-mt(1))/(sigma(1,1)+V);
    
    mtil1(s+1) = mtil(1);
    mtil2(s+1) = mtil(2);
    mtil3(s+1) = mtil(3);
end
%plot(t_array, mtil1, t_array, mtil2, t_array, mtil3)
subplot(3,3,2)
plot(t_array, mtil1)
axis([-inf inf -15 15])
subplot(3,3,5)
plot(t_array, mtil2)
axis([-inf inf -15 15])
subplot(3,3,8)
plot(t_array, mtil3)
axis([-inf inf -15 15])
%% Plot x-m (component-wise)
%figure(3)
%plot(t_array, (xt1-mtil1), t_array, (xt2 - mtil2), t_array, (xt3 - mtil3))
subplot(3,3,3)
plot(t_array, (xt1-mtil1))
axis([-inf inf -15 15])
subplot(3,3,6)
plot(t_array, (xt2-mtil2))
axis([-inf inf -15 15])
subplot(3,3,9)
plot(t_array, (xt3-mtil3))
axis([-inf inf -15 15])