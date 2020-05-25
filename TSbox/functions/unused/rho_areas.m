function rho_areas(vare,sigma,tframe,month,n_stat,fign,SSS,SST,SSS_unc,SST_unc,H_unc,...
    W_unc,dxx,dyy,lon,lat,latitude,longitude,ocean)
% rho_areas                          Calculates and plots areas of each
%                                                                   density class
%============================================================
%
% USAGE:
% rho_areas(rho_e,sigma,dxx,dyy,SSS,SST,n_stat,SSS_unc,SST_unc,H_unc,...
%     W_unc)
%                                                   *All variables set
%                                                   through Control_Center
%
% DESCRIPTION:
% Function calculates the areas each density occupies within the basin
% choosen and compares with reference
%
% INPUT:
% vare = datasett for all monte-carlo simulations [ matrix ]
% sigma = density sampling range [ vector ]
% tframe = year [string ]
% month = month [ number ]
% n_stat = number of statistically random points for monte-carlo [ number ]
% fign = figure number to be plotted on [ number ]
% [SSS,SST] = refence salinity and temp fields [ matrix ]
% [SSS_unc,SST_unc,H_unc] = variable uncertainty [ number ]
% [dxx,dyy] = distances lat-lon for basin chosen [ matrix ]
% [lon,lat] = lat-lon of basin [ matrix ]
%
% OUTPUT:
%
% AUTHOR:
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1 (Tuesday 11th February 2020) *******STARTING FRESH COUNT
% NOTES on VERSION:
% None
%
% REFERENCES:
%
% The software is currently in development
%
%============================================================


SSS = gsw_SA_from_SP(SSS,0,lon,lat);
SST = gsw_CT_from_t(SSS,SST,0);
[rho,~,~] = gsw_rho_alpha_beta(SSS,SST,0);

Area_rho_t = zeros(1,length(sigma));
Area_rho_e = zeros(1,length(sigma),n_stat);
num_points_t = zeros(1,length(sigma));
num_points_e = zeros(1,length(sigma),n_stat);

for t = 2:length(sigma)    
    num_points = rho(:,:) > sigma(t-1) & rho(:,:) < sigma(t);
    num_points_t(1,t)=sum(num_points(:));      
        for n = 1:n_stat
            num_points = vare(:,:,n) > sigma(t-1) & vare(:,:,n) < sigma(t);
            num_points_e(1,t,n)=sum(num_points(:));
        end
end
                    
for i = 1:size(rho,1)
    for j = 1:size(rho,2)
        for t = 2:length(sigma)                
            if rho(i,j) > sigma(t-1) && rho(i,j) < sigma(t)
                Area_rho_t(1,t) = Area_rho_t(1,t)+(dxx(i,j)*dyy(i,j));
            end
            for n = 1:n_stat
                if vare(i,j,n) > sigma(t-1) && vare(i,j,n) < sigma(t)
                    Area_rho_e(1,t,n) = Area_rho_e(1,t,n)+(dxx(i,j)*dyy(i,j));

                end
            end
        end
    end
end

figure(fign)
clf
plot(sigma-1000,Area_rho_t./1e6,'r-')
hold on
errorbar(sigma-1000,nanmean(Area_rho_e,3)./1e6,nanstd(Area_rho_e,3)./1e6,'k-')
plot(sigma-1000,nanmean(Area_rho_e,3)./1e6,'k-')
legend('Reference','Mean [1%]','Mean [2%]','Mean [5%]','Mean [7%]')
title({['month = ',num2str(month),' - year = 20',[tframe(end-1),tframe(end)]],...
    ['Mean of ',num2str(n_stat),' simulations'],...
    ['Uncertainties: SSS = ',num2str(SSS_unc),'[%] - ',...
    'SST = ',num2str(SST_unc),'[%] - ',...
    'H = ',num2str(H_unc),'[%] - ',...
    'W = ',num2str(W_unc),'[%]'],...
    ['Total Area = ',num2str(sum(Area_rho_t)/1e6)]},'fontsize',14)
xlabel('Density [kgm^-^3]','FontSize',14)
ylabel('area [km^{2}]','FontSize',14)
ylim([-1 9.5e5])

figure(fign+1)
clf
plot(sigma-1000,num_points_t,'r-')
hold on
errorbar(sigma-1000,nanmean(num_points_e,3),nanstd(num_points_e,3),'k-')
plot(sigma-1000,nanmean(num_points_e,3),'k-')
legend('Reference','Errorbars','Mean')
title({['month = ',num2str(month),' - year = 20',[tframe(end-1),tframe(end)]],...
    ['Mean of ',num2str(n_stat),' simulations'],...
    ['Uncertainties: SSS = ',num2str(SSS_unc),'[%] - ',...
    'SST = ',num2str(SST_unc),'[%] - ',...
    'H = ',num2str(H_unc),'[%] - ',...
    'W = ',num2str(W_unc),'[%]']},'fontsize',14)
