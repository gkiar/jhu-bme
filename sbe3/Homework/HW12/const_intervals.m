function [T_int, N_int] = const_intervals(T, N, t_max, dt_int)
% CONST_INTERVALS - Takes a trajectory as input. Then computes the value of
% n at even intervals.

% Outputs:
% T_int - Times at even intervals.
% N_int - Count at times corresponding to T_int.
% Inputs:
% T - Vector of transition times.
% N - Count of mRNA corresponding to times given in T. A single trajectory.
% t_max - maximum of amount time
% dt_int - size of time interval

T_int = 0:dt_int:t_max;
N_int = size(T_int);
N_int(1) = N(1);
j = 1;
for i = 2:length(T_int)
    while T(j) < T_int(i)
        j = j+1;
    end
    N_int(i) = N(j-1);
end
end
