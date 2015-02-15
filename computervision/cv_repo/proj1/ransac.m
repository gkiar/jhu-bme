function [line, inliers] = ransac(points,iter,thr,mininlier,nlines,figures)
line = zeros(nlines,2); %initialize a few things for later use
lines =zeros(1,2);
len = length(points);
if figures
    figure(99) %open a figure
end
inliers = zeros(len,1);
lim = mininlier; %set my limit 
xl = min(points(:,1)); xh = max(points(:,1)); %get my graph bounds loaded and ready
yl = min(points(:,2)); yh = max(points(:,2));
for z=1:nlines %for each line I want to place
    for i=1:iter %and each iteration I have to go through
        while 1 %inifite loop making sure I pick unique points (not yet fitted to a line)
            a = [round(rand()*(len-1)+1), round(rand()*(len-1)+1)];
            p = [points(a(1),:);points(a(2),:)];
            if ~isnan(p(1)) && ~isnan(p(2))
                if ~(a(1)==a(2))
                    break;
                end
            end
        end
        polys = polyfit(p(:,1),p(:,2),1); %make a polynomial, all the same stuff as before
        m = polys(1); b=polys(2);
        y = @(x) m.*x+b;
        dist = abs(points(:,2) - m.*points(:,1)-b)./(sqrt(m^2+1)); %find a distance btw line
        within_thr = dist < thr;
        within = sum(within_thr); %within the threshold? how many?
        inlier_set = zeros(within,2);
        n = 1;
        for j = 1:len %for all points
            if within_thr(j) == 1 %if within the threshold
                inlier_set(n,1) = points(j,1); %save the values for later
                inlier_set(n,2) = points(j,2);
                n = n+1;
            end
        end
        
        % Here, I deviate slightly from his algorithm. In lecture, Dr.
        % Vidal said that we could choose a best fit by any number of
        % methods, including number of inliers. That is what I have done by
        % creating a "king" line with the most inliers, and a new line is
        % only computed to replace it if more inliers exist within that
        % line.
        if within >= lim %if this is our new best
            lim = within; %raise our standards (c'mon, don't settle)
            inlier_temp =  within_thr.*z; %update an inliers array
            lines = polyfit(inlier_set(:,1), inlier_set(:,2),1); %make a line
        end
        if figures
            clf
            plot(points(:,1),points(:,2),'.'); %plot zee data
            hold on
            plot(p(1,1),p(1,2),'r.',p(2,1), p(2,2),'ro'); %and zee root points
            plot(inlier_set(:,1),inlier_set(:,2),'go'); % and zee inliers
            
            fplot(y, [xl xh],'r'); %and zee line
            xlim([xl xh]); ylim([yl yh]); %aaaan bound it all
            pause
        end
    end
    
    if figures
        clf
        plot(points(:,1),points(:,2),'.'); %plot the points and victorious line
        hold on
        y = @(x) lines(1).*x + lines(2);
        fplot(y, [xl xh],'k');
        xlim([xl xh]); ylim([yl yh]);
        pause
    end
    
    if lines(1) == 0 && lines(2) == 0 %if you failed on parameter giving again..
        warning 'no line found'
    else
        line(z,:) = lines; %add the line to the output
        for x=len:-1:1
           if inlier_temp(x)
              points(x,:) = NaN; %remove inliers from next search
           end
        end
    end
    inliers = inliers + inlier_temp; %add current inliers to output
    lines =zeros(1,2);
    lim=mininlier*lim/length(points); %adjust the limit for smaller data set
end
if figures
    close figure 99 %close our pretty figures
end
end