%
%
% WM_FORM_TS
%
% calculates the ANNUAL MEAN formation rate as a function of surface
% density sigma for the different TS pairs (OSTIA+SMOS, ARGO SST+ARGO SSS,
% WOA SST+WOA SSS).
% The ocean region ecc. can be set by
% assigning the appropriate strings to the variables below
%


function [gFrho_all] = wm_form_rho() 
cd C:\Users\Administrator\Documents\routines\smos_box\TSdiag
% clear all; 

sal = char('smosbin','argoNRT','woa09'); temp = char('ostia','argoNRT','woa09'); 
prec = 'cmorph'; ocean = 'NA'; tframe = 'jan12dec12'; fff = 1; month = 1:3;
season = 'OND'; ytickss = 1; xtickss = 1;

%% 0. parameters
cp = gsw_cp0;
p0 = 0;

% bins of surfce density sigma
ds = 0.1; sigma = (20:ds:28)+1000;
ndays = [31 28 31 30 31 30 31 31 30 31 30 31];
gFrho_all = nan(3,length(sigma));
lats = nan(500,81);
lons = nan(500,81);

for sss = 1:3 % loop over products
    %% 1.1 load data
    [SSS lat lon] = load_all_v2(strcat(sal(sss,:)),tframe,'SSS');
    SST = load_all_v2(strcat(temp(sss,:)),tframe,'SST');

    if ~strcmp(strcat(sal(sss,:)),'argoNRT')
        if strcmp(ocean,'NP') || strcmp(ocean,'EP') || strcmp(ocean,'SP') || strcmp(ocean,'TP') || strcmp(ocean,'SO')
            lon(lon<0)=lon(lon<0)+360;
        end
    end
    
    evap = load_all_v2('oaflux',tframe,'evap');
    precip = load_all_v2(prec,tframe);
    lheat = load_all_v2('nocs',tframe,'lheat');
    sheat = load_all_v2('nocs',tframe,'sheat');
    lwave = load_all_v2('nocs',tframe,'lwave');
    swave = load_all_v2('nocs',tframe,'swave');

    H = lheat + sheat + lwave + swave; % [W/m^2] and positive downward
    W = (evap - precip); % [mm/day] and positive upward
    W = W*1e-3/86400; % [m/s] 
    
    % same missing values
    nanmask = uni_nan_mask(0);
    H(isnan(nanmask)) = nan;
    W(isnan(nanmask)) = nan;
    SSS(isnan(nanmask)) = nan;
    SST(isnan(nanmask)) = nan;
       
    %% 2. TEOS10 equation of state

    if ~strcmp(strcat(sal(sss,:)),'woa09')
    [Lon Lat] = meshgrid(lon,lat); lon = Lon; lat = Lat; clear Lon Lat
    end
    [xx,yy] = deg2m(lon,lat);
    dxx = diff(xx,1,2); dxx(:,360) = dxx(:,359);
    dyy = diff(yy,1,1); dyy(180,:) = dyy(179,:);

    % conservative Temperature and absolute Salinity
    auxs = nan(size(SSS)); auxt = nan(size(SST));
    for m = 1:size(SSS,3)
        auxs(:,:,m) = gsw_SA_from_SP(squeeze(SSS(:,:,m)),0,lon,lat);
        auxt(:,:,m) = gsw_CT_from_t(squeeze(auxs(:,:,m)),squeeze(SST(:,:,m)),0);
    end
    SSS = auxs; SST = auxt; 

    % density
    rho = gsw_rho_CT(SSS,SST,0);

    % thermal and haline expansion coefficients
    alpha = nan(size(SSS)); beta = nan(size(SSS)); 
    for m = 1:size(SSS,3)
        alpha(:,:,m) = gsw_alpha(squeeze(SSS(:,:,m)),squeeze(SST(:,:,m)),p0);
        beta(:,:,m) = gsw_beta(squeeze(SSS(:,:,m)),squeeze(SST(:,:,m)),p0);
    end

    %% 3. select region

    [indx, indy, fullname] = basin_bounds(ocean);
    oalpha = squeeze(alpha(indy,indx,:));
    obeta = squeeze(beta(indy,indx,:));
    orho = squeeze(rho(indy,indx,:));
    oH = squeeze(H(indy,indx,:));
    oW = squeeze(W(indy,indx,:));
    oSSS = squeeze(SSS(indy,indx,:));
    oSST = squeeze(SST(indy,indx,:));
    oxx = squeeze(dxx(indy,indx));
    oyy = squeeze(dyy(indy,indx));
    
    if strcmp(ocean,'NAext')
        mask = zeros(size(oSSS));
        for i = 1:39
            mask(1:40-i,i,:) = nan;
        end
        oSSS(isnan(mask)) = nan;
        oSST(isnan(mask)) = nan;
    elseif strcmp(ocean,'NA2') 
        mask = zeros(size(oSSS)); ii = 0;
        for i = 16:45
            ii = ii+1;
            mask(1:30-ii,i,:) = nan;
        end
        oSSS(isnan(mask)) = nan;
        oSST(isnan(mask)) = nan;
    end


    %% 4. density flux

    F = -oalpha.*oH/cp  +  obeta.*orho.*oW.*oSSS./(1-oSSS*1e-3);

    Frho = nan(length(sigma),size(F,3));

    for m = month
        mrho = squeeze(orho(:,:,m));mF = squeeze(F(:,:,m));
        for t = 2:length(sigma)
            tind = find(mrho>sigma(t-1) & mrho<sigma(t));
            tmF = mF(tind);
            txx = oxx(tind); tyy = oyy(tind);
            if ~isempty(tind)
                stmF = tmF.*txx.*tyy;
                Frho(t,m) = nansum(stmF)*ndays(m)*86400;
