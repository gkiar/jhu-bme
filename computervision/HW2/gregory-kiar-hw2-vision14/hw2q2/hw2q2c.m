% Greg Kiar
% 09/21/2014

clear
clf
close all

im = imread('pic_1151313471_10.jpg');

im = im2double(im);
im_sum = sum(im,3); %sums values of each pixel
im(:,:,1) = im(:,:,1)./im_sum; %normalizes each r, g and b coordinate
im(:,:,2) = im(:,:,2)./im_sum;
im(:,:,3) = im(:,:,3)./im_sum;
figure
imshow(im);
figure
plot(im(:,:,1), im(:,:,2), 'o') %plots normalized data

f = @(r,g) (r-0.385)+(g-0.32); %creates arbitrary (trial and error) mask
M = @(im) im > 0; %makes secondary mask function

ims = f(im(:,:,1), im(:,:,2)); %apply primary mask
mask = M(ims); %apply secondary mask

figure
imshow(ims)
figure
imshow(mask)
figure
im2 = im; % multiply mask result with the original image
im2(:,:,1) = mask.*im(:,:,1);
im2(:,:,2) = mask.*im(:,:,2);
im2(:,:,3) = mask.*im(:,:,3);
imshow(im2)