xlabel('Density [kgm^-^3]','FontSize',14)
ylabel('# of points','FontSize',14)
ylim([0 100])

figure(fign+2)
clf
set(gcf,'Color','w')
map_basin(latitude,longitude,ocean,lat,lon,vare(:,:,month)')
set(gcf,'Colormap',jet)
c = colorbar('Location','eastoutside','FontSize',18);
set(get(c,'ylabel'),'string',...
		'\rho [kgm^{-3}]','fontsize',18)
title({['month = ',num2str(month),' year = 20',[tframe(end-1),tframe(end)]],...
    ['Uncertainties: SSS = ',num2str(SSS_unc),'[%] - ',...
    'SST = ',num2str(SST_unc),'[%] - ',...
    'H = ',num2str(H_unc),'[%] - ',...
    'W = ',num2str(W_unc),'[%]']},'fontsize',14)
caxis([1020 1028])

% 	figure(fign+3)
% clf
% set(gcf,'Color','w')
% map_basin(latitude,longitude,ocean,lat,lon,vare(:,:,month)')
% set(gcf,'Colormap',jet)
% c = colorbar('Location','eastoutside','FontSize',18);
% set(get(c,'ylabel'),'string',...
% 		'\rho [kgm^{-3}]','fontsize',18)
% title({['month = ',num2str(month),' year = 20',[tframe(end-1),tframe(end)]],...
%     ['Uncertainties: SSS = ',num2str(SSS_unc),'[%] - ',...
%     'SST = ',num2str(SST_unc),'[%] - ',...
%     'H = ',num2str(H_unc),'[%] - ',...
%     'W = ',num2str(W_unc),'[%]']},'fontsize',14)
% caxis([1020 1022])

% 	figure(fign+4)
% clf
% set(gcf,'Color','w')
% map_basin(latitude,longitude,ocean,lat,lon,vare(:,:,month)')
% set(gcf,'Colormap',jet)
% c = colorbar('Location','eastoutside','FontSize',18);
% set(get(c,'ylabel'),'string',...
% 		'\rho [kgm^{-3}]','fontsize',18)
% title({['month = ',num2str(month),' year = 20',[tframe(end-1),tframe(end)]],...
%     ['Uncertainties: SSS = ',num2str(SSS_unc),'[%] - ',...
%     'SST = ',num2str(SST_unc),'[%] - ',...
%     'H = ',num2str(H_unc),'[%] - ',...
%     'W = ',num2str(W_unc),'[%]']},'fontsize',14)
% caxis([1022 1024])
% 
% 	figure(fign+5)
% clf
% set(gcf,'Color','w')
% map_basin(latitude,longitude,ocean,lat,lon,vare(:,:,month)')
% set(gcf,'Colormap',jet)
% c = colorbar('Location','eastoutside','FontSize',18);
% set(get(c,'ylabel'),'string',...
% 		'\rho [kgm^{-3}]','fontsize',18)
% title({['month = ',num2str(month),' year = 20',[tframe(end-1),tframe(end)]],...
%     ['Uncertainties: SSS = ',num2str(SSS_unc),'[%] - ',...
%     'SST = ',num2str(SST_unc),'[%] - ',...
%     'H = ',num2str(H_unc),'[%] - ',...
%     'W = ',num2str(W_unc),'[%]']},'fontsize',14)
% caxis([1024 1026])
% 
% 	figure(fign+6)
% clf
% set(gcf,'Color','w')
% map_basin(latitude,longitude,ocean,lat,lon,vare(:,:,month)')
% set(gcf,'Colormap',jet)
% c = colorbar('Location','eastoutside','FontSize',18);
% set(get(c,'ylabel'),'string',...
% 		'\rho [kgm^{-3}]','fontsize',18)
% title({['month = ',num2str(month),' year = 20',[tframe(end-1),tframe(end)]],...
%     ['Uncertainties: SSS = ',num2str(SSS_unc),'[%] - ',...
%     'SST = ',num2str(SST_unc),'[%] - ',...
%     'H = ',num2str(H_unc),'[%] - ',...
%     'W = ',num2str(W_unc),'[%]']},'fontsize',14)
% caxis([1026 1028])
% 
% 

end