%                                 h = figure (1);
%                 subplot(1,2,2)
%                 worldmap world
%                 load coast
%                 plotm(lat,long)
%                 hold on
                [lat, lon, ~] = colTSreg_v2(ocean);
                [i,j] = ind2sub([length(lat),length(lon)],tind);

%                 ser = plotm(lat(i),lon(j),'k.');
%                 title(['NO of observations = ',num2str(length(tind)),' Bin = ',num2str(t),' month = ',num2str(m)])
%                 xint = .1;
%                 subplot(3,2,[1 3])
%                 r = rectangle('position', [(sigma(t) - 1000) -20  .1 25]);
%                    subplot(3,2,5)
%                     c = rectangle('position', [(sigma(t) - 1000) 0 .1 400]);
%                 drawnow
%                 pause(0.5)
% 
% 
% 
%                 drawnow
% 
%                 frame = getframe (h);
%                 im{t,m} = frame2im(frame);
%                 delete (ser)                    
%                 delete(r)    
%                 delete (c)
                
                lats(1:length(lat(i)),t) = lat(i);
                lons(1:length(lon(j)),t) = lon(j);

            end
        end    
    end
    Frho = nansum(Frho,2); % sum over time
    Frho = Frho/(86400*(ndays(month(1))+ndays(month(2))+ndays(month(3)))); %annual average
    Frho = Frho/ds; %normalize by density bin size
    Frho = Frho*1e-6; % convert to sverdrup
    
    
    
    %% 5. formation: derivative by density
    %smooth before
    Frho_smooth = Frho;
    for s = 2:length(Frho)-1
        Frho_smooth(s) = mean(Frho(s-1:s+1));
    end
    % gradient
    gF = gradient(Frho_smooth,ds);
    gFrho_all(sss,:) = gF*0.1;
    
end


%% 4. Density flux as function of rho



[gFrho_all_error,n_stat] = wm_form_rho_error(sal,temp,tframe,ocean,prec,1000,p0,cp,sigma,ndays,ds,month);
gFrhomean1 = nan(1,81,n_stat);
gFrhomean1 = permute(gFrho_all_error,[2,3,1]);

mblu = [0 0.4 1]; 
dred = [0.8 0 0]; 
ora = [1 0.5 0]; 

gFrho_all_std=zeros(1,81);
gFrho_all_mean=gFrho_all_std;
for xe=1
    for ye=1:81
        gFrho_all_std(xe,ye)  = std(gFrho_all_error(:,xe,ye));
        gFrho_all_mean(xe,ye) = mean(gFrho_all_error(:,xe,ye));
%         Frho_all_mean(1:3,1:81) = Frho_all;
    end
end

x1 = sigma-1000;
y1 = gFrho_all(1,:);
e1 = gFrho_all_std(1,:);

% cla

% clf
figure(1)
subplot(1,2,2)

% for u = 1:n_stat
%     plot(sigma-1000,Frho_all1(1,:,u),'color',mblu,'linewidth',1.5)
    hold on;    
  
    plot(sigma-1000,gFrho_all(1,:),'color',mblu,'linewidth',1.5)
     (errorbar(x1,y1,e1,'color',mblu,'linewidth',0.5));
%     argo_data = nan(1,81);
%     idx = isnan(gFrho_all(2,:));
%     idx = find(idx==1);
%     diff_of_values = diff(idx);
%     idxx = find(diff_of_values > 1);
%     
%     argo_data1 = fliplr(gFrho_all(2,:));
%     argo_data1(isnan(argo_data1))=[];
%     argo_data(1,idxx+6:diff_of_values(idxx)+7) = argo_data1;
%     
    plot(sigma-1000,gFrho_all(2,:),'color',dred,'linewidth',1.5)
%     plot(sigma-1000,gFrho_all(3,:),'color',ora,'linewidth',1.5)
    
    plot(20:30,zeros(size(20:30)),'k-')
%     plot(ones(size(-10:10))*26.5,-10:10,'k-')
%     pbaspect([1.4 1 1])
    % set(gca,'position',[ 0.1339    0.1800    0.7711    0.8150])
%  l = legend('SMOS SSS, OSTIA SST','ARGO SSS, ARGO SST','WOA09 SSS, WOA09 SST','location',[0.855 0.392 0.076 0.24]);
    %set(l,'position',[0.0881    0.05    0.8649    0.0786])

     xlabel('SS\sigma [kgm^{-3}] ','fontsize',16)
%       ylabel('Formation [Sv]','fontsize',16)
       set(gca,'yticklabel',[])
%     set(gca,'fontsize',16)
%  title ([fullname,' - 2012'])
ylim([-8 9.5]); 
xlim([20 27])

% if xtickss == 0 && ytickss == 0
%      set(gca,'xticklabel',[])
%      set(gca,'yticklabel',[])
% elseif xtickss == 0
%      set(gca,'xticklabel',[])
% elseif ytickss == 0
%      set(gca,'yticklabel',[])
% end
%     set(gca,'ytick',-30:10:30,'xtick',20:2:28)
%     pause
%     drawnow
%     hold off
% end
box on


% [0.855 0.392 0.076 0.24]

eval(['print -dpng ./figures/WMtrans/formation/form_by_densclass_',ocean])
eval(['print -depsc -cmyk ./figures/WMtrans/formation/form_by_densclass_',ocean])


    
    
    
    
    
    
    
    