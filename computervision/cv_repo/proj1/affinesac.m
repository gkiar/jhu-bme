function [A, T] = affinesac(f1, f2, matches, size)
% inputs:
%   2 sets of features 
%       f1
%       f2
%   1 set of matches between feature arrays
%       matches
%   1 size representing the total size of the inputted images
%       size
%
% outputs:
%   A - Affine transform matrix
%   T - Translation matrix
% 

X1 = f1(1:2,matches(1,:)); % only consider features that were matched
X2 = f2(1:2,matches(2,:)); % between the images moving forward
len = length(matches); % determine how many matches exist
thresh = max(size.*0.02); % distance threshold is 3% of total image size
minliers = len/10; % minimum # of inlier threshold is 10% of the matches

for t = 1:300 % iterate through the ransac algorithm a lot
    points = [round(rand()*(len-1)+1), round(rand()*(len-1)+1)]; % pick pts
    y = [X1(:,points(1))'; X1(:,points(2))']; % set 'to' and 'from' based
    x = [X2(:,points(1))'; X2(:,points(2))']; % on selected points
    
    A{t} = y*x'*(x*x')^(-1); % compute affine matrix
    T{t} = mean(y)'-A{t}*mean(x)'; % compute translation matrix
    
    X2_ = A{t} * X2  + [T{t}(1)*ones(1,len);T{t}(2)*ones(1,len)]; % apply
    xdiff = X2_(1,:) - X1(1,:); % evaluate transform
    ydiff = X2_(2,:) - X1(2,:);
    inliers{t} = (xdiff.^2 + ydiff.^2) <  thresh; % check inliers in set
    
    if sum(inliers{t}) > minliers; % if it was a decent transform
        y = X1(:,find(inliers{t})); % recompute transform on set of inliers
        x = X2(:,find(inliers{t})); % to make it even better
        
        TempA = y*x'*(x*x')^(-1);
        TempT = mean(y')'-TempA*mean(x')'; % ... still recomputing...
        X2_ = TempA * X2  + [TempT(1)*ones(1,len);TempT(2)*ones(1,len)];
        xdiff = X2_(1,:) - X1(1,:);
        ydiff = X2_(2,:) - X1(2,:);
        tempinliers = (xdiff.^2 + ydiff.^2) <  thresh; % evaluate new tfm
        
        if sum(tempinliers) > sum(inliers{t}) % make sure new tfm is better
            A{t} = TempA; % replace initial transform with new and improved
            T{t} = TempT; % tfm
            inliers{t} = tempinliers;
        end
    end
    score(t) = sum(inliers{t}); % store score so we can later pick one
end

[score, best] = max(score); % who's the best?
A = A{best}; % return the best
T = T{best};
end