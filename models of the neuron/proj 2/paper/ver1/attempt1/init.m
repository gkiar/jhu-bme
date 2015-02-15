function init(iext)

global params;
params = struct();
params.C.name = 'Whole cell membrane capacitance';
params.Gc.name = 'Membrane leakage conductance';
params.Ec.name = 'Leak potential';
params.Iext.name = 'External input current';
params.Igap.name = 'Gap junction current';
params.Isyn.mane = 'Synapse junction current';
params.Gg.name = 'Gap junction conductance';
params.E.name = 'Synaptic reverse potential';
params.Gs.name = 'Total synaptic conductance';
params.s.name = 'Synaptic activity';
params.ar.name = 'Synaptic activity rise time';
params.ad.name = 'Synaptic activity decay time';
params.phi.name = 'Sigmoid function';
params.beta.name = 'Sigmoid width';

params.C.val = 1e-12;
params.Gc.val = 10e-12;
params.Gg.val = 100e-12;
params.Gs.val = 100e-12;
params.Ec.val = -35e-3;
params.E.val = [0;-45e-3];
params.ar.val = 1;
params.ad.val = 5;
params.beta.val = 0.125e-3;
params.Iext.val = iext;

end