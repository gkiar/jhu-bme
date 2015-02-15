% Greg Kiar
% 09/21/2014

clear
clf
close all

im = imread('friends45698.jpg');
im = rgb2hsv(im); %converts to hsv
im = im2double(im);

figure
plot(im(:,:,1), im(:,:,2), 'o')

mask = (im(:,:,1) < 0.05) & (im(:,:,2)>0.25) & (im(:,:,2) < 0.45); %create mask that thresholds saturation and hue


figure
imshow(mask)
figure
im2 = im; %multiply mask with the image for final result
im2(:,:,1) = mask.*im(:,:,1);
im2(:,:,2) = mask.*im(:,:,2);
im2(:,:,3) = mask.*im(:,:,3);
imshow(im2)