pml=[4, 8.0, 2, 120, -84, -60, 0.0667, -1.2, 18, 12, 17.4, 12, 17.4, 20, 0, 0]';
% figure(1); clf;
options = odeset('OutputFcn', @odeplot, 'Jacobian', @mlodejac, ...
    'Vectorized', 'on');
tspan = [0 2000];
iext = [30, -1 ,2000];
setmleparms(pml, iext');
[~, vnull, wnull] = makenulls(1);
vv = @(v) vnull(v) - wnull(v);
appr = [-50, -20, 10];
figure(1); clf;
vlim = [-80 60];
fplot(vnull, vlim);
hold on;
fplot(wnull, vlim);

for i=1:3
    e(i,1) = fzero(vv, appr(i));
    e(i,2) = vnull(e(i,1));
    jac = mlodejac(1,e(i,:));
    [tmp1, tmp2] = eig(jac);
    plot(e(i,1),e(i,2), 'ko');
    eval(i,:) = [tmp2(1), tmp2(4)];
    evec{i} = tmp1;
    if real(eval(i,1))*real(eval(i,2)) < 0
       ev = evec{i};
       y0 = e(i,:) + 0.01*ev(:,1)';
       y1 = e(i,:) + 0.01*ev(:,2)';
       figure
       [t,y] = ode15s(@mlode, [0:200], y0, options);
       figure
       [t,x] = ode15s(@mlode_reverse, [0:200], y1, options);
       figure (1)
       plot(y(:,1), y(:,2), x(:,1),x(:,2), 'm')
    end
end
xlim([-60 40]); xlabel('Voltage (mV)');
ylim([-0.1 1]); ylabel('w');
title('Phase plane of MLE system');
