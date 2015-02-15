% Greg Kiar
% 09/21/2014

clear
clf
close all

im = imread('friends45698.jpg');
im = im2double(im);
im_sum = sum(im,3);
im(:,:,1) = im(:,:,1)./im_sum;
im(:,:,2) = im(:,:,2)./im_sum;
im(:,:,3) = im(:,:,3)./im_sum;
figure
imshow(im);
figure
plot(im(:,:,1), im(:,:,2), 'o')

f = @(r,g) -(r-0.3)+abs((g-0.12));
M = @(im) im > 0;

ims = f(im(:,:,1), im(:,:,2));
mask = M(ims); 

figure
imshow(ims)
figure
imshow(mask)
figure
im2 = im;
im2(:,:,1) = mask.*im(:,:,1);
im2(:,:,2) = mask.*im(:,:,2);
im2(:,:,3) = mask.*im(:,:,3);
imshow(im2)