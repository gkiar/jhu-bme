function descriptors = features(I, keypoints)
len = length(keypoints);
descriptors = zeros(len, 81);
[x, y] = size(I);
for i = 1:len
    a = keypoints(i,2)-4:keypoints(i,2)+4;
    b = keypoints(i,1)-4:keypoints(i,1)+4;
    
    if (min(a)>0 && max(a)<=x) && (min(b)>0 &&  max(b)<=y)
        d=I(a,b);
        descriptors(i,:) = reshape(d,[81 1]);
    end
end

end