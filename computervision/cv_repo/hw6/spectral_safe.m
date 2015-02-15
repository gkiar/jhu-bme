function [groups, evals, evecs] = spectral(S, K, method)

[a, b] = size(S);
sig = 0.1;
lz = a*b;
W = sparse(0);
D = W;
for i=1:lz
    for j=1:lz
        poss = [i; i+1;i-1;i+a;i-a];
        if mod(i, a) == 0
            poss(2) = i;
        elseif mod(i, a) == 1
            poss(3) = i;
        end
        if find(poss == j)
            W(i,j) = exp(-(S(i)-S(j))^2/2/(sig^2));
        else
            W(i,j) = 0;
        end
    end
end
D = diag(sum(W));
Id = diag(linspace(1,1,lz));
if strcmp('unnormalized', method)
    L = D-W;
elseif strcmp('normalized', method)
    L = Id - D\W;
elseif strcmp('symmetric', method)
    L = Id - sqrtm(full(D))\W/sqrtm(full(D));
else
    error 'Invalid method'
end

[evecs, evals] = eigs(L,K,0);
evecs = evecs(:,1:K);
evals = evals(1:K,1:K);
for i=1:lz
    y{i}= evecs(i,:);
end
groups = kmeans(evecs,K,'Replicates',5);
end