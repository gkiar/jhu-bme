function win = winf(v,pml)
% WINF - compute w-infinity in the MLE.
%     w = winf(v,pml);
% where v can be a vector and pml is the usual MLE parameter vector.
   win = 0.5*(1 + tanh((v-pml(10))/pml(11)));
return
