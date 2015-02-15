function F=model_18_equations(t,VNMH)
A=0.8;%MAYBE CHANGE SLIGHTLY e.g. to 0.82. find out in nr18.m
B=-1;
V=VNMH(1);
N=VNMH(2);
e_l=-49.403;%-50;%-49.403%-50%-45.335;%45.335%-45.3%-45.2%;%TRIAL AND ERROR
[params, iext] = gethhparams();
PHI=1;%3^((T-6.3)/10);%Q=3.

if abs(V+50)>=1.e-4
    aN=-0.01*PHI*(V+50)/(exp(-(V+50)/10)-1);
else
    aN=PHI*0.1/(1.-(V+50)/20);
end

if abs(V+35)>=1.e-4
    aM=-0.1*PHI*(V+35)/(exp(-(V+35)/10)-1);
else
    aM=PHI*1/(1.-(V+35)/20);%check THIS I THINK IT IS WRONG
end
bN=0.125*PHI*exp(-(V+60)/80);
bM=4*PHI*exp(-(V+60)/18);
% aH=0.07*PHI*exp(-(V+60)/20);
% bH=PHI/(exp(-(V+30)/10)+1);



global par1
par=par1;
%e_l=par.e_l;%undo this maybe CHANGE FOR 13_2
if t<=iext(3) && t>= iext(2)
    i_ex= iext(1);
else
    i_ex=0;
end

% M=VNMH(3);
% H=VNMH(4);

%the par variable is what is written with a bar in the instructions.
g_k=par.g_k*N^4;
M_inf=aM/(aM+bM);
g_na_new=par.g_na*M_inf^3*(A+B*N);%gna*minf^3+(a-bn)

            %what is T (temperature) value?


%F=V,N,N,H
%dV/dt
F(1,1)= 1 / par.C *( i_ex - g_k *(V - par.e_k) - g_na_new * (V - par.e_na) - par.g_l * (V - e_l));

%dN/dt
F(2,1)= aN*(1-N)-bN*N;

% %dM/dt
% F(3,1)= aM*(1-M)-bM*M;
% 
% %dH/dt
% F(4,1)= aH*(1-H)-bH*H;