
global a b
a = .1; % alpha
b = 1; % beta

n_0 = 10; % Initial count
nt = 1; % Number of trajectories
t_max = 10000; %Minutes for simulation (Approx).
dt = 0.1;
Tem = 100;


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
[T_int, N_int] = const_intervals(T, N, t_max, dt);

M = Tem/dt;
nav = (M+1)^(-1)*sum(N_int(1:M));

S = 0;
for i=1:M
    S(i)  = 0;
    for j=1:M-i
        S(i) = N_int(j)*N_int(j+i) - nav;
    end
    S(i) = (M-i+1)^(-1)*S(i);
end
close all
plot(S)