clear
close all

Iext = [0; 700; 1]; % time on (ms); time off (ms); current (pA)
Gs   = 0.1; % 0.1 nS (100 pS)
Gg   = 0.1; % 0.1 nS (100 pS)
Gc   = 0.01; % 0.01 nS (10 pS)
C    = 100; % 100 fF (1 pF)
B    = 0.125; % 0.125 mV^-1
arr  = 1; % unitless rate const.
ad   = 0.5; % unitless rate const.
Ec   = -35; % -35 mV
Ej   = [  0 ; % 0 mV (excitatory synapses)
        -45]; % -45 mV (inhibitory synapses)
vth  = -24; % -24 mV (Average from Kunert et al. ref [6])

set_params(Iext, Gs, Gg, Gc, C, B, arr, ad, Ec, Ej, vth);

dt = 0.01;
T = 1400;

v = zeros(T/dt,2);
v(1,:) = [-35, 0.2876];
tim = 0:dt:T;
for i=1:length(tim)
    dv = scode(tim(i), v(i,:));
    v(i+1,:) = v(i,:) + dv;
end
v(end,:) = [];
[ax, p1, p2] = plotyy(tim, v(:,1), tim, v(:,2));
ylabel(ax(1), 'Membrane Potenial (mV)');
ylabel(ax(2), 'Synaptic Activation');
xlabel('Time (ms)');
title('Single Neuron Firing Response');