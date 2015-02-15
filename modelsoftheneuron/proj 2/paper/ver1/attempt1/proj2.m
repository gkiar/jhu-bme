clear
iext = [0; 50; 5e-3];
init(iext);

% ydot = vmodel([0], [-30 0]);

% [t y] = ode15s(@singleneuron, [0 800], [30e-3 2]);
% plot (t, y(:,1))

dt = 0.1;
t(1) = 0;
v(1,:) = [0;0];
figure
plot(t, v, 'o-');
hold on;
for i=2:300/dt
    if ~mod(iext(2),i)
        iext(3) = -iext(3);
        init(iext);
    end
    t(i) = i;
    dv = singleneuron(i, v(i-1,:));
    v(i,:) = v(i-1,:) + dv';
    plot(t, v, 'o-')
    pause
end
v = v';
plot(t, v)
