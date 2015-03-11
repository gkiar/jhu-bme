%  SBE2, Johns Hopkins University
%  Homework #5
%
%  Created by Greg Kiar on 10.03.2015 (c)

clc

%% q2
lambda = 100; %spikes per second
dt = 0.001;
T = 1;
figure (2)
clf

% a

k = 4;
for k=1:3
    p3 = @(tau) lambda.*(lambda.*tau).^k .* exp (-lambda .* tau )./factorial(k);
    F3 = @(tau) sum(p3(0:0.001:tau))*dt;
    
    ts = 0:dt:1-dt;
    for ii = 1:1000
        cdf3(ii) = F3(ii*dt);
    end
    % by mathematical theory, F3_inv = inf { x \in R : y \leq F(x) }
    F3_inv = @(u) find(cdf3 > u, 1, 'first')*dt;
    
    subplot(3,3,k);
    trains = zeros(100, 1000);
    for ii = 1:100
        t = 0;
        n = 1;
        while ( t < T )
            spikes{ii}(n) = t;
            u = rand();
            tau = F3_inv(u);
            t = tau+t;
            n = n+1;
        end
        scatter(spikes{ii}, ii*ones(1,length(spikes{ii})), 2, 'k');
        hold on
    end
    ylim([1 inf]); ylabel('presentation number');
    xlabel('Time (s)'); aa = sprintf('Spike trains for k=%d', k);title(aa);
    
    % b
    isis = [];
    for ii = 1:100
        temp = 0;
        for jj = 1:length(spikes{ii})-1
            temp(jj) = abs(spikes{ii}(jj) - spikes{ii}(jj+1));
        end
        isis = [isis, temp];
    end
    
    isih = zeros(1, 1000);
    subplot(3,3,k+3)
    for ii = 0:1000-0.001
        isih(ii+1) = sum(isis >= ii*0.001 & isis < (ii+1)*0.001);
    end
    isih = isih/sum(isih)/dt;
    stem(0:0.001:1-0.001,isih);
    ylabel('Count');
    xlabel('Time (s)'); title('ISI produced pdf');
    
    subplot(3,3,k+6)
    fplot(p3, [0 1]);
    xlim([0 1])
    set(findobj(gca, 'Type', 'Line'), 'LineWidth', 2);
    ylabel('Amplitude');
    xlabel('Time (s)'); title('Analytic pdf of modified Poisson dist.');
end
