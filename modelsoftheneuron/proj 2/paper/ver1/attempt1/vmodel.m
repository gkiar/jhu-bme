function vdot = difeq(t, v)

%v(1) = V, v(2) = s
global params

%how do I get v_eq in this system before computing?
v_eq(1) = 0;
vj = 0;

%compute v_th(i)
v_th(1) = v_eq(1);

%compute phi(i)
phi(1) = 1/(1+exp(-params.beta.val*(v(1)-v_th(1))));

%compute sdot(i)
vdot(2) = params.ar.val.*phi(1).*(1-v(2))-params.ad.val.*v(2);

%compute Ig(i)
%sum for each adjacent gap
%vj? how 
Ig(1) = params.Gg.val.*(v(1) - vj);

%compute Is(i)
%sum for each adjacent synapse
Is(1) = params.Gs.val*v(2)*(v(1)-0);

%compute vdot(i)
vdot(1) = -params.Gc.val.*(v(1) - params.Ec.val)

end