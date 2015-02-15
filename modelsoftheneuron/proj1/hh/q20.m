params = [36, 120, 0.3, -72,  55,   -49.3,  6.3, 3,  1];

iext = [-40; 0; 20]; %value, time on, time off
sethhparams(params, iext);

figure(1); clf;
vlim = [-80 60];
y0 = [-63 , 0.27; -60, 0.32];
for i=1:2
    [t,y] = ode15s(@hhvoltage, [0:400], y0(i,:));
    figure (1)
    plot(y(:,1), y(:,2))
    hold on
    pause
end
xlim([-60 40]); xlabel('Voltage (mV)');
ylim([-0.1 1]); ylabel('w');
title('Phase plane of HH system');
