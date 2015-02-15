close all

%          1       2      3       4     5     6   7    8   9 
%        gkbar   gnabar  glbar   ek    ena   el   T    Q   C
params = [36, 120, 0.3, -72,  55,   -50,  6.3, 3,  1];

iext = [-3; 0; 20]; %value, time on, time off
sethhparams(params, iext);

tspan = [0 200];
y0 = [-60; 0.315289; 0.051967; 0.601564];
y1 = [-63.5493; 0.2641; 0.0346; 0.7081];
% dep = 6.6145689701702; %% q 14
% y0(1) = y0(1) + dep;
% options = odeset('OutputFcn', @odeplot);

% Do the simulation
[t, ys] = ode15s(@hhvoltage17, tspan, y0);
[t, yd] = ode15s(@hhvoltage17, tspan, y1);

y2 = ys(end,:)';
eq = hheqs(y2);
jac = hhjac(eq);
es = eig(jac)
es = eig(jac);  %q14, stable


figure
plot(ys(:,1), ys(:,3))
hold on
plot(yd(:,1), yd(:,3), 'k')
xlabel('Voltage (mV)');
ylabel('m value');
title('Phase plane of annode break spike');
legend('No hyperpolarization', 'Hyperpolarization current applied');