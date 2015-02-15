bw = ee;
ll=1; % point index
for m=1:length(bw(1,:));%loop over x
    for n=1:length(bw(:,1));%loop over y
        if bw(n,m) == 1;
            pts(ll,1) = m;
            pts(ll,2) = n;
            ll=ll+1;
        end
    end
end
pts=flipdim(pts,1); %because the xy scatter (contour) plot) is transformed for some reason!
pts=flipdim(pts,2);
plot(pts(:,1),pts(:,2),'o');