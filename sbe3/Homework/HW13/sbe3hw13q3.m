
n = [4];
m = [2];

close all
figure (1)
i=1;
subplot(1,length(n),i);
xnull = @(x) (2./x -1).^(1./n(i));
hold on;
ynull = @(x) 2./(1+ x.^m(i));
fplot(xnull,[0.01 2]);
fplot(ynull,[0.01 2]);
xlim([0 2]);
ylim([0 10]);
xlabel('X');
ylabel('Y');
title(sprintf('Nullclines for n=%d, m=%d',n(i),m(i)));
legend('X nullcline', 'Y nullcline');

funx = @(x) ynull(x) - xnull(x);
r(1) = fzero(funx, [0.3]);
r(2) = fzero(funx, [1]);
r(3) = fzero(funx, [1.7]);
ys = ynull(r);
plot(r, ys, 'ko');