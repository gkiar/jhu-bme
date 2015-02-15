%testing
clear
load('data-8-point-algorithm.mat');
R_true = R;
T_true = T/norm(T);
X_true = X/norm(X, 'fro');

sig = 0;
len = length(x1);
x1_orig = x1;
x2_orig = x2;
tic;
for i=1:1100
    if ~mod(i, 100)
        sig = sig + 1e-4
        i
    end
    x1 = x1_orig + [sig*randn(2,len); ones(1, len)];
    x2 = x2_orig + [sig*randn(2,len); ones(1, len)];
    [R, T, X] = twoviewSFM(x1,x2);
    T = T/norm(T);
    X = X/norm(X, 'fro');
    th_r(i) = 180/pi*abs(acos((trace(R'*R_true)-1)/2));
    th_t(i) = 180/pi*abs(acos(T'*T_true));
    th_x(i) = 180/pi*abs(acos(trace(X'*X_true)));
end
t = toc

clf; close all;
figure
subplot(311)
plot(th_r)
ylabel('Degrees');
title('Error in R');
subplot(312)
plot(th_t)
ylabel('Degrees');
title('Error in T');
subplot(313)
plot(th_x)
ylabel('Degrees');
title('Error in X');
xlabel('Iteration (sigma increases with N)');