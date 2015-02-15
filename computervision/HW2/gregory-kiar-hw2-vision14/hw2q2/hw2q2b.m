%Greg Kiar
%09/20/2014

clear
clf
close all

im = imread('pic_1151313471_10.jpg'); %open image

im2 = rgb2hsv(im); %create hsv image
figure % plot all of the individual images on their own subplot
subplot(2,3,1);
imshow(im(:,:,1));
xlabel('red');
subplot(2,3,2);
imshow(im(:,:,2));
xlabel('green');
subplot(2,3,3);
imshow(im(:,:,3));
xlabel('blue'); %same as last comment... hopefully you get the point ;)

subplot(2,3,4);
imshow(im2(:,:,1));
xlabel('hue');
subplot(2,3,5);
imshow(im2(:,:,2));
xlabel('saturation');
subplot(2,3,6);
imshow(im2(:,:,3));
xlabel('value');