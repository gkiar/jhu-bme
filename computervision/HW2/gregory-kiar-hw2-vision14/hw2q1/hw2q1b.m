 % Greg Kiar
 % 09/20/2014
 
 clear
 clf
 close all
 
 figure (1)
 im = imread('peppers.png'); %input image
 im = rgb2gray(im); %make image grayscale
 im = im2double(im); %make data type double
 imshow(im);

  %% s&p
 figure (2)
 im_noisy = imnoise(im, 'salt & pepper', 0.05); %add noise to the image
 imshow(im_noisy);
 
 figure (3)
 im_med = medfilt2(im_noisy); %use median filtere
 imshow(im_med);

 figure (4)
 h_mean = 1/3*ones(3,1)*1/3*ones(1,3); %create mean mask
 im_mean1 = conv2(im_noisy, h_mean); %apply mean mask
 imshow(im_mean1);
 
 figure (5)
 im_mean2 = filter2(h_mean, im_noisy); %apply mean mask in a different fn
 imshow(im_mean2);
 
 figure (6)
 h_gaus = fspecial('gaussian', [3 3], 1.5); %set gaussian mask
 im_gaus = imfilter(im_noisy, h_gaus); %apply gauss mask
 imshow(im_gaus);
 
 %% gaus noise
 
 figure (7)
 im_noisy2 = imnoise(im, 'gaussian',0, 1); %add gaus noise to image
 imshow(im_noisy2);
 
 figure (8)
 im_med = medfilt2(im_noisy2); %median filter to image
 imshow(im_med);

 figure (9)
 h_mean = 1/3*ones(3,1)*1/3*ones(1,3); %create mean mask
 im_mean1 = conv2(im_noisy2, h_mean); %mean filter image
 imshow(im_mean1);
 
 figure (10)
 im_mean2 = filter2(h_mean, im_noisy2); %apply mean filter again
 imshow(im_mean2);
 
 figure (11)
 h_gaus = fspecial('gaussian', [3 3], 1.5); %create gaussian mask
 im_gaus = imfilter(im_noisy2, h_gaus); %apply gaus mask
 imshow(im_gaus);

clf
close all %semantics of closing things