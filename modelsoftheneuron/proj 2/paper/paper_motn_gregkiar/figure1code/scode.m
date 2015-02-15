function [ vdot ] = scode(t, v)
%SCODE Single-Compartment Membrane ODE
%   Input args:
%       t ->    [1x1] time (ms)
%       v ->    [Nx2] array where N is the number of neurons/
%               v[i,1] -> voltage (mV) ; v[i,2] -> synaptic activity
%   Output args:
%       vdot -> [Nx2] Differential outputs of system

[Iext, Gs, Gg, Gc, C, B, arr, ad, Ec, Ej, vth] = get_params();
vdot = [0,0];

%% Neuron 1
Ig(1) = Gs * v(1,2) * (0 + (v(1,1)-Ej(1)) + 0); % Ej(1)or(2) depending on synapse + terms for each synapse
Ig(1) = 0; % replace with gap currents for connected neurons

Is(1) = Gg * (0 + (v(1,1)-v(1,1)) + 0); %Assuming 1 has a synapse onto 1
Is(1) = 0; % replace with synaptic currents for connected neurons

if t >= Iext(1) && t <= Iext(2)
    vdot(1,1) = (-Gc * (v(1,1) - Ec) - Ig(1) - Is(1) + Iext(3)) / C; % dV/dt
else
    vdot(1,1) = (-Gc * (v(1,1) - Ec) - Ig(1) - Is(1)) / C; % dV/dt
end
vdot(1,2) = arr * phi(B, vth, v(1,1)) * (1-v(1,2)) - ad * v(1,2); % ds/dt

%% Subsequent Neurons...


%% Functions
    function p = phi(B, vth, vi)
        p = 1 / (1 + exp(-B * (vi-vth)));
    end

end

