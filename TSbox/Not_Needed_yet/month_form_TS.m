function month_form_TS (Fscatt,S,T,sal,temp,dS,dT,ca,title_xx,fullname,tframe,ocean,hflux,radflux,evap,precip,n_stat,oSSS,oSST)
%% comments



if strcmp(sal,'smosOI')
    longsss = 'SMOS OI';
elseif strcmp(sal,'smosbin')
    longsss = 'SMOS (binned)';    
elseif strcmp(sal,'aqOI')
    longsss = 'Aquarius OI';
elseif strcmp(sal,'argoNRT')
    longsss = 'Argo NRT';
elseif strcmp(sal,'woa09')
    longsss = 'WOA 09';
end
if strcmp(temp,'ostia')
    longsst = 'OSTIA';
elseif strcmp(temp,'argoNRT')
    longsst = 'Argo ISAS';
elseif strcmp(temp,'woa09')
    longsst = 'WOA 09';
elseif strcmp(temp,'ICOADS')
    longsst = 'ICOADS';
elseif strcmp(temp,'AVHRR')
    longsst = 'NOAA OI';
elseif strcmp(temp,'COBE')
    longsst = 'COBE OI';
end


fignum = 1;
choice = 4;

NASTMW_S = 36.5;
NPSTMW_S = 34.85;
SASTMW_S = 35.7;
SPSTMW_S = 35.5;
IOSTMW_S = 35.51;
SOSTMW_S = 35;

NASTMW_T = 18;
NPSTMW_T = 16.5;
SASTMW_T = 15;
SPSTMW_T = 17;
IOSTMW_T = 16.54;
SOSTMW_T = 9.5;



for m = 7
    

    Fscatt1 = Fscatt(:,:,m); %picking first month values
    Fscatt1 = Fscatt1./(365*86400); %annual average
    Fscatt1 = Fscatt1./0.1./0.5; %devide by binsizes
    Fscatt1 = Fscatt1.*1e-6; % convert to sverdrup
    
%% 5. water mass formation

% if n_stat == 1
    Fscatt_smooth = boxfilter(Fscatt1); 
% elseif n_stat > 1
%           Fscatt_smooth = Fscatt; % without smoothing
% 
% end

    % b) T/S gradient of transformation
    [ss, tt] = meshgrid(S,T);
    [gsFscatt, gtFscatt] = grad(ss,tt,Fscatt_smooth);
    gFscatt = complex(dS.*gsFscatt,dT.*gtFscatt);
    % c) T/S gradient of rho
    tsrho = gsw_rho_CT(ss,tt,0);
    [gsrho, gtrho] = grad(ss,tt,tsrho);
    grho = complex(gsrho,gtrho);
    % d) formation
