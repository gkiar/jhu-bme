function jac = hhjac(y)
xx = hhvoltage(0,y);
[jac fl] = numjac(@hhvoltage,-1, y, y, 0.0001,[],0);

end