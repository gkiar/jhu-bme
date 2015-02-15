clear
close all

images = {'ames1.JPG'; 'ames2.JPG'; 'barton1.JPG';'barton2.JPG'; 'latrobe1.JPG';
    'latrobe2.JPG' ;'library1.JPG'; 'library2.JPG'; 'mergenthaler1.JPG';
    'mergenthaler2.JPG' ;'shaffer1.JPG'; 'shaffer2.JPG'}; %load the images into an array
l = length(images);
nlines = 10;
figure
for i=1:l %iterate over each image
    clf
    subplot(131); %we're gonna plot the image
    im = imread(images{i});
    imshow(im);
    im2 = rgb2gray(im);
    subplot(132); %take some edges of it and plot that too
    ee = edge(im2,'canny',0.45);
    imshow(ee);
    subplot(133); %convert that to x,y coordinates and ransac that, oh, and plot that too
    [y,x] = find([ee]==1); % silly conversion from 2d image to coords
%     plot(x,y,'.');
    [lines, inliers] = ransacm([x,y],40,max(abs(y))*0.007,round(length(ee)*.008),nlines,0);
    image(im); %plot the image with ransac overlayed
    hold on;
    for j=1:nlines
       f = @(x) lines(j,1).*x + lines(j,2);
       fplot(f, [0 length(im)]);
    end
    pause %hit a key to continue
end