pml=[4.4, 8.0, 2, 120, -84, -60, 0.02, -1.2, 18, 2, 30, 2, 30, 20, 0, 0]';
% figure(1); clf;
% options = odeset('OutputFcn', @odeplot, 'Jacobian', @mlodejac, ...
%     'Vectorized', 'on');
tspan = [0 500];
is = [10, 0 ,500];
for j = 1:500
    if j >= 250
        is(1) = is(1) + 0.02;
    else
        is(1) = is(1) + 0.3;
    end
    setmleparms(pml, is');
    [~, vnull, wnull] = makenulls(1);
    vv = @(v) vnull(v) - wnull(v);
%     fplot(vnull, [-70 40]);
%     hold on
%     fplot(wnull, [-70 40]);
    e(1) = fzero(vv, -20);
    e(2) = vnull(e(1));
    jac = mlodejac(1, e);
    [a, b] = eig(jac);
    evec{j} = a;
    eval(j,:) = [b(1), b(4)];
    if real(round(eval(j,:)*100000)) == 0
       current = is(1)
       break;
    end
end
eval;
% figure (1); clf;
% plot(real(eval), imag(eval))
% hold on
% plot(real(eval(end,:)), imag(eval(end,:)), 'ko')

iext = [80; 0; 500];
tspan = [0 500];
for j = 1:200
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
plot(t, rate, 'o--');
xlabel('I_{ext} (uA/cm^2)');
ylabel('Rate of action potentials');
title('Change in neuron firing with current applied');