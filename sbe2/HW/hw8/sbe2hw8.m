%SBE2 HW 8
%Greg Kiar
%08-04-2015

clear
close all
%% Part 1
s=0.2;k=1;b=0.5;sigma=3;beta=1;
rrange = -5+0.05:0.1:5-0.05;

p = @(r, ri, e) s .* max( (...
    (k.*e+b)+ exp(-(r-ri).^2./2./(sigma.^2))- beta ), ...
    0);

figure (1)
plot(-2:0.01:2, p(-2:0.01:2,rrange(50),-0.2))
hold on
plot(-2:0.01:2, p(-2:0.01:2,rrange(50), 0.0))
plot(-2:0.01:2, p(-2:0.01:2,rrange(50), 0.2))
legend('e=-0.2','e= 0.0','e= 0.2');
xlabel('Retinal stimulus position');
ylabel('Neuron response');
title('Response of PPC isolate neuron');

%% Part 2
ae=1;ai=0.65;sigi=2.5;sige=1;
r=0;e=0;

w = @(ri,rj) ae.*exp(-(ri-rj).^2./2./(sige.^2)) ...
    - ai.*exp(-(ri-rj).^2./2./(sigi.^2));

pt = @(t, r, ri, e, ps) s .* max( (...
    (k.*e+b)+ exp(-(r-ri).^2./2./(sigma.^2)) + ...
    sum(w(ri,rrange)'.*ps(:,t)) - beta ), ...
    0);

ps = p(r, rrange, e)';
figure (2)
for q=1:20
    for qq=1:100
        ps(qq,q+1) = pt(q,r,rrange(qq),e,ps)';
    end
end
plot(0:20, ps(50,:));
xlabel('Time point');
ylabel('Neuron response');
title('Neuron response of the central neuron in a network');

%% Part 3
r=-2:0.01:2;
e=-0.2:0.1:0.2;
lgs = {};

figure (3)

for w = 1:length(e)
    lgs{w} = strcat('e=', num2str(e(w)));

    for z = 1:length(r)
        ps = p(r(z), rrange, e(w))';
        for q=1:20
            for qq=1:100
                ps(qq,q+1) = pt(q,r(z),rrange(qq),e(w),ps)';
            end
        end
        prs(z) = ps(50, end);
    end
    prss(w,:) = prs();
end

plot(r, prss(3,:));
xlabel('Retinal stimulatus position');
ylabel('Neuron response');
title('Tuning function of neuron in a network');

%% Part 4

figure (4)
% for q = 1:length(e)
%     pre(q,:) = pt(20,r,rrange(50),e(q),ps);
%     plot(r, pre(q,:));
%     hold on
% end
for q = 1:length(e)
    plot(r, prss(q,:));
    hold on 
end

xlabel('Retinal stimulatus position');
ylabel('Neuron response');
title('Tuning function of neuron in a network');
legend(lgs)
