% Greg Kiar 
% 09/17/2014

clf
close all
clear

%% Open image, setup figure window
im = imread('peppers.png'); %reads image and forms array of pixel values
im = rgb2gray(im); %makes it gray
figure;
imshow(im);
pause

%% brighten / contrast
figure;
imshow(im);
brighten(0.5); 
pause

figure;
imshow(im);
contrast(im); 
pause
%% histeq
figure;
im_eq = histeq(im, 32); 
imshow(im_eq);
pause

% imcontrast -- might need to comment out this section to run through the
% last one too.
h = figure;
imshow(im);
imcontrast(h); 
pause

%% imadjust
figure;
im_ad = imadjust(im); 
imshow(im_ad);
pause

clf
close all