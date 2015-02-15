clear

method = 'symmetric';

K=7;
im = imread('dublin_castle_colorful.jpg');
im = im2double(im);
im = imresize(im, 0.125);
im = rgb2hsv(im);
im = im(:,:,1:2);
[grps, evals, evecs] = spectral(im, K, method);

close all
ack = reshape(grps, size(im,1), []);
subplot(121);
imagesc(ack);
% imshow(im);

gp2 = kmeans(reshape(im(:,:,1:2), size(im,1)*size(im,2),[]),K);
ack2 = reshape(gp2, size(im,1), []);
subplot(122);
imagesc(ack2)
