% function power_spectral_density(dataset)
    % Author: Mariana Lage
    % Universidade de São Paulo, set/2018
    % dataset format (longitude, time)
     rt=10;
    t=1:12;
     t=t*rt;

    lt=length(t);
    npf=100;
    inxs=(npf-1)/2;
    nrep=3000;
    nfft=round(lt/nrep);
    fyb=zeros(nfft/2,nrep);
    myfilter=blackman(npf);
    myfilter=myfilter/sum(myfilter);
    w_an=2*pi/365;
    w_semi=2*pi/183;

    %%%%%%%%%%%%%%%%%%%%%%%
    %  Without filtering  %
    %%%%%%%%%%%%%%%%%%%%%%%

    % ASM
    nx=360; nt=12;
    for i=1:nx
         fz=fft(sss_50lat_fft(:,i)); %tranf de fourier
         Am_fz=2*fz.*conj(fz)/(nt.^2); %amplitude * conj
         Amb_fz(1:11,i)=Am_fz((length(Am_fz)/18)+1:length(Am_fz)); %metade da amplitude pq Ã© simetrica
    end
    for tt=1:11
    m(tt)=mean(Amb_fz(tt,:));
    end
    for tt=1:11
    sf(tt)=std(Amb_fz(tt,:));
    end
    med_N_sfiltro=fliplr(m); sig_N_sfiltro=fliplr(sf);
    smf4=med_N_sfiltro+1*sig_N_sfiltro; smf5=med_N_sfiltro+2*sig_N_sfiltro; smf6=med_N_sfiltro+3*sig_N_sfiltro;
%     clear m sf tt y nx nt ys fz Am_fz Amb_fz

    %----------------------------------------------------
    %Figs 1 e 2: eta, com e sem filtro
    freq = 1:11;
    figure(2)
    %portrait
    subplot(2,1,1),loglog(freq,med_N_sfiltro,'b',[w_an w_an],[1e-1 1e4],'--k', [w_semi w_semi], [1e-1 1e4], '--g');
    grid on;
    set(gca,'xtick');%,linspace(1e-2,4e-2,10))
    ylabel('Potencia')
    xlabel('Frequencia')
    title(['Densidade de Potencia Espectral (sem aplicacao de filtro), Altura' ])
    %axis([1e-2 4e-2 1e-2 3])
    %axis('tight')
    legend('Espectro','freq anual', 'freq semi-anual');%axis([1e-2 4e-2 1e-2 3])
    g=findobj(gcf,'type','axes');
    ht=findobj(g,'type','text');
    set(ht,'fontname','Times','fontsize',12,'fontweight','bold');
    set(g,'fontname','Times','fontsize',12,'fontweight','bold');

    subplot(2,1,2),loglog(freq,med_N_sfiltro,'b',freq,smf4,'g',freq,smf5,'m',freq,smf6,'r');
    grid on;
    set(gca,'xtick');%,linspace(1e-2,4e-2,10))
    ylabel('Potencia')
    xlabel('Frequencia')
    legend('Espectro','68%','95%','99.7%')
    %axis('tight')
    g=findobj(gcf,'type','axes');
    ht=findobj(g,'type','text');
    set(ht,'fontname','Times','fontsize',12,'fontweight','bold');
    set(g,'fontname','Times','fontsize',12,'fontweight','bold');
