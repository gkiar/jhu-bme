clear
close all

images = {'ames1.JPG'; 'ames2.JPG'; 'barton1.JPG';'barton2.JPG'; 'latrobe1.JPG';
    'latrobe2.JPG' ;'library1.JPG'; 'library2.JPG'; 'mergenthaler1.JPG';
    'mergenthaler2.JPG' ;'shaffer1.JPG'; 'shaffer2.JPG'}; %load the images into an array
l = length(images);

num_w = 3;
w = [3, 5, 7];
num_kappa = 3;
kappa = [1 3 5]*1e-4;

for i=1:l
    im = imread(images{i});
    im = im2double(im);
    im2 = rgb2gray(im);
    for j=1:num_w
        for k=1:num_kappa
            keys = corners(im2,w(j),kappa(k));
            descrips = features(im, keys);
            clf
            imshow(im);
            hold on
            plot(keys(:,2),keys(:,1),'o');
            pause
        end
    end
end
close all