clear
close all

d = [0:2/99:2; 0:2/99:2]; % y = x
d =d';

a= rand(100,2)*2; % even noise
d= [d;a]; %put them together
d= d-1;
noise = (0.1/sqrt(2)).*(randn(200,2)); %noise it alllll up
d_noisy = d + noise;

P = 0.99; %we want high probability
k = round(log(1-P)/log(1-0.5^2)+0.5); %using the k formula from class
threshold = 0.2; %kind of abritrary
minlier=length(d_noisy)*0.2; %same, kind of arbitrary
nlines = 1;
figures =1;
[line, inliers] = ransac(d_noisy,k,threshold,minlier,nlines,figures); %let's do it

figure
plot(d_noisy(:,1),d_noisy(:,2),'o'); % aaaand let's plot dis punk
hold on
ln = @(x) line(1).*x + line(2); %plot my found line tooo
fplot(ln, [-1.25 1.25],'r');
xlim([-1.5 1.5]);
ylim([-1.5 1.5]); %and let's frame it all nice n good.