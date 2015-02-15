function keypoints = corners(I, w, kappa)
gau = fspecial('gaussian', w, (w-1)/2);
[DOGx, DOGy] = gradient(gau);
Ix = imfilter(I,DOGx);
Iy = imfilter(I,DOGy);

M11 = imfilter(Ix.*Ix,gau);
M12 = imfilter(Ix.*Iy,gau);
M22 = imfilter(Iy.*Iy,gau);
Harris = (M11.*M22 - M12.^2)./(M11+M22);
Harris = ordfilt2(Harris,w*w, true(w));
H_script = Harris > kappa;
% plot(H_script);
[x, y] = find(H_script==1);
keypoints = [x,y];
end

