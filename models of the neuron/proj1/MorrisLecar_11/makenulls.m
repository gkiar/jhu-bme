function [y, vnull, wnull] = makenulls(V)

% Get parameters
[pml,iext] = getmleparms;
vnull = @(V) (iext(1) - pml(1).*minf(V,pml).*(V-pml(4)) - pml(3).*(V-pml(6)))./(pml(2).*(V-pml(5)));
wnull = @(V) winf(V,pml);
% Compute
y = [(iext(1) - pml(1).*minf(V,pml).*(V-pml(4)) - pml(3).*(V-pml(6)))./(pml(2).*(V-pml(5))) ;...
      winf(V,pml)];
return
