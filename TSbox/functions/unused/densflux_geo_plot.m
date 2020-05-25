function densflux_geo_plot(vare,longitude,latitude,lat,lon,SSS_unc,SST_unc,H_unc,W_unc,name,...
    name_unit,units,fign,ocean,month,tframe,n_stat,randnumgen,seed)
% densflux_plot                             Plots maps of density flux with 
%                                                                               pre-defined parameters          [ kg/m2s ]
%============================================================
% 
% USAGE:  
% densflux_plot(densflux_data,season,~,~,latitude,longitude)
%                                                   *All variables set
%                                                   through Control_Center
% 
%  Note that densflux_plot has all variables pre set through
%  choices in Control_Center.
%
% DESCRIPTION:
%  **As of 14/10/2019 
% Function draws maps of density flux
% from pre-selected datasets.
%
% INPUT:
%  densflux_data = Density flux data        [ 3-D matrix ]
%  season = User selected season        [ number ]
%  fullname = full name of basin selected   [ string ]
%  [latitude, longitude] = latitude and longitude of ROI       [ vector ]
%  month = current month        [ number ]
%  sal = name of salinity dataset       [ string ]
%  tframe = year chosen     [ number ]
% 
% OUTPUT:
% None
% 
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1.1 (Monday 14th October 2019) *******STARTING FRESH COUNT
%
% REFERENCES:
% For calculation of density flux           [ Speer and Tzipermann 1992 ]   
%
% The software is currently in development
%
%============================================================
var = load('/home/ap/ESA/smos_box/TSdiag/Variables/1_degree/jan13dec13/Jan/All_variables.mat',...
    'Fmean');
var = var.Fmean;
vare = permute(vare,[2,3,1]);

vare_mc_mean = nanmean(vare,3);
vare_mc_std = nanstd(vare,3);
vare_mc_skewness = skewness(vare,0,3);
vare_diff_H_mean = var(:,:) - vare_mc_mean(:,:);

% Mean
figure(fign)
clf
set(gcf,'Color','w')
map_basin(latitude,longitude,ocean,lat,lon,vare_mc_mean')
set(gcf,'Colormap',jet)
c = colorbar('Location','eastoutside','FontSize',18);
set(get(c,'ylabel'),'string',...
                name_unit,'fontsize',18)
title({['month = ',num2str(month),' year = 20',[tframe(end-1),tframe(end)]],...
    ['Mean of ',num2str(n_stat),' simulations'],...
    ['Uncertainties: SSS = ',num2str(SSS_unc),'[PSU] - ',...
    'SST = ',num2str(SST_unc),'[\circC] - ',...
    'H = ',num2str(H_unc),'[WM^{-2}] - ',...
    'W = ',num2str(W_unc),'[ms^{-1}]']})
caxis([-1e-5 2e-5])

%standard deviation
figure(fign+1)
clf
set(gcf,'Color','w')
map_basin(latitude,longitude,ocean,lat,lon,vare_mc_std')
set(gcf,'Colormap',jet)
c = colorbar('Location','eastoutside','FontSize',18);
set(get(c,'ylabel'),'string',...
                name_unit,'fontsize',18)
title({['month = ',num2str(month),' year = 20',[tframe(end-1),tframe(end)]],...
    ['STD of ',num2str(n_stat),' simulations'],...
    ['Uncertainties: SSS = ',num2str(SSS_unc),'[PSU] - ',...
    'SST = ',num2str(SST_unc),'[\circC] - ',...
    'H = ',num2str(H_unc),'[WM^{-2}] - ',...
    'W = ',num2str(W_unc),'[ms^{-1}]']})
if SSS_unc ~= 0
    caxis([0 5e-8])
elseif SST_unc ~=0
    caxis([0 5e-8])
elseif H_unc ~= 0
    caxis([0 250e-8])
elseif W_unc ~= 0
    caxis([0 0.4e-4])
end

%skewness
figure(fign+2)
clf
set(gcf,'Color','w')
map_basin(latitude,longitude,ocean,lat,lon,vare_mc_skewness')
set(gcf,'Colormap',jet)
c = colorbar('Location','eastoutside','FontSize',18);
set(get(c,'ylabel'),'string',...
                'Skewness','fontsize',18)
title({['month = ',num2str(month),' year = 20',[tframe(end-1),tframe(end)]],...
    ['Skewness of ',num2str(n_stat),' simulations'],...
    ['Uncertainties: SSS = ',num2str(SSS_unc),'[PSU] - ',...
    'SST = ',num2str(SST_unc),'[\circC] - ',...
    'H = ',num2str(H_unc),'[WM^{-2}] - ',...
    'W = ',num2str(W_unc),'[ms^{-1}]']})
caxis([-1 1])

%difference from mean
figure(fign+3)
clf
set(gcf,'Color','w')
map_basin(latitude,longitude,ocean,lat,lon,vare_diff_H_mean')
set(gcf,'Colormap',jet)
c = colorbar('Location','eastoutside','FontSize',18);
set(get(c,'ylabel'),'string',...
                name_unit,'fontsize',18)
title({['month = ',num2str(month),' year = 20',[tframe(end-1),tframe(end)]],...
    ['\DeltaReference-Mean of ',num2str(n_stat),' simulations'],...
    ['Uncertainties: SSS = ',num2str(SSS_unc),'[PSU] - ',...
    'SST = ',num2str(SST_unc),'[\circC] - ',...
    'H = ',num2str(H_unc),'[WM^{-2}] - ',...
    'W = ',num2str(W_unc),'[ms^{-1}]']})

if SSS_unc ~= 0
    caxis([-0.2e-8 0.2e-8])
    monte_carlo_hist(var,name,vare,1e-8,lat,lon,1,20,30,ocean,fign+4,units,...
    randnumgen,seed,n_stat,1e-8,fign,vare_diff_H_mean,0.2e-8,0.006e-8,[],[])
elseif SST_unc ~=0
    caxis([-0.2e-8 0.2e-8])
    monte_carlo_hist(var,name,vare,[],lat,lon,1,20,30,ocean,fign+4,units,...
    randnumgen,seed,n_stat,3e-8,fign,vare_diff_H_mean,0.2e-8,0.006e-8,[],[])
elseif H_unc ~= 0
    caxis([-0.2e-6 0.2e-6])
    monte_carlo_hist(var,name,vare,[],lat,lon,1,20,30,ocean,fign+4,units,...
    randnumgen,seed,n_stat,1.4e-6,fign,vare_diff_H_mean,0.2e-6,0.006e-6,[],[])
elseif W_unc ~= 0
    caxis([-W_unc W_unc])
    monte_carlo_hist(var,name,vare,[],lat,lon,1,20,30,ocean,fign+4,units,...
    randnumgen,seed,n_stat,3e-5,fign,vare_diff_H_mean,0.2e-5,0.006e-5,[],[])
end

end