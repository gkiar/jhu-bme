cta = linspace(7.5,12.5,100);
ctb = linspace(10,14,100);

n=1;
for beta=6:0.1:15
    pd(n) = sum(ctb>beta)/length(ctb);
    pfa(n) = sum(cta>beta)/length(cta);
    n=n+1;
end

figure, plot(pfa, pd)
title('ROC Curve for deterministic detection criterion');
xlabel('P_F_A (probability of mistaking A as B)');
ylabel('P_D (probability of properly observing B)');