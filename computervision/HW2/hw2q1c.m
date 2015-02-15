%Greg Kiar
%09/20/2014

clear
clf
close all

im = imread('peppers.png');
im = rgb2gray(im);

figure
subplot(2,3,1);
im_1 = edge(im, 'sobel');
imshow(im_1);
xlabel('sobel');
subplot(2,3,2);
im_2 = edge(im, 'prewitt');
imshow(im_2);
xlabel('prewitt');
subplot(2,3,3);
im_3 = edge(im, 'roberts');
imshow(im_3);
xlabel('roberts');
subplot(2,3,4);
im_4 = edge(im, 'log');
imshow(im_4);
xlabel('laplacian of gauss');
subplot(2,3,5);
im_5 = edge(im, 'canny');
imshow(im_5);
xlabel('canny');
subplot(2,3,6);
imshow(im);
xlabel('original');