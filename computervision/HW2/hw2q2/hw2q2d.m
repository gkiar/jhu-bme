% Greg Kiar
% 09/21/2014

clear
clf
close all

im = imread('pic_1151313471_10.jpg');
im = rgb2hsv(im);
im = im2double(im);
figure
subplot(321);
imshow(im(:,:,1));
subplot(322);
imshow(1-im(:,:,1));

subplot(323);
imshow(im(:,:,2));
subplot(325);
imshow(im(:,:,3));
figure
plot(im(:,:,1), im(:,:,2), 'o')

mask = (im(:,:,1) < 0.1) & (im(:,:,2)>0.1);


figure
imshow(mask)
figure
im2 = im;
im2(:,:,1) = mask.*im(:,:,1);
im2(:,:,2) = mask.*im(:,:,2);
im2(:,:,3) = mask.*im(:,:,3);
imshow(im2)