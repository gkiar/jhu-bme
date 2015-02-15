%SBE2 Homework #2
%Author: Greg Kiar
%Version: 0.1
%Date: 02/11/2015

%% q1
x = 0:0.1:1000;
ds = [2, 4, 8, 16, 32];
figure
for d = 1:length(ds)
    g = zeros(1, length(x));
    clear fk
    for k=1:100
        for j=1:length(x)
            ck = 10*k;
            fk(j) = 1*exp(-((x(j)-ck)/ds(d))^2);
        end
        g = g + k*fk;
    end
    plot(x, g)
    hold on
end
xlabel('Stimulus variable'); ylabel('CNS Neuron G Response');
title('Neuron response with varying receptive field widths');

%% q2
ds = logspace(log10(5),log10(100),30);
figure
x = 500;
g = zeros(1, length(ds));
s = g; dg = g;
for d = 1:length(ds)
    for k=1:100
        ck = 10*k;
        fk = 1*exp(-((x-ck)/ds(d))^2);
        df = 2*(ck-x)/ds(d)^2*fk;
        g(d) = g(d) + k*fk;
        dg(d) = dg(d) + k*df;
    end
    s(d) = dg(d)./g(d);
end
semilogx(ds, s)
xlabel('Width of Spread function, d'); ylabel('Relative Neuron Response, S');
title('Relative neuron response with varying receptive field widths');

%% q3
ds = logspace(log10(5),log10(100),30);
figure
x = 500;
g = zeros(1, length(ds));
s = g; dg = g;
for d = 1:length(ds)
    for k=1:100
        ck = 10*k;
        fk = 1*exp(-((x-ck)/ds(d))^2);
        df = 2*(ck-x)/ds(d)^2*fk;
        g(d) = g(d) + k^2*fk;
        dg(d) = dg(d) + k^2*df;
    end
    s(d) = dg(d)./g(d);
end
semilogx(ds, s)
xlabel('Width of Spread function, d'); ylabel('Relative Neuron Response, S');
title('Relative neuron response with varying receptive field widths');
