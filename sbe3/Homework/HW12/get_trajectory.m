function [T, N] = get_trajectory(n_0, t_max, burst)
% GET_TRAJECTORY - Computes a single Gillespie trajectory.
% Outputs:
% T - transition times
% N - counts at each transition time
% Inputs:
% n_0 - initial number of molecules.
% t_max - length of time of the simulation.

global a b
t = 0;
j = 1;
T(1) = 0;
N(1) = n_0;
while t < t_max
    j = j+1;
    dt = exprnd(b + a*N(j-1));
    t = t + dt;
    T(j) = t;
    if rand < b/(b+a*N(j-1))
        N(j) = N(j-1) + burst;
    else
        N(j) = N(j-1) - 1;
        if N(j) <= 0
            N(j) = 0;
        end
    end
    
end
end
