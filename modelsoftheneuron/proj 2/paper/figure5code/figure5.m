% this is all done after saving singular values from ablationtesting.m
vals= {s_avb, s_avbl, s_avbr, s_avar, s_aval, s_avar};
tits= {'AVB Ablation', 'AVBL Ablation', 'AVBR Ablation', ...
    'AVA Ablation', 'AVAL Ablation', 'AVAR Ablation'};
figure
for ii=1:length(vals)
    subplot(2,3,ii);
    plot(1:6,vals{ii}, 'k.', 'markersize', 20);
    grid on
    xlim([0 4]);
    title(tits{ii})
end