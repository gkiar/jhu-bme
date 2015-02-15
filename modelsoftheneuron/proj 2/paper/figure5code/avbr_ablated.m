function [ ydot ] = avbr_ablated(t, y)
%MULTI_SCODE Single-Compartment Membrane ODE for Multiple neurons
%   Input args:
%       t ->    [1x1] time (ms)
%       v ->    [Nx2] array where N is the number of neurons/
%               v[i,1] -> voltage (mV) ; v[i,2] -> synaptic activity
%   Output args:
%       vdot -> [Nx2] Differential outputs of system
%
%        1      2      3      4      5     6    7      8     9    10
% y = [V_ava, S_ava, V_avb, S_avb, V_db, S_db, V_dd, S_dd, V_vb, S_vb, ...
%           11    12
%      ... V_vd, S_vd]

% Current assumptions:
%
% - Vth is average for all of them
% - The rest of the network is irrelavant.

% Improvements:
%
% - Figure out Thevenin's
% - Add In to all signals (modulated weak noise)

[Iext, Gs, Gg, Gc, C, B, arr, ad, Ec, Ej, vth] = get_params();
ydot = zeros(12,1);


%% AVA Interneuron ( 1 , 2 )
ava_gaps = [y(5)]; %neurons connected via gap jxns
ava_gw = [2]; %weights for gaps
ava_syns = [y(4), y(12)]; %neurons connected via synapses
ava_sw = [7, 4]; %weights for synapses
ava_pols = [Ej(1), Ej(2)]; %excitatory(1) or inhibitory(2) synapses

if t >= Iext(1) && t <= Iext(2)
    ydot(1) = (-Gc*(y(1)-Ec) - Ig(y(1),ava_gw.*ava_gaps) - Is(y(1),ava_sw.*ava_syns,ava_pols) + Iext(3) + In()) / C; % dV/dt
else
    ydot(1) = (-Gc*(y(1)-Ec) - Ig(y(1),ava_gw.*ava_gaps) - Is(y(1),ava_sw.*ava_syns,ava_pols) + In()) / C; % dV/dt
end
ydot(2) = arr*phi(B,vth,y(1))*(1-y(2)) - ad*y(2); % ds/dt

%% AVB Interneuron ( 3 , 4 )
avb_gaps = [y(5), y(9)]; %neurons connected via gap jxns
avb_gw = [0,0]; %weights for gaps
avb_syns = [y(2)]; %neurons connected via synapses
avb_sw = [2]; %weights for synapses
avb_pols = [Ej(1)]; %excitatory(1) or inhibitory(2) synapses

if t >= Iext(1) && t <= Iext(2)
    ydot(3) = (-Gc*(y(3)-Ec) - Ig(y(3),avb_gw.*avb_gaps) - Is(y(3),avb_sw.*avb_syns,avb_pols) + Iext(3) + In()) / C; % dV/dt
else
    ydot(3) = (-Gc*(y(3)-Ec) - Ig(y(3),avb_gw.*avb_gaps) - Is(y(3),avb_sw.*avb_syns,avb_pols) + In()) / C; % dV/dt
end
ydot(4) = arr*phi(B,vth,y(3))*(1-y(4)) - ad*y(4); % ds/dt

%% DB Motorneuron ( 5 , 6 )
db_gaps = [y(1),y(3),y(9)]; %neurons connected via gap jxns
db_gw = [2,5,3]; %weights for gaps
db_syns = [y(2)]; %neurons connected via synapses
db_sw = [4]; %weights for synapses
db_pols = [Ej(1)]; %excitatory(1) or inhibitory(2) synapses

ydot(5) = (-Gc*(y(5)-Ec) - Ig(y(5),db_gw.*db_gaps) - Is(y(5),db_sw.*db_syns,db_pols) + In()) / C; % dV/dt
ydot(6) = arr*phi(B,vth,y(5))*(1-y(6)) - ad*y(6); % ds/dt

%% DD Motorneuron ( 7 , 8 )
dd_gaps = [y(11)]; %neurons connected via gap jxns
dd_gw = [6]; %weights for gaps
dd_syns = [y(6),y(10),y(12)]; %neurons connected via synapses
dd_sw = [13,74,1]; %weights for synapses
dd_pols = [Ej(2), Ej(2), Ej(1)]; %excitatory(1) or inhibitory(2) synapses

ydot(7) = (-Gc*(y(7)-Ec) - Ig(y(7),dd_gw.*dd_gaps) - Is(y(7),dd_sw.*dd_syns,dd_pols) + In()) / C; % dV/dt
ydot(8) = arr*phi(B,vth,y(7))*(1-y(8)) - ad*y(8); % ds/dt

%% VB Motorneuron ( 9 , 10 )
vb_gaps = [y(3), y(5), y(11)]; %neurons connected via gap jxns
vb_gw = [4,3,1]; %weights for gaps
vb_syns = [y(4), y(12)]; %neurons connected via synapses
vb_sw = [1,3]; %weights for synapses
vb_pols = [Ej(1), Ej(2)]; %excitatory(1) or inhibitory(2) synapses

ydot(9) = (-Gc*(y(9)-Ec) - Ig(y(9),vb_gw.*vb_gaps) - Is(y(9),vb_sw.*vb_syns,vb_pols) + In()) / C; % dV/dt
ydot(10) = arr*phi(B,vth,y(9))*(1-y(10)) - ad*y(10); % ds/dt

%% VD Motorneuron ( 11 , 12 )
vd_gaps = [y(7), y(9)]; %neurons connected via gap jxns
vd_gw = [6,1]; %weights for gaps
vd_syns = [y(2),y(4),y(6),y(8),y(10)]; %neurons connected via synapses
vd_sw = [2,1,70,2,13]; %weights for synapses
vd_pols = [Ej(1), Ej(1), Ej(2), Ej(1), Ej(2)]; %excitatory(1) or inhibitory(2) synapses

ydot(11) = (-Gc*(y(11)-Ec) - Ig(y(11),vd_gw.*vd_gaps) - Is(y(11),vd_sw.*vd_syns,vd_pols) + In()) / C; % dV/dt
ydot(12) = arr*phi(B,vth,y(11))*(1-y(12)) - ad*y(12); % ds/dt

%% Functions
    function val = In()
        val = rand()*30 - 15;
    end

    function val = Ig(v, vv) % vv-> array of v's
        val = 0;
        for ii=1:length(vv)
            val = val + Gg*(v-vv(ii)) ;
        end
    end

    function val = Is(v, ss, ee) % ss-> array of s's; ee-> array of Ej's
        val = 0;
        for ii=1:length(ss)
            val = val + Gs*ss(ii)*(v-ee(ii)) ;
        end
    end

    function p = phi(B, vth, vi)
        p = 1 / (1 + exp(-B * (vi-vth)));
    end

end