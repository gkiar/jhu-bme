pml=[4, 8.0, 2, 120, -84, -60, 0.0667, -1.2, 18, 12, 17.4, 12, 17.4, 20, 0, 0]';
figure(1); clf;
options = odeset('OutputFcn', @odeplot, 'Jacobian', @mlodejac, ...
    'Vectorized', 'on');
tspan = [0 2000];
iext = [35, -1 ,2000];
vlim = [-80 60];
for j = 1:1000
    iext(1) = iext(1) + 0.005;
    setmleparms(pml, iext');
    [~, vnull, wnull] = makenulls(1);
    vv = @(v) vnull(v) - wnull(v);
    e(j,1) = fzero(vv, -20);
    e(j,2) = vnull(e(1));
    jac = mlodejac(1, e(j,:));
    bif = det(jac);
    if abs(bif) < 0.00001
        bif
        iext(1)
        fplot(vnull, vlim);
    end
    if j == 1
        fplot(vnull, vlim);
        hold on
        fplot(wnull, vlim);
    end
end

iext = [30; 0; 500];
tspan = [0 500];
for j = 1:150
    if j ~= 1
        iext(1) = iext(1) + 0.1;
    end
    setmleparms(pml, iext);
    [~, vnull, wnull] = makenulls(1);
    vv = @(v) vnull(v)-wnull(v);
    ex(1) = fzero(vv,-20);
    ex(2) = vv(ex(1));
    clf
    [t,y] = ode15s(@mlode, tspan, ex);
    n = 1;
    for k = 1:length(y)-1
       if y(k) <= 0 && y(k+1) > 0
           pk(n) = t(k+1);
           hold on;
           plot(t(k+1), y(k+1), 'ko');
           n = n+1;
       end
    end
    rate(j) = 0;
    if n > 2
        rate(j) = (n-2)/(pk(n-1) - pk(1));
    end
end
figure
t = 30:0.1:44.9;
plot(t, rate, 'o--');
xlabel('I_{ext} (uA/cm^2)');
ylabel('Rate of action potentials');
title('Change in neuron firing with current applied');