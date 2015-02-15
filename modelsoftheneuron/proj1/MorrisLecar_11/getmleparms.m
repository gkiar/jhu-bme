function [pml,iext] = getmleparms

% Returns values of MLE parameters stored in internal store by setmleparms.
% Call as
%        [pml,iext] = getmleparms
% User should set parameters to be used by mlode with setmleparms. This routine
% is used by mlode to read the current parameter vector.
% pml is a column vector of params
%    pml=[gca, gk, gl, vca, vk, vl, phi, v1, v2, v3, v4, v5, v6 C vic wic]'
% and iext is a column vector describing the external current
%	iext = [iampl, tstart, tstop]'

global PMLXYZ IEXTXYZ

pml = PMLXYZ;
iext = IEXTXYZ;

return
