%% Header
%{

Course: EN.600.661 ; Computer Vision
Term: Fall 2014
Professor: Rene Vidal
Date Due: 11/04/2014
Students: Greg Kiar
          Michael Abboud

%}
%% Algorithm
%{
                                           _______
 _______     _______     _______          |  _____|_
|       |   |       |   |       |         | |  _____|_
|   R   |   |   G   |   |   B   |   -->   | | |       |
|       |   |       |   |       |         | | |  RGB  |
|       |   |       |   |       |          -| |       |
 -------     -------     -------             -|       |
                                               -------
1. Get SIFT Descriptors for images R,G,B
2. Determine number of matches between Descriptors from 1. for each set of
AB, AC, and BC image pairs
3. Pick image with most matches to other images as "center" image
4. Perform RANSAC between one "outer" image and the "center" image
    a) Randomly pick pairs of matched points between the images
    b) Compute affine transform based on selected points
    c) Determine distance of transformed "outer" image descriptors to the
        equivalent "center" image descriptors
    d) If reasonable number of descriptors are within a distance threshold,
        recompute the affine transform using only the inliers and store the
        value of the transform and number of inliers
    e) Iterate with different subset of descriptor pairs until K iterations
        elapse
5. Repeat 4. with the other "outer" image and the "center" image
6. Apply transforms for both "outer" images
7. Take intensities of each transformed image and combine them to be a
    single RGB image
8. Be happy 

%}

%% Go!

%-------------------------------------------------------------------------
%                                       Load image; Split into color parts
%-------------------------------------------------------------------------
close all
clear;clc;

image_file = '00215u.tif'; % load image
dsmples =0; % decide how many times to downsample

I = im2double(imread(image_file)); % get it in a nicer format
[M, N] = size(I); % figure out the size
while mod(M,3)~=0 % throw away a few junk rows if necessary...
    I = I(1:end-1,:); % to make life easier later
    [M,N] = size(I);
end
im_b = single(I(1:M/3+1,:)); % divide image into thirds based on color
im_g = single(I(M/3:2*M/3,:)); % order in the original image
im_r = single(I(2*M/3:end,:));

im_r_s = im_r; % seed our potentially downsampled images
im_g_s = im_g;
im_b_s = im_b;

for i = 1:dsmples
    im_r_s = imfilter(im_r_s, fspecial('gaussian',20,0.1)); % smooth and
    im_r_s = im_r_s(1:2:end,1:2:end); %  then downsample for each
    im_g_s = imfilter(im_g_s, fspecial('gaussian',20,0.1));
    im_g_s = im_g_s(1:2:end,1:2:end);
    im_b_s = imfilter(im_b_s, fspecial('gaussian',20,0.1));
    im_b_s = im_b_s(1:2:end,1:2:end);
end

%-------------------------------------------------------------------------
%                                          Get SIFT Descriptors for Images
%-------------------------------------------------------------------------
[fr, dr] = vl_sift(im_r_s);[fg, dg] = vl_sift(im_g_s); % get sift descrips
[fb, db] = vl_sift(im_b_s);

[~,index,~] = unique(fr(1:2,:)','rows'); % throw away duplicate features 
fr = fr(1:2,index); dr = dr(:,index);
[~,index,~] = unique(fg(1:2,:)','rows');
fg = fg(1:2,index); dg = dg(:,index);
[~,index,~] = unique(fb(1:2,:)','rows');
fb = fb(1:2,index); db = db(:,index);

[grMatch, ~] = vl_ubcmatch(dg,dr); % get matches between other colours
[brMatch, ~] = vl_ubcmatch(db,dr); % and red

%   solving for R-->G,B
[Ag, Tg] = affinesac(fg, fr, grMatch, size(im_r_s)); % compute affine tfms
[Ab, Tb] = affinesac(fb, fr, brMatch, size(im_r_s));

%-------------------------------------------------------------------------
%                                           Apply Transformation to Images
%-------------------------------------------------------------------------

[M_s,N_s] = size(im_r_s);  % get img size
x = 1:N_s; y = 1:M_s; % break down into coordinates

[x, y] = meshgrid(x,y); % make a mesh of coords
x_ = reshape(x, 1, []); % and put them in a more useable form
y_ = reshape(y, 1, []);
X = [x_;y_]; % finally... useable coordinates
len = length(X); % how many do I have?


Xrg = round(Ag * X  + [Tg(1)*ones(1,len);Tg(2)*ones(1,len)]); % Apply tfm
Xrb = round(Ab * X  + [Tb(1)*ones(1,len);Tb(2)*ones(1,len)]); % towards R

im_rgb = mergeImages(im_r_s,im_g_s,im_b_s,X,Xrg,Xrb); % combine images

im_rgb_0(:,:,1) = im_r_s; % quickly throw together dummy for comparison
im_rgb_0(:,:,2) = im_g_s;
im_rgb_0(:,:,3) = im_b_s;

% figure; % show me how great I am
% subplot(121);imshow(im_rgb_0);title('Original');
% subplot(122);imshow(im_rgb);title('Final');
toc
