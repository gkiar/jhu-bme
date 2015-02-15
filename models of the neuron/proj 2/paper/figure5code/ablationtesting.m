% clear
close all

Iext = [0; 250; 5]; % time on (ms); time off (ms); current (pA)
Gs   = 0.1; % 0.1 nS (100 pS)
Gg   = 0.01; % 0.1 nS (100 pS)
Gc   = 0.01; % 0.01 nS (10 pS)
C    = 100; % 100 fF (1 pF)
B    = 0.125; % 0.125 mV^-1
arr  = 1; % unitless rate const.
ad   = 0.5; % unitless rate const.
Ec   = -35; % -35 mV
Ej   = [ 0 ; % 0 mV (excitatory synapses)
        -45]; % -45 mV (inhibitory synapses)
vth  = -24; % -24 mV (Average from Kunert et al. ref [6])

set_params(Iext, Gs, Gg, Gc, C, B, arr, ad, Ec, Ej, vth);

dt = 0.05;
T = 600;

v = zeros(12,T/dt);
v(:,1) = [-1.4224;0.6538;-4.0188;0.6486;-7.5558;0.6397;
          -45.8658;0.1103;-43.8747;0.1341;-43.4165;0.1421];

tim = 0:dt:T;
for i=1:length(tim)
    dv = weighted_scode(tim(i), v(:,i));
    v(:,i+1) = v(:,i) + dv;
end
v(:,end) = [];

% [ax, p1, p2] = plotyy(tim, v(1,:), tim, v(2,:));
figure
subplot(121)
plot(tim, v(1,:), tim, v(3,:), tim, v(5,:), tim, v(7,:), tim, v(9,:), tim, v(11,:));
ylabel('Membrane Potenial (mV)');
xlabel('Time (ms)');
title('Multi Neuron Firing Response');
hold on;
legend('AVA', 'AVB', 'DB', 'DD', 'VB', 'VD')

Vm = v(5:2:12,:);
[U, S, V] = svd(Vm);
S = S(:,1:6);
ss = sum(sum(S));
S = sum(S);
subplot(122);
plot(1:6,S/ss*100, 'k.', 'markersize', 20);
xlim([0 4]);
xlabel('N');
ylabel('Normalized Sigmas (% of sum of Sigmas)');
title('Singular values');
s_norm = S/ss*100