N = 10000;
figure (1)
clf
for i=1:8
    for j=1:8
        for n=1:N
            a = randn*(i*10);
            b = randn*(i*10) + (j*10);
            da(i,j,n) = b <= a;
        end
        leg{j} = strcat('sigma = ', num2str(j*10), ' msec');
        avg(j) = sum(da(i,j,:))/N;
    end
    plot(1:8, avg)
    hold on
end
legend(leg); ylabel('Probability of detecting sound /da/'); xlabel('Voice Onset Time (VOT) (ms)')
title('Probability of detecting the sound /da/ based on VOT');


figure (2)
clf
for i=1:8
    Z = i * 10;
    for j=1:8
        for n=1:N
            b = randn*(10) + (j*10);
            da2(i,j,n) = b <= Z;
        end
        leg{j} = strcat('Z = ', num2str(j*10), ' msec');
        avg(j) = sum(da2(i,j,:))/N;
    end
    plot(1:8, avg)
    hold on
end
legend(leg); ylabel('Probability of detecting sound /da/'); xlabel('Voice Onset Time (VOT) (ms)')
title('Probability of detecting the sound /da/ based on VOT');