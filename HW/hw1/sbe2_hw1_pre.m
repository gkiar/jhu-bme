function proba = sbe2_hw1_pre()
%% Header
% sbe2_hw1_pre.m
% Version 0.1, 02/04/2015
% Greg Kiar

%% Static parameters
T = 0.1e-3; %Duration of spike, in seconds
tau = 1; %Duration of click sequence, in seconds
fs = 40e3; %Sampling frequency, in hertz
dt = 1/fs;

%% Q1
% nseq=11;
% fo = logspace(log10(15),log10(80),nseq);
% ici = 1./fo;
%
% order = mod(randperm(nseq*10),nseq)+1;
% response = false(nseq*10,1);
% for jj=1:nseq*10
%     soundsc(make_sequence(ici(order(jj))), fs);
%     try
%         response(jj) = input('discrete(0) or continuous(1): ');
%     catch
%         response(jj) = 0; %if the person messes up put a zero
%     end
% end
%
% for kk=1:nseq %1a
%     proba(kk) = sum(response(find(order==kk)))/10;
% end
% response
% figure; stem(fo, proba);
% title('Pyschometric Function of Sound Perception');
% xlabel('Frequency of repitition fo ,Hz');
% ylabel('Probability of detecting continuous sound');
%
%
% interps = interp1(fo, proba, fo(1):0.1:fo(end));
% figure; stem(fo(1):0.1:fo(end), interps);
% title('Interpolated Pyschometric Function of Sound Perception');
% xlabel('Frequency of repitition fo ,Hz');
% ylabel('Probability of detecting continuous sound');

%% Q2

icis = [0.01, 0.03, 0.08];
for qq=2:length(icis)
    qq
    ici0= icis(qq);
    
    order = (mod(randperm(5*10),5)+1)*0.05;
    response = false(5*10,1);
    for jj=1:5*10
        jj
        ici=order(jj)*(rand(1,100)-0.5)*ici0 + ici0;
        soundsc(aperiodic_seq(ici), fs);
        try
            response(jj) = input('periodic(0) or aperiodic(1): ');
        catch
            response(jj) = 0; %if the person messes up put a zero
        end
    end
    
    for kk=1:5 %1a
        proba(kk) = sum(response(find(order==kk*0.05)))/10;
    end
    proba
    figure; stem((1:5)*0.05, proba);
    tits = sprintf('Pyschometric Function of Sound Periodicity with base ICI=%1.3f s', ici0);
    title(tits);
    xlabel('Jitter in signal, %');
    ylabel('Probability of detecting aperiodic sound');
    
    interps = interp1((1:5)*0.05, proba, 0.05:0.0001:0.25);
    figure; stem(0.05:0.0001:0.25, interps);
    tits = sprintf('Interpolated Pyschometric Function of Sound Periodicity with base ICI=%1.3f s', ici0);
    title(tits);
    xlabel('Jitter in signal, %');
    ylabel('Probability of detecting aperiodic sound');
end

%%Q3

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

%% Functions
    function seque = make_sequence(ici)
        seque = zeros(fs*tau, 2);
        for ii=0:ici:tau-dt
            seque(ceil(ii/dt+1):ceil((ii+T)/dt),:)=1;
        end
        seque = seque(1:fs*tau,:);
    end

    function seque = aperiodic_seq(icic)
        seque = zeros(fs*tau, 2);
        s = 1;
        for ii=1:length(icic)
            seque(s:s+ceil(T/dt),:)=1;
            s = s + ceil(icic(ii)/dt);
        end
        seque = seque(1:fs*tau,:);
    end
end