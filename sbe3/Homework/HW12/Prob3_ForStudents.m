
global a b
a = .1; % alpha
bb = 1;
burst = linspace(1,100);

% for m = 1:6
    a = a*1;
    bb = bb*1; % beta
    n_0 = bb/a./burst; % Initial count
    nt = 100; % Number of trajectories
    t_max = 1000; %Minutes for simulation (Approx).
    
    G = cell(nt,2);
    figure(1);
    hold on
    for i = 1:nt
        b = bb/burst(i);
        [T, N] = get_trajectory(n_0(i), t_max, burst(i));
        G{i,1} = T;
        G{i,2} = N;
        %     stairs(G{i,1},G{i,2})
        [T_int(i,:), N_int(i,:)] = const_intervals(T, N, t_max, 1);
        mu(i) = mean(N);
        sigma(i) = var(N);
        %     plot(T_int(i,:),N_int(i,:),'.');
    end
    plot(burst, mu, burst, sigma);
    slope(m) = (sigma(end)-sigma(1))/(burst(end) - burst(1));
% end
slope