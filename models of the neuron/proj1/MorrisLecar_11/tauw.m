function tw = tauw(v,pml)
% TAUW - compute time constant for dw/dt in the MLE.
%    tau = tauw(v,pml);
% tau and v can be vectors.
   tw = 1./cosh((v-pml(12))/(2*pml(13)));
return
