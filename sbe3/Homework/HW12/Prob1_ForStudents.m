
global a b
a = .1; % alpha
b = 1; % beta

n_0 = 10; % Initial count
nt = 1; % Number of trajectories
t_max = 10000; %Minutes for simulation (Approx).

G = cell(nt,2);
figure(1);
clf
hold on
grid on
for i = 1:nt
    [T, N] = get_trajectory(n_0, t_max,1);
    G{i,1} = T;
    G{i,2} = N;
    stairs(G{i,1},G{i,2})
end
[T_int, N_int] = const_intervals(T, N, t_max, 1);
mean(N)
var(N)
plot(T_int,N_int,'.');

[tout, xout] = ode15s(@xoden, [0 t_max], n_0);
plot(tout, xout);
mean(xout)
var(xout)
hold off

