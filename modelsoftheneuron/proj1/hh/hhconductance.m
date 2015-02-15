function conduc = hhconductance(gates)
[params, iext] = gethhparams();
conduc(1,:) = params(1).*gates(:,1).^4;
conduc(2,:) = params(2).*gates(:,2).^2.*gates(:,3);
conduc(3,:) = linspace(params(3),params(3),size(gates,1));
end