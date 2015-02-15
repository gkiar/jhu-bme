function [matches, ssdvalues] = matching(descriptors1, descriptors2, tau)
l = length(descriptors1);
q = length(descriptors2);
matches = zeros(l,1);
ssdvalues = matches;
for i=1:q
    for j=1:l
        if (matches(j) == 0)
            ssd = sum(sum((descriptors1(j,:)-descriptors2(i,:)).^2));
            if ssdvalues(j) <= tau
                matches(j) = i;
                ssdvalues(j) = ssd;
                break;
            end
        end
    end
end

end