close all

%          1       2      3       4     5     6   7    8   9 
%        gkbar   gnabar  glbar   ek    ena   el   T    Q   C
params = [36, 120, 0.3, -72,  55,   -49.3,  6.3, 3,  1];

iext = [-5; 30; 60]; %value, time on, time off
sethhparams(params, iext);

tspan = [0 100];
y0 = [-60.155989; 0];

% options = odeset('OutputFcn', @odeplot);

% Do the simulation
[t, ys] = ode15s(@hhvoltage18, tspan, y0);

close all
figure;
title('Response of HH model with some sustained external current and rest')
% subplot(121);
plot(t, ys(:,1))
xlabel('Time (ms)'); ylabel('Voltage (mV)');
% subplot(122);
% plot(t, ys(:,2))
% xlabel('Time (ms)'); ylabel('Channel activation');
% legend('n channel');

% 
% figure
% plot(t, ys(:,1))