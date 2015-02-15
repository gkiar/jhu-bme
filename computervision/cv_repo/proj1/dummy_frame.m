im = imread('00149v.jpg');
im1 = im2double(im(1:size(im,1)/3,:));
im2 = im2double(im(size(im,1)/3:2*size(im,1)/3,:));
im3 = im2double(im(2*size(im,1)/3:end,:));
imshow(im1)
[yy, xx] = size(im1);
xmin1 = 20; xmin2 = -20;
ymin1 = 10; ymin2 = -10;
frame1 = zeros(yy,xx);
frame2 = zeros(yy,xx);
for i = 1:yy
    for j = 1:xx
        if ~(j-ymin1 <= 0 || i-xmin1 <= 0 || j+ymin1>=yy || i+xmin1 >= xx)
            frame1(j,i) = frame1(j,i) + im1(j-ymin1,i-xmin1);
        end
    end
end
imshow(frame1)

close all
figure
immmm = gray2color(im3, frame2, frame1);
imshow(immmm);