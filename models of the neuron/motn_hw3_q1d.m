clf
close all

alpha_n = @(v) 0.01*(v+60)/(1-exp((-v-60)/10));
beta_n = @(v) 0.125*exp((-v-70)/80);


hille_n = @(v) alpha_n(v)/(alpha_n(v)+beta_n(v));
hille_tao = @(v) 1/(alpha_n(v)+beta_n(v));


z_g = 0.062;
% z_g = 4.5;
v_h = 55;
alpha = 1.7;
lambda = 0.81;

my_n = @(v) 1/(1+exp(-z_g*(v+v_h)));
my_tao = @(v) 1/(alpha*exp(lambda*z_g*v)*(1+exp(-z_g*(v+v_h))));

figure
subplot(121)
fplot(hille_n, [-100 50]);
hold on
fplot(my_n, [-100 50],'k');
legend('hille n', 'my n');
subplot(122)
fplot(hille_tao, [-100 50]);
hold on
fplot(my_tao, [-100 50], 'k');
legend('hille tao', 'my tao');