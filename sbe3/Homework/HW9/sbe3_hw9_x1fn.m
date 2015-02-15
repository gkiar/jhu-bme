function [val] = sbe3_hw9_x1fn(t,p,m)
val = [(1/120)*1 - (1/600)*m; (1/600).*m - (1/36000)*p];
end