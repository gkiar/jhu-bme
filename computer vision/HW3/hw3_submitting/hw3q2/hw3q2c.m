clear
close all

images = {'ames1.JPG'; 'ames2.JPG'; 'barton1.JPG';'barton2.JPG'; 'latrobe1.JPG';
    'latrobe2.JPG' ;'library1.JPG'; 'library2.JPG'; 'mergenthaler1.JPG';
    'mergenthaler2.JPG' ;'shaffer1.JPG'; 'shaffer2.JPG'}; %load the images into an array
l = length(images);

w = 5;
kappa = 6e-4;
'loading images...'
for i=1:l
    im_temp = imread(images{i});
    im_temp = im2double(im_temp);
    im{i} = rgb2gray(im_temp);
    keys{i} = corners(im{i},w,kappa);
    descrips{i} = features(im{i}, keys{i});
end
'...images loaded'

tau = 0.0000000001;
for i=1:2:l
    a_d = descrips{i}; a_k = keys{i};
    b_d = descrips{i+1}; b_k = keys{i+1};
    [matches, ssds] = matching(a_d, b_d, tau);
    clf
    subplot(121);
    imshow(im{i});
    hold on
    subplot(122);
    imshow(im{i+1});
    hold on
    for j=1:length(a_d)
        if matches(j) > 0
            subplot(121);
            plot(a_k(j,2),a_k(j,1),'o');
            subplot(122);
            plot(b_k(matches(j),2),b_k(matches(j),1),'o');
        end
    end
    pause
end
close all