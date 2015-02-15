clear
close all

d = [0:2/99:2; 0:2/99:2]; %y = x
d = d';
d2 = [0:2/99:2; 2:-2/99:0]; % 6 = -x
d2=d2';
d = [d ;d2];
a= rand(100,2)*2; %uniform noise
d= [d;a];
d= d-1;
noise = (0.1/sqrt(2)).*(randn(300,2)); %make a racket (noisy, get it?)
d_noisy = d + noise;
 
P = 0.99; %we want high probability
k = round(log(1-P)/log(1-0.33^2)+0.5); %each line makes up 33% of data set
threshold = 0.15; %arbitrary threshold
minlier=length(d_noisy)*0.2; %yeah, it's arbitrary
nlines = 2; %2 lines, brah
figures = 1;
[line, inliers] = ransac(d_noisy,k,threshold,minlier,nlines,figures); %let's do itt

figure %and plot our results
plot(d_noisy(:,1),d_noisy(:,2),'o'); %the data
hold on
ln = @(x) line(1,1).*x + line(1,2); %creating some lines
ln2 =@(x) line(2,1).*x + line(2,2);
fplot(ln, [-1.25 1.25],'r'); %which I then plot
fplot(ln2,[-1.25 1.25],'r');
xlim([-1.5 1.5]);
ylim([-1.5 1.5]); %and bound