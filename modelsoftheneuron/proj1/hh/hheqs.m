function eqs = hheqs(y)
i =1;
dX = 1;
while ((i < 700) & dX > 0.0001)
    i = i+1;
    FTY = hhvoltage18(0, y);
    [J, b] = numjac(@hhvoltage18, 0, y, FTY, 0.001, [], 0);
    dX = -J\FTY;
    y = y + dX;
end
dX;
eqs = y;
end