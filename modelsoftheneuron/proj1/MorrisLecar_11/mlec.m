% MLEC - simulate Morris-Lecar equations
% Needs a column vector pml of params:
%    pml=[gca, gk, gl, vca, vk, vl, phi, v1, v2, v3, v4, v5, v6, C, ~, ~]'
% (For meaning of parameters, see Rinzel and Ermentrout, last two params are
% not used) and a column vector iext describing the external current
%	iext = [iampl, tstart, tstop]'
% These will be set up internally to the values for R&E Fig. 7.1 if not supplied.

% NOTE VALUE OF phi CHANGED FROM FIG. 7.1 VALUE!
% if exist('pml')==0
	pml=[4.4, 8.0, 2, 120, -84, -60, 0.04, -1.2, 18, 2, 30, 2, 30, 20, 0, 0]';
% 	fprintf('***pml not supplied, set up internally.***\n')
% end
	
if exist('iext')==0
	iext = [0, 0, 0]';
   fprintf('***iext not supplied, set up internally.***\n')
end

% Initialize display and set options for ode solvers.
figure(1); clf
options = odeset('OutputFcn', @odeplot, 'Jacobian', @mlodejac, ...
        'Vectorized', 'on');

what = 'p';
while what~='q' & what~='Q'
	tspan = [0, input('Enter stop time (ms, 100 is good) ')]';
    if tspan(2)<=0; tspan(2) = 100; end
    
	sy0s = input( ...
	  sprintf('Enter i.c.s (e.g. [v,w]=''%g %g''). <enter> to use 0s: ', ...
	       pml(15),pml(16)),'s');
	if isempty(sy0s)
	   fprintf('***Using default i.v.s (%g & %g).***\n',pml(15:16))
	   y0=pml(15:16);
    else
       y0 = sscanf(sy0s, '%g %g', 2);
    end
    titl = sprintf('M-L eqns, vic=%g mV, hic=%g, iext=%g uA/cm^2.', ...
            y0, iext(1));
	
    figure(1); clf  % to avoid a bug in odeplot
	setmleparms(pml, iext);      % Record parameters for mlode
	[t,y] = ode15s(@mlode, tspan, y0, options);  % Do the simulation
	current = y(end,:);fprintf('Final values: v=%g,  w=%g\n',current);
    what = 'p';

	while what=='p' | what=='P' | what=='h' | what=='H'
		if what=='p' | what=='P'
            clf
		   [ax, h1, h2] = plotyy(t, y(:,1), t, y(:,2));
		   axes(ax(1)); axis([0 tspan(2) -80 50]); ylabel('V, mV.')
		   axes(ax(2)); axis([0 tspan(2) 0 0.5]); ylabel('W')
		   xlabel('Time, ms.'); title(titl)
		elseif what=='h' | what=='H'
           figure(3)
           vlim = [-80 60];
           [y2, vnull, wnull] = makenulls(-80:1/(length(t)-1):60);
%            fplot(vnull, vlim);
           hold on
%            fplot(wnull, vlim);
           phi = [0.04 0.02 0.01];
           for i=1:1
%                pml(7) = phi(i);
%                setmleparms(pml, iext);
%                [t,y] = ode15s(@mlode, tspan, y0, options);  % Do the simulation
               plot(y(:,1), y(:,2))
           end
		   xlabel('V, mV');ylabel('W')
		   axis([-80 50 0 0.5])
		   title(titl)
		end
		what = input('Again, Plot, pHase-plot, or Quit? ','s');
    end
end
