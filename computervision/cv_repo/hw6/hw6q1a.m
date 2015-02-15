clear

S = [3,7,3,3,8;2,7,3,3,8;30,30,-5,-5,8;30,30,-8,-8,8;30,30,-8,-8,8];
% K = 9; %nightsky
K = 12;
method = 'symmetric';
% method = 'normalized';
% method = 'unnormalized';
% im = imread('NightSky.jpg');
im = imread('Penguin.jpg');
im = im2double(im);
im = imresize(im, 0.125); im =2.5*im;
[grps, evals, evecs] = spectral(im, K, method);

S;
close all
ack = reshape(grps, size(im,1), []);
subplot(121);
imagesc(ack);
% imshow(im);

gp2 = kmeans(reshape(im, size(im,1)*size(im,2),[]),K);
ack2 = reshape(gp2, size(im,1), []);
subplot(122);
imagesc(ack2)
