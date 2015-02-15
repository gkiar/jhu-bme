function [R,T,X] = twoviewSFM(x1,x2)

for i = 1:length(x1)
    chi(i,:) = kron(x1(:,i), x2(:,i));
end

[u_chi, sig_chi, v_chi] = svd(chi);
E8 = v_chi(:,9);
E = reshape(E8, 3, []);

[u, sig, v] = svd(E);
sig_av = (sig(1) + sig(5))/2;
sig(1) = 1; sig(5) = 1; sig(9) = 0;

if det(v) < 0; v = -v; end
if det(u) < 0; u = -u; end

RzT_p  = [0 1 0; -1 0 0; 0 0 1];
RzT_m = [0 -1 0; 1 0 0; 0 0 1];

R_p  = u*RzT_p*v';
R_m = u*RzT_m*v';

Th_p  = u*RzT_p'*sig*u';
Th_m = u*RzT_m'*sig*u';

T_p = [Th_p(6);Th_p(7);Th_p(2)];
T_m = [Th_m(6);Th_m(7);Th_m(2)];

for k=1:length(x1) %compute the two viable options
    lambda1(:,k)= [x2(:,k), -R_m*x1(:,k)]\T_p;
    lambda2(:,k)= [x2(:,k), -R_p*x1(:,k)]\T_m;
    lambda3(:,k)= [x2(:,k), -R_p*x1(:,k)]\T_p;
    lambda4(:,k)= [x2(:,k), -R_m*x1(:,k)]\T_m;
    X1(:,k) = x1(:,k)*lambda1(2,k);
    X2(:,k) = x1(:,k)*lambda2(2,k);
    X3(:,k) = x1(:,k)*lambda2(2,k);
    X4(:,k) = x1(:,k)*lambda2(2,k);
end
%pick the better of the two options

if sum(X1(3,:)) > sum(X2(3,:))
    if sum(X1(3,:)) > sum(X3(3,:))
        if sum(X1(3,:)) > sum(X4(3,:))
            X = X1;
            T = T_p;
            R = R_m;
        else
            X = X4;
            T = T_m;
            R = R_m;
        end
    else
        if sum(X4(3,:)) > sum(X3(3,:))
            X = X4;
            T = T_m;
            R = R_m;
        else
            X = X3;
            T = T_p;
            R = R_p;
        end
    end
else
    if sum(X3(3,:)) > sum(X2(3,:))
        if sum(X3(3,:)) > sum(X4(3,:))
            X = X3;
            T = T_p;
            R = R_p;
        else
            X = X4;
            T = T_m;
            R = R_m;
        end
    else
        if sum(X4(3,:)) > sum(X2(3,:))
            X = X4;
            T = T_m;
            R = R_m;
        else
            X = X2;
            T = T_m;
            R = R_p;
        end
    end
end

end