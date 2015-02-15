function min = minfhh(v)
% MINF - compute m-infinity for the MLE. m = minf(v,pml)
% where pml is the usual MLE parameter vector. v and m can be vectors.
   min = 0.5.*(1 + tanh((v+1.2)/18));
return
