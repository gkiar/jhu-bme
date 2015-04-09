% SBE2 HWK 7
% Greg Kiar 
% gkiar@jhu.edu
% Apr 1/2015
close all
%% Initialize variables
d1 = 0.33; d2 = 0.43; m1=1.93; m2 = 1.52; lambda1 = d1/2; lambda2 = 2*d2/3;
l1 = 0.014; l2 = 0.019; a1 = m2; a2 = m2*lambda2; a3 = m1*lambda1^2 + l1;
a4 = m2*lambda2^2 + l2; thetas = 57; thetae = 90;
theta = [thetas*pi/180; thetae*pi/180]; 

%% Q1
e = [d1*cos(theta(1)); d1*sin(theta(1))]

%% Q2
h = [1*cos(theta(1)) + d2*cos(theta(1) + theta(2)); d1*sin(theta(1)) + d2*sin(theta(1) + theta(2))]

%% Q3
H = [a3 + a1*d1^2 + a4 + 2*a2*d1*cos(theta(2)), a2*d1*cos(theta(2))+a4;
    a2*d1*cos(theta(2))+a4, a4]

%% Q4
LAMBDA = [-d1*sin(theta(1))-d2*sin(theta(2)+theta(1)), -d2*sin(theta(1)+theta(2));
         d1*cos(theta(1))+d2*cos(theta(1)+theta(2)), d2*cos(theta(1) + theta(2))]

%% Q5
M = (pinv(LAMBDA))'*H*pinv(LAMBDA)

%% Q6
thmin=0; thmax = 2*pi;
th = [];
m = [];
u = [];
for i=thmin:pi/32:thmax
    f = M*[cos(i); sin(i)];
    m = [m;norm(f)];
    u = [u;1];
    th = [th; atan2(f(2), f(1))];
end
figure
polar(th, m);
hold on; polar(th, u);
legend('effective mass (kg)', 'reference (1 kg) mass');

%% Q8
d=0.15; alpha=1; c=2.6; gamma=1;
th = [];
u = [];
Ts = [];
n=1;
for i=thmin:pi/32:thmax
    Ts = [Ts; (c*d^2*m(n)+sqrt(c^2*d^4*m(n)^2 + alpha*c*d^2*m(n)/gamma))/alpha];
    u = [u;0.5];
    th = [th; i];
    n=n+1;
end
figure
polar(th, Ts);
hold on; polar(th, u);
legend('optimal duration of movement (s)', 'reference (0.5 s) movement');

%% Q9
th = [];
u = [];
J = [];
n=1;
for i=thmin:pi/32:thmax
    J = [J; (alpha - m(n)*c*d^2/Ts(n))/(1+gamma*Ts(n))];
    u = [u;0.5];
    th = [th; i];
    n=n+1;
end
figure
polar(th, J);
hold on; polar(th, u);
legend('Utility of movement (s)', 'reference (0.5) utility');
