pml=[4.4, 8.0, 2, 120, -84, -60, 0.02, -1.2, 18, 2, 30, 2, 30, 20, 0, 0]';

figure(1); clf;
options = odeset('OutputFcn', @odeplot, 'Jacobian', @mlodejac, ...
    'Vectorized', 'on');
tspan = [0 900];
iext = [86, 0, 900]';
setmleparms(pml, iext);
[y2, vnull, wnull] = makenulls(1);
subplot(122);
fplot(vnull, [-80 50]);
hold on;
fplot(wnull, [-80 50]);
legend('v nullcline', 'w nullcline');
titl = sprintf('M-L eqns, vic ranging, hic=0, iext=0 uA/cm^2.');
y0s = [-60.8554, 0.0149; -27.9524, 0.1195 ;-27.9, 0.17];
cols = ['k', 'b', 'r'];
for i=1:length(y0s)
    y0 = y0s(i,:); figure(2);clf;
    [t,y] = ode15s(@mlode, tspan, y0, options);  % Do the simulation
    figure(1)
    hold on;
    subplot(121);
    plot(t, y(:,1), cols(i));
    hold on;
    ylabel('V, mV');xlabel('Time, ms.'); title(titl)
    hold on;
    subplot(122);
    plot(y(:,1), y(:,2), cols(i))
    xlabel('V, mV');ylabel('W');title(titl)
end
figure (1)
ylim([0 0.6]); xlim([-80 50]);
close figure 2
vv = @(v) vnull(v) - wnull(v);
e(1) = fzero(vv, -20);
e(2) = vnull(e(1));
jac = mlodejac(1, e);
eval = eig(jac)
