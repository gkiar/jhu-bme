function min = minf(v,pml)
% MINF - compute m-infinity for the MLE. m = minf(v,pml)
% where pml is the usual MLE parameter vector. v and m can be vectors.
   min = 0.5.*(1 + tanh((v-pml(8))/pml(9)));
return
