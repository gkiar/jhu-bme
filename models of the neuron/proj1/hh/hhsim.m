close all

%          1       2      3       4     5     6   7    8   9 
%        gkbar   gnabar  glbar   ek    ena   el   T    Q   C
params = [36, 120, 0.3, -72,  55,   -50,  6.3, 3,  1];

iext = [-3; 0; 20]; %value, time on, time off
sethhparams(params, iext);

tspan = [0 500];
y0 = [-60.155989; 0.315289; 0.051967; 0.601564];
% dep = 6.6145689701702; %% q 14
% y0(1) = y0(1) + dep;
% options = odeset('OutputFcn', @odeplot);

% Do the simulation
[t, ys] = ode15s(@hhvoltage, tspan, y0);
fprintf('current: v=%f n=%f m=%f h=%f\n', ys(end,:))
% iext = [-3; 0; 20]; %value, time on, time off
% sethhparams(params, iext);
% y2 = ys(end,:)';
% eq = hheqs(y2);
% jac = hhjac(eq);
% es = eig(jac)
% es = eig(jac);  %q14, stable
close all
figure;
title('Response of HH model with some sustained external current and rest')
subplot(121);
plot(t, ys(:,1))
xlabel('Time (ms)'); ylabel('Voltage (mV)');
subplot(122);
plot(t, ys(:,2), t, ys(:,3), t, ys(:,4))
xlabel('Time (ms)'); ylabel('Channel activation');
legend('n channel', 'm channel', 'h channel');

% 
% figure
% plot(t, ys(:,1))