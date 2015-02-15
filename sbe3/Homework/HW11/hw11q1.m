clf
% q1
% f = @(x,y,n,k) (x.^n + y.^n)./ (1+ y.^n + x.^n) - k;

% q2
% f = @(x,y,n,k) (x.^n*y.^n)./ (1+ y.^n*x.^n) - k;

% q3
% f = @(x,y,n,k) (x.^n)./ (1+ y.^n + x.^n) - k;

% q4
f = @(x,y,n,k) (x.^n)./ (1+ x.^n.*y.^n + x.^n) - k;

n = 2;
h = ezplot(@(x,y)f(x,y,n,0.25), [0 5 0 5]);
set(h,'LineStyle','--', 'LineColor', 'k');
hold on
h = ezplot(@(x,y)f(x,y,n,0.75), [0 5 0 5]);
set(h,'LineStyle','--', 'LineColor', 'k');
h = ezplot(@(x,y)f(x,y,n,0.50), [0 5 0 5]);

% n = 4;
% h = ezplot(@(x,y)f(x,y,n,0.25), [0 5 0 5]);
% set(h,'LineStyle','--', 'LineColor', 'k', 'LineWidth', 2);
% hold on
% h = ezplot(@(x,y)f(x,y,n,0.75), [0 5 0 5]);
% set(h,'LineStyle','--', 'LineColor', 'k', 'LineWidth', 2);
% h = ezplot(@(x,y)f(x,y,n,0.50), [0 5 0 5]);
% set(h,'LineWidth', 2);
