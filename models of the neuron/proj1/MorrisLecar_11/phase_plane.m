function phase_plane(t,v,y)

[y, vnull, wnull] = makenulls(v);
vlim = [-80 40];
fplot(vnull, vlim);
hold on
fplot(wnull, vlim);
vv = @(v) vnull(v) - wnull(v);
e(1) = fzero(vv, -20);
e(2) = vnull(e(1));
jac = mlodejac(1, e);
eval = eig(jac)

y2 = [-60; 0.12];
dif = 1;
while abs(dif(1)) > 0.0001 || abs(dif(2)) > 0.0001
    dif = mlode(0, y2)
    y2 = y2 + dif
end

[vs, ws ] = meshgrid(y2(1), y2(2));

end