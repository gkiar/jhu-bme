clear;clc;close all;


im1 = ones(20,26);
im2 = 2 * ones(20,26);
imsize = size(im1);
th = pi;
A = [cos(th) -sin(th);
    sin(th)  cos(th)];
T = [2;5];
X = 1:size(im2,2);
Y = 1:size(im2,1);
[X, Y] = meshgrid(X,Y);
X_ = round(A(1).*X + A(2).*Y + T(1));
Y_ = round(A(3).*X + A(4).*Y + T(2));


xrange = min([1, min(X_)]):max([size(im1,2), size(im2,2), max(X_)]);
yrange = min([1, min(Y_)]):max([size(im1,1), size(im2,1), max(Y_)]);
ymin = yrange(1)-1;
xmin = xrange(1)-1;
im2_ = zeros(length(yrange),length(xrange));
Y_ = Y_ - ymin;
X_ = X_ - xmin;

for i = 1:length(X)
    for j = 1:length(Y)
        im2_(Y_(j),X_(i)) = im2(Y(j),X(i));
    end
end
imshow(im2_)