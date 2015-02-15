function [groups, evals, evecs] = spectral(S, K, method)

[a, b] = size(S);
sig = 0.1;
lz = a*b;
W = sparse(0);
D = W;
for i=1:lz
    [x,y] = ind2sub(size(S), i);
    pos = [x,y;x+1,y;x-1,y;x,y+1;x,y-1;x-1,y-1;x+1,y-1;x-1,y+1;x+1,y+1];
    for j=1:length(pos)
        if (sum(pos(j,:)>0)>1) && pos(j,1)<= a && pos(j,2)<=b
            m = sub2ind(size(S),pos(j,1),pos(j,2));
            temp = exp(-(S(i)-S(m))^2/2/(sig^2));
            W(i,m) = temp;
        end
    end
end
D = diag(sum(W));
% spy(W)

Id = diag(linspace(1.003,1.003,lz));
if strcmp('unnormalized', method)
    L = full(D-W);
elseif strcmp('normalized', method)
    L = Id - full(D\W);
elseif strcmp('symmetric', method)
    L = Id - full(sqrtm(full(D))\W/sqrtm(full(D)));
else
    error 'Invalid method'
end

[evecs, evals] = eigs(L,K,0);
evecs = evecs(:,1:K);
evals = evals(1:K,1:K);

groups = kmeans(evecs,K,'Replicates',5);
end