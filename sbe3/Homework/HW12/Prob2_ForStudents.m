clear
global a b
a = .1; % alpha
b = 1; % beta

n_0 = 0; % Initial count
nt = 1000; % Number of trajectories
t_max = 400; %Minutes for simulation (Approx).

G = cell(nt,2);
figure(1);
clf
hold on
for i = 1:nt
    [T, N] = get_trajectory(n_0, t_max,1);
    G{i,1} = T;
    G{i,2} = N;
    [T_int(i,:), N_int(i,:)] = const_intervals(T, N, t_max, 1);
end

for j = 1:size(N_int,2)
    mu_n(j) = mean(N_int(:,j));
    var_n(j) = var(N_int(:,j));
end
t = T_int(1,:);
[tout, xout] = ode15s(@xoden, [0 t_max], n_0);
plot(tout, xout, 'LineWidth', 2);
plot(t, mu_n, t, mu_n+sqrt(var_n), 'k--', t, mu_n-sqrt(var_n), 'k--');
xlabel('time (min)'); ylabel('n');
hold off

figure
plot(t, var_n)
hold on