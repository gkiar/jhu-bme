% MLESIM - simulate Morris-Lecar equations
% Needs a column vector pml of params:
%    pml=[gca, gk, gl, vca, vk, vl, phi, v1, v2, v3, v4, v5, v6, C, vic, wic]'
% For meaning of parameters, see Rinzel and Ermentrout.
% and a column vector iext describing the external current
%	iext = [iampl, tstart, tstop]'
% which are the current amplitude and the start and stop times.
% These are set up internally to the values for Fig. 7.1 of R&E if not supplied
% in the workspace.
% This always runs with i.c.s set to 0, just to give a spike.

% Parameters for Fig. 7.1. NOTE initial conditions are not included.
% NOTE VALUE OF phi CHANGED FROM FIG. 7.1 VALUE.
%    gca, gk, gl, vca,  vk,  vl,  phi,  v1,  v2,v3, v4,v5, v6, C,junk,junk
pml=[4.4, 8.0, 2, 120, -84, -60, 0.02, -1.2, 18, 2, 30, 2, 30, 20, 0,  0]';

% External current parameters.
%     iext tstart tstop
iext = [0,   0,    0]';

figure(1); clf   % Shouldn't be necessary but prevents an annoying bug
% in odeplot

% Store parameters for mlode:
% setmleparms(pml, iext);

% Simulate for 100 ms from 0 initial conditions (should produce an AP)
tspan = [0; 100];
y0 = [0; 0];

% Show the state variables during the simulation, tell solver where to get
% the Jacobian.
options = odeset('OutputFcn', @odeplot, 'Vectorized', 'on');
%options = odeset('Jacobian', @mlodejac, 'Vectorized', 'on');

% Do the simulation
[t,y] = ode15s(@kunertode, tspan, y0, options);
% Print final value of state variables
current = y(end,:); fprintf('Final values: v=%g,  w=%g\n',current);

% Replot the state variables so the W variable can be seen
[ax, h1, h2] = plotyy(t, y(:,1), t, y(:,2));
axes(ax(1)); ylabel('V, mV.')
axes(ax(2)); ylabel('W')
xlabel('Time, ms.');


v = -80:140/(length(t)-1):60;
% To make a phase plot


% locs1 = find (abs(null(1,:)-null(2,:))<0.005);
% thing = null(1,:)./null(2,:);
% locs2 = [];
% for i=2:length(thing)
%     if (thing(i-1) < 1 && thing (i) > 1) || (thing(i-1) > 1 && thing(i) < 1)
%         locs2 = [locs2, i];
%     end
% end
% plot(VV(locs1), vnull(locs1), 'ro', VV(locs2), vnull(locs2), 'ko');
