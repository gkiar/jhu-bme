% SBE2 HW 9
% Greg Kiar
% Apr 16th, 2015

clear
%% Question 1
eta = 1e-4;
w = 0;

load X

% m=reshape(x, 228, 320);
% imagesc(m)
% colormap(gray)

% Y = [1,-1,1,1,-1,-1,-1,-1,1,-1];
Y = [-1,-1,-1,1,-1,1,-1,1,-1,1];

w = zeros(size(X,1),1);
for i = 1:1 %100 %2
    for j = 1:size(X,2)
        x=X(:,j);
        y = w'*x;
        delta_w = eta*(Y(j)-y)*x;
        w=w+delta_w;
    end
    strcat('Iteration: ', num2str(i))
    y = w'*X
end
% y = w'*X

%% Question 2
Xdagger = (X'*X)\X'; % you suggested a slightly different equation, but
                     % I assure you this is the same thing.
assert(0==sum(sum(round(abs(Xdagger*X)) - eye(10))))
figure (1)
subplot(121)
Y = X*(Xdagger*X);
imagesc(reshape(Y(:,2), 228, 320)); colormap(gray)
strcat('Relative Error:', num2str(sum(abs(X(:)-Y(:)))/ sum(abs(X(:)))))

subplot(122)
C = X; C(1:36480,:) = 0;
Y = X*(Xdagger*C);
imagesc(reshape(Y(:,2), 228, 320)); colormap(gray)
strcat('Relative Error:', num2str(sum(abs(X(:)-Y(:)))/ sum(abs(X(:)))))

%% Question 3
load HOP

W = A*A' + B*B' + C*C' + D*D';
W=randzero(W, 0.7);
S=Test3;
figure(1); imagesc(reshape(S,40,40));
last = zeros(size(S));
n=1;
while sum(sum(abs(last - S)))>1e-5
    n
    last = S;
    S = sign(W*S);
    figure (2); imagesc(reshape(S,40,40));
    n=n+1;
end
figure (3); imagesc(reshape(S, 40, 40))

% figure (4); imagesc(W); colormap(jet); colorbar;