%     formation1 = -1.*(real(gFscatt)).*(imag(grho)./abs(grho)); %changed
    formation1 = -1*(real(gFscatt).*real(grho)+imag(gFscatt).*imag(grho))...
        ./abs(grho);    
    
    

    hold off
    
    h = figure (1);
    set(h,'units','normalized','outerposition',[0 0 1 1])
    p = pcolor(S,T,formation1); set(p,'edgecolor','none'); box on     
    cm = anom_cmap_white(ca); colormap(cm);
    cb = colorbar;
    
    hold on
    
    pos = [0.85 0.2 0.03 0.6];
    set(cb,'position',pos); set(gca,'fontsize',14)
    set(get(cb,'ylabel'),'string','Formation [Sv]','fontsize',18)
    trange = -5:0.5:37;
    srange = 20:0.2:40;
    rho_contours(trange,srange); caxis(ca);
    set(gca,'fontsize',18)
    xlabel([longsss,' SSS [g/kg]'],'fontsize',18)
    ylabel([longsst,' SST [^{\circ}C]'],'fontsize',18)
    title([title_xx,fullname, ' month = ',num2str(m)],'fontsize',18)
    xlim([27 39]); ylim([0 35]); axis square
    set(gca,'xtick',27:3:39)
    
    if strcmp(ocean,'NA2')
        plot(ones(size(-100.6:100))*NASTMW_S,-100.6:100,'g-', 'linewidth', 1)
        plot(-100.6:100,ones(size(-100.6:100))*NASTMW_T, 'g-','linewidth', 1)
        plot(NASTMW_S,NASTMW_T,'go','MarkerSize',5)
        text(NASTMW_S-1,NASTMW_T+1,'18\circ water mass')
    elseif strcmp(ocean,'NP')
        plot(ones(size(-100.6:100))*NPSTMW_S,-100.6:100,'g-', 'linewidth', 1)
        plot(-100.6:100,ones(size(-100.6:100))*NPSTMW_T, 'g-','linewidth', 1)
        plot(NPSTMW_S,NPSTMW_T,'go','MarkerSize',5)
        text(NPSTMW_S-1,NPSTMW_T+1,'NPSTMW')
    elseif strcmp(ocean,'SA')
        plot(ones(size(-100.6:100))*SASTMW_S,-100.6:100,'g-', 'linewidth', 1)
        plot(-100.6:100,ones(size(-100.6:100))*SASTMW_T, 'g-','linewidth', 1)
        plot(SASTMW_S,SASTMW_T,'go','MarkerSize',5)
        text(SASTMW_S-1,SASTMW_T+1,'SASTMW')
    elseif strcmp(ocean,'SP')
        plot(ones(size(-100.6:100))*SPSTMW_S,-100.6:100,'g-', 'linewidth', 1)
        plot(-100.6:100,ones(size(-100.6:100))*SPSTMW_T, 'g-','linewidth', 1)
        plot(SPSTMW_S,SPSTMW_T,'go','MarkerSize',5)
        text(SPSTMW_S-1,SPSTMW_T+1,'SPSTMW')
    elseif strcmp(ocean,'IO')
        plot(ones(size(-100.6:100))*IOSTMW_S,-100.6:100,'g-', 'linewidth', 1)
        plot(-100.6:100,ones(size(-100.6:100))*IOSTMW_T, 'g-','linewidth', 1)
        plot(IOSTMW_S,IOSTMW_T,'go','MarkerSize',5)
        text(IOSTMW_S-1,IOSTMW_T+1,'IOSTMW')    
    elseif strcmp(ocean,'SO')
        plot(ones(size(-100.6:100))*SOSTMW_S,-100.6:100,'g-', 'linewidth', 1)
        plot(-100.6:100,ones(size(-100.6:100))*SOSTMW_T, 'g-','linewidth', 1)
        plot(SOSTMW_S,SOSTMW_T,'go','MarkerSize',5)
        text(SOSTMW_S-1,SOSTMW_T+1,'SAMW') 
    end
    

    
    
    [peaks,h,regions] = peaklocs (fignum,choice,ocean,m);
    [Theta_S_pos1, Theta_S_pos2, Theta_T_pos1, Theta_T_pos2] = rec_peak_data (peaks,h,regions);
    
     thetaS1=min(Theta_S_pos1,Theta_S_pos2);
     thetaS2=max(Theta_S_pos1,Theta_S_pos2);
     thetaT1=min(Theta_T_pos1,Theta_T_pos2);
     thetaT2=max(Theta_T_pos1,Theta_T_pos2);

     thetaS = [thetaS1 thetaS2];
     thetaT = [thetaT1 thetaT2];

     Fpeak = month_function1(m,oSST,oSSS,[],S,T,[],[],[],[],[],thetaS,thetaT,formation1,[]);
     Fpeak = permute(Fpeak,[2,3,1]);
    
    if strcmp(tframe,'aug11dec11')
        months = char('August 2011','September 2011','October 2011','November 2011',...
            'December 2011'); mo = 'aug11sep11oct11nov11dec11';
    elseif strcmp(tframe,'jan11dec11')
        months = char('January 2011','February 2011','March 2011','April 2011',...
            'May 2011','June 2011','July 2011','August 2011','September 2011',...
        'October 2011','November 2011','December 2011');
        mo = 'jan11feb11mar11apr11may11jun11jul11aug11sep11oct11nov11dec11';
    elseif strcmp(tframe,'jan12dec12')
        months = char('January 2012','February 2012','March 2012','April 2012',...
            'May 2012','June 2012','July 2012','August 2012','September 2012',...
            'October 2012','November 2012','December 2012');
        mo = 'jan12feb12mar12apr12may12jun12jul12aug12sep12oct12nov12dec12';
    elseif strcmp(tframe,'jan13dec13')
        months = char('January 2013','February 2013','March 2013','April 2013',...
            'May 2013','June 2013','July 2013','August 2013','September 2013',...
            'October 2013','November 2013','December 2013');
        mo = 'jan13feb13mar13apr13may13jun13jul13aug13sep13oct13nov13dec13';
    elseif strcmp(tframe,'jan14dec14')
         months = char('January 2014','February 2014','March 2014','April 2014',...
                'May 2014','June 2014','July 2014','August 2014','September 2014',...
                'October 2014','November 2014','December 2014');
         mo = 'jan14feb14mar14apr14may14jun14jul14aug14sep14oct14nov14dec14';
    end
    
    [latitude,longitude,~] = colTSreg_v2(ocean);
    figure (2)
    
    hold off
    long=0;
    
    set(gcf,'OuterPosition',[1913 -7 1936 1096])
    load lat
    load long
    
    if strcmp(ocean,'NP') || strcmp(ocean,'SO') || strcmp(ocean,'SP') || strcmp(ocean,'TP')...
            || strcmp(ocean,'IO') ... %% added luigi castaldo || strcmp(ocean,'IO')%
            || strcmp(ocean,'EP')
        long(long<0) = long(long<0) + 360;
        long(long>359.5 | long < 0.5) = nan;
    elseif strcmp(ocean,'SA')
        Fpeak = [Fpeak(:,31:end,:) Fpeak(:,1:30,:)];
    elseif strcmp(ocean,'NA2')
        Fpeak = [Fpeak(:,16:end,:) Fpeak(:,1:15,:)];
    elseif strcmp(ocean,'all')
        Fpeak = [Fpeak(:,181:end,:) Fpeak(:,1:180,:)];
        longitude = -179.5:179.5;
    end
    
    aplt = nan(size(Fpeak)+1);
    aplt(1:end-1,1:end-1) = Fpeak;
    aplt(aplt == 0) = NaN;
    aplt=aplt(1:end-1,1:end-1);

    pcolor(longitude,latitude,aplt);
    
    shading flat
    
    cb = latlonlabel(ocean,1);
    if strcmp(ocean,'all')
        set(gca,'xtick',-150:50:150,'xticklabel',{'150W','100W',...
            '50W','0','50E','100E','150E'})
    end

    cm = anom_cmap_white(ca); colormap(cm);
    
    hold on; plot(long,lat,'k','linewidth',1.5); caxis ([ca(1) ca(2)])
    set(gca,'position',[0.1200    0.1100    0.7750    0.7567])
    
    title({[title_xx,longsss,' SSS and ',longsst,' SST']; ['month = ', num2str(m)]},...
    'fontsize',15)

    text(-77,-6,[num2str(round(thetaS(1),1)),' to ',...
        num2str(round(thetaS(2),1)),' g/kg'],'fontsize',14)

    text(-77,-2,[num2str(round(thetaT(1),1)),....
        ' to ',num2str(round(thetaT(2),1)),' ^{\circ}C'],'fontsize',14)
    
    set(get(cb,'ylabel'),'string','Formation [Sv]','fontsize',15)
    
    
    set(gca,'color',[0.8 0.8 0.8]);
    set(gcf,'color',[1 1 1])
    set(gcf, 'InvertHardCopy', 'off');
    grid on; set(gca,'layer','top')
    save_flag_ss=true;
    if save_flag_ss==true
        mkdir(['monthly_form_maps_separate/',ocean,'/',tframe,'/month = ',num2str(m),title_xx,'/',sal,'/',temp,'/',precip,'/',evap,'/',hflux,'/',radflux,'/','MC = ',num2str(n_stat)])
        cd (['monthly_form_maps_separate/',ocean,'/',tframe,'/month = ',num2str(m),title_xx,'/',sal,'/',temp,'/',precip,'/',evap,'/',hflux,'/',radflux,'/','MC = ',num2str(n_stat)])
        print ('-dpng', '-r300', ['month ',num2str(m),'.png'])
        cd C:\Users\Administrator\Documents\routines\smos_box\TSdiag
        % eval(['print -depsc -cmyk ./figures/WMtrans/formation/annual_mean/eps/',title_yy,'form_TS_',sal,'_',temp,'2011_',ocean])
        %     saveas(hh4,strcat('./figures/WMtrans/formation/annual_mean/fig/','colormap',title_yy,'form_TS_',sal,'_',temp,'2011_',ocean),'fig')
    end    
    
    
    figure(1)

    drawnow
%     pause (0.05)
    save_flag_ss=true;
    if save_flag_ss==true
        mkdir(['monthly_form/',ocean,'/',tframe,'/month = ',num2str(m),title_xx,'/',sal,'/',temp,'/',precip,'/',evap,'/',hflux,'/',radflux,'/','MC = ',num2str(n_stat)])
        cd (['monthly_form/',ocean,'/',tframe,'/month = ',num2str(m),title_xx,'/',sal,'/',temp,'/',precip,'/',evap,'/',hflux,'/',radflux,'/','MC = ',num2str(n_stat)])
        print ('-dpng', '-r300', ['month ',num2str(m),'.png'])
        cd C:\Users\Administrator\Documents\routines\smos_box\TSdiag
        % eval(['print -depsc -cmyk ./figures/WMtrans/formation/annual_mean/eps/',title_yy,'form_TS_',sal,'_',temp,'2011_',ocean])
        %     saveas(hh4,strcat('./figures/WMtrans/formation/annual_mean/fig/','colormap',title_yy,'form_TS_',sal,'_',temp,'2011_',ocean),'fig')
    end

%  pause   
end










