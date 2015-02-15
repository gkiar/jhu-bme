% Greg Kiar 
% 09/17/2014

clf
close all
clear

%% Open image, setup figure window
im = imread('peppers.png'); %reads image and forms array of pixel values
im = rgb2gray(im); %makes it gray
figure; %open new figure
imshow(im); %show image

%% brighten / contrast
figure;
imshow(im); %show image
brighten(0.5); %change the colour map of the image

figure;
imshow(im); %show image
contrast(im); %change the contrast

%% histeq
figure;
im_eq = histeq(im, 32); %sets adjusted histogram with 32 bins
imshow(im_eq); %show new image

% imcontrast -- might need to comment out this section to run through the
% last one too.
h = figure;
imshow(im);
imcontrast(h); %open contrast tool

%% imadjust
figure;
im_ad = imadjust(im); %adjust the image
imshow(im_ad);

clf
close all %semantics, close things