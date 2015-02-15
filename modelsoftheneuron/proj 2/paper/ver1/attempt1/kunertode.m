function ydot = mlode(t, y)

% MLODE - ODE file for the Morris-Lecar Equations.
% Evaluates the derivative of the state vector for the Morris-Lecar
% equations with parameters pml, where pml is a column vector of params
%    pml=[gca, gk, gl, vca, vk, vl, phi, v1, v2, v3, v4, v5, v6 C vic wic]'
% and iext is a column vector describing the external current
%	iext = [iampl, tstart, tstop]'
% v5=v3 and v6=v4 are for tauw().
% Parameters are set through function SETMLEPARMS() only. mlode reads
% the parameters using GETMLEPARMS.
%       ydot = mlode(t,y);     returns dy/dt eval at t,y
% Note, also available:
%       jac = mlodejac(t,y)    returns the Jacobian at t,y
% Note mlode is vectorized, but mlodejac is not.
   
% Get parameters
%     [pml,iext] = getmleparms;
    pml=[4.4, 8.0, 2, 120, -84, -60, 0.02, -1.2, 18, 2, 30, 2, 30, 20, 0,  0]';
    iext = [0,   0,    0]';

% Compute 
	ydot = zeros(2,1);
	if t>=iext(2) & t<iext(3)
	   ydot(1) = (iext(1) - pml(1)*minf(y(1),pml).*(y(1)-pml(4)) - ...
	       pml(2)*y(2).*(y(1)-pml(5)) - pml(3)*(y(1)-pml(6)))/pml(14);
	else
	   ydot(1) = (-pml(1)*minf(y(1),pml).*(y(1)-pml(4)) - ...
	       pml(2)*y(2).*(y(1)-pml(5)) - pml(3)*(y(1)-pml(6)))/pml(14);
	end
	ydot(2) = pml(7)*(winf(y(1),pml)-y(2))./tauw(y(1),pml);
return
