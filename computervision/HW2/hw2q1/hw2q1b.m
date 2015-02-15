 % Greg Kiar
 % 09/20/2014
 
 clear
 clf
 close all
 
 figure (1)
 im = imread('peppers.png');
 im = rgb2gray(im);
 im = im2double(im);
 imshow(im);

  %% s&p
 figure (2)
 im_noisy = imnoise(im, 'salt & pepper', 0.05);
 imshow(im_noisy);
%  pause
 
 figure (3)
 im_med = medfilt2(im_noisy);
 imshow(im_med);
%  pause

 figure (4)
 h_mean = 1/3*ones(3,1)*1/3*ones(1,3);
 im_mean1 = conv2(im_noisy, h_mean);
 imshow(im_mean1);
%  pause
 
 figure (5)
 im_mean2 = filter2(h_mean, im_noisy);
 imshow(im_mean2);
%  pause
 
 figure (6)
 h_gaus = fspecial('gaussian', [3 3], 1.5);
 im_gaus = imfilter(im_noisy, h_gaus);
 imshow(im_gaus);
%  pause
 
 %% gaus noise
 
 figure (7)
 im_noisy2 = imnoise(im, 'gaussian',0, 1);
 imshow(im_noisy2);
%  pause
 
 figure (8)
 im_med = medfilt2(im_noisy2);
 imshow(im_med);
%  pause
 
 figure (9)
 h_mean = 1/3*ones(3,1)*1/3*ones(1,3);
 im_mean1 = conv2(im_noisy2, h_mean);
 imshow(im_mean1);
%  pause
 
 figure (10)
 im_mean2 = filter2(h_mean, im_noisy2);
 imshow(im_mean2);
%  pause
 
 figure (11)
 h_gaus = fspecial('gaussian', [3 3], 1.5);
 im_gaus = imfilter(im_noisy2, h_gaus);
 imshow(im_gaus);
%  pause

clf
close all