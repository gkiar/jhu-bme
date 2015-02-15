function setmleparms(pml, iext)

% Sets current values of MLE parameters. Call as
%       call setmleparms(pml, iext)
% This stores the parameters in an internal store from which they can be
% fetched by getmleparms. This is how mlode gets its parameters.
% pml is a column vector of params
%    pml=[gca, gk, gl, vca, vk, vl, phi, v1, v2, v3, v4, v5, v6 C vic wic]'
% and iext is a column vector describing the external current
%	iext = [iampl, tstart, tstop]'

global PMLXYZ IEXTXYZ

PMLXYZ = pml;
IEXTXYZ = iext;

return
