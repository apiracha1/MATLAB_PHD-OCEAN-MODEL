function geo_plot(latitude,longitude,lat,lon,vare,SSS_unc,SST_unc,...
    H_unc,W_unc,tframe,ocean,n_stat,month,name_unit,fign,units,load_var,...
    var_name,ca,ca_std,unc_flag,SSS,SST,rho_e)
% geo_plot                             plots annotated geographic maps
%                                           after a monte carlo simulation
%============================================================
% 
% USAGE:  
% wgeo_plot(latitude,longitude,lat,lon,vare,SSS_unc,SST_unc,...
%     H_unc,W_unc,tframe,ocean,n_stat,month,name_unit,fign,units,load_var,...
%     var_name,ca,ca_std,unc_flag)
%                                                   *All variables set
%                                                   through Control_Center
% 
% DESCRIPTION:
% Function calculates all parameters from density flux to formation (both
% TS and rho)
%
% INPUT:
% [latitude,longitude,lat,lon] = lat lon from colTSreg_v2 and basin bounds, repectively [ matrix ]
% vare = variable with for all simulations of monte-carlo
%[SSS_unc,SST_unc,H_unc,W_unc] = Variable uncertainties [ number]
% tframe = time frame chosen [ string ]
% ocean = basin chosen [ string ]
% n_stat = number of statistically random points for monte-carlo simulation 
% month = month chosen [ number ]
% name_unit = name and unit of variable to be plotted [ string ]
% fign = figure number for figure to be plottes [ number ]
% units = units of variable to be plotted [ string ]
% load_var = reference variable to be loaded [ string ]
% var_name = variable name to be plotted [ string ]
% [ca,ca_std] = mean and std colorbar limits, respectively [ vectors ]
% unc_flag = 1 if uncertainty in extent is to be plotted, 0 otherwise [ number ] 
% 
% OUTPUT:
% NONE
% 
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1 (Monday 10th February 2020) *******STARTING FRESH COUNT
% NOTES on VERSION:
%
% REFERENCES:
%
% The software is currently in development
%
%============================================================
if ischar(load_var)
var = load('/home/ap/PHD-BEC/ESA/smos_box/TSdiag/Variables/1_degree/jan13dec13/Jan/All_variables.mat',...
    load_var);
var = struct2cell(var);
var = var{1};
else
    var = load_var;
    var = var(:,:,month);
end

if size(vare,4) > 1
    vare_mc_mean = nanmean(vare,4);
    vare_mc_std = nanstd(vare,4);
    vare_mc_skewness = skewness(vare,0,4);
    vare_diff_H_mean = var(:,:) - vare_mc_mean(:,:);
else
    vare_mc_mean = nanmean(vare,3);
    vare_mc_std = nanstd(vare,3);
    vare_mc_skewness = skewness(vare,0,3);
    vare_diff_H_mean = var(:,:) - vare_mc_mean(:,:);
end


%% Mean
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
    ['Uncertainties: SSS = ',num2str(SSS_unc),'[%] - ',...
    'SST = ',num2str(SST_unc),'[%] - ',...
    'H = ',num2str(H_unc),'[%] - ',...
    'W = ',num2str(W_unc),'[%]']},'fontsize',14)
caxis(ca)

%% STD (uncertainty in extent)
if unc_flag == 1
    SSS = gsw_SA_from_SP(SSS,0,lon,lat);
    SST = gsw_CT_from_t(SSS,SST,0);
    [rho,~,~] = gsw_rho_alpha_beta(SSS,SST,0);
    geo_unc = uncertainty_geo_extent(vare,n_stat);
    figure(fign+1)
    clf
    set(gcf,'Color','w')
    map_basin(latitude,longitude,ocean,lat,lon,(geo_unc'./n_stat).*100)
    contourm(lat,lon,rho(:,:,1)','LevelList',[1025.7 1025.9],'LineColor','r','LineWidth',2);
    contourm(lat,lon,nanmean(rho_e,3)','LevelList',[1025.7 1025.9],'LineColor','k','LineWidth',2);
    set(gcf,'Colormap',jet)
    c = colorbar('Location','eastoutside','FontSize',18);
    set(get(c,'ylabel'),'string',...
                    '[%]','fontsize',18)
    title({['month = ',num2str(month),' year = 20',[tframe(end-1),tframe(end)]],...
        ['Uncertainty in extent of ',num2str(n_stat),' simulations'],...
        ['Uncertainties: SSS = ',num2str(SSS_unc),'[%] - ',...
        'SST = ',num2str(SST_unc),'[%] - ',...
        'H = ',num2str(H_unc),'[%] - ',...
        'W = ',num2str(W_unc),'[%]']},'fontsize',14)
    caxis([0 100])
else
    fign = fign-1;
end

%% STD (uncertainty in extent)
figure(fign+2)
clf
set(gcf,'Color','w')
map_basin(latitude,longitude,ocean,lat,lon,vare_mc_std')
set(gcf,'Colormap',jet)
c = colorbar('Location','eastoutside','FontSize',18);
set(get(c,'ylabel'),'string',...
                name_unit,'fontsize',18)
title({['month = ',num2str(month),' year = 20',[tframe(end-1),tframe(end)]],...
    ['STD of ',num2str(n_stat),' simulations'],...
    ['Uncertainties: SSS = ',num2str(SSS_unc),'[%] - ',...
    'SST = ',num2str(SST_unc),'[%] - ',...
    'H = ',num2str(H_unc),'[%] - ',...
    'W = ',num2str(W_unc),'[%]']},'fontsize',14)
caxis(ca_std)

%% Skewness
figure(fign+3)
clf
set(gcf,'Color','w')
map_basin(latitude,longitude,ocean,lat,lon,vare_mc_skewness')
set(gcf,'Colormap',jet)
c = colorbar('Location','eastoutside','FontSize',18);
set(get(c,'ylabel'),'string',...
                'Skewness','fontsize',18)
title({['month = ',num2str(month),' year = 20',[tframe(end-1),tframe(end)]],...
    ['Skewness of ',num2str(n_stat),' simulations'],...
    ['Uncertainties: SSS = ',num2str(SSS_unc),'[%] - ',...
    'SST = ',num2str(SST_unc),'[%] - ',...
    'H = ',num2str(H_unc),'[%] - ',...
    'W = ',num2str(W_unc),'[%]']},'fontsize',14)
caxis([-1 1])

%% Diff. from mean
figure(fign+4)
clf
set(gcf,'Color','w')
map_basin(latitude,longitude,ocean,lat,lon,vare_diff_H_mean')
set(gcf,'Colormap',jet)
c = colorbar('Location','eastoutside','FontSize',18);
set(get(c,'ylabel'),'string',...
                name_unit,'fontsize',18)
title({['month = ',num2str(month),' year = 20',[tframe(end-1),tframe(end)]],...
    ['\DeltaReference-Mean of ',num2str(n_stat),' simulations'],...
    ['Uncertainties: SSS = ',num2str(SSS_unc),'[%] - ',...
    'SST = ',num2str(SST_unc),'[%] - ',...
    'H = ',num2str(H_unc),'[%] - ',...
    'W = ',num2str(W_unc),'[%]']},'fontsize',14)
caxis([-(ca_std(2)) ca_std(2)])

for i = 1:size(var,1)
    for j = 1:size(var,2)
        var_ = var(i,j);
        if ~isnan(var_)
            if ~isnan(vare(i,j))
                loni = i;
                lati = j;     
               
                if SSS_unc ~=0
                    imp_monte_carlo_hist(var(loni,lati),vare(loni,lati,:),units,4,lat(lati),lon(loni),'[\circN]','[\circE]',...
                        var_name,['SSS = ',num2str(SSS_unc)],...
                        n_stat,fign+5)
                    imp_monte_carlo_hist(0,vare_diff_H_mean(:),units,4,'all',[],'grid points',[],...
                        var_name,...
                        ['SSS = ',num2str(SSS_unc)],...
                        n_stat,fign+6)
                elseif SST_unc ~=0
                    imp_monte_carlo_hist(var(loni,lati),vare(loni,lati,:),units,4,lat(lati),lon(loni),'[\circN]','[\circE]',...
                        var_name,['SST = ',num2str(SST_unc)],...
                        n_stat,fign+5)
                    imp_monte_carlo_hist(0,vare_diff_H_mean(:),units,4,'all',[],'grid points',[],...
                        var_name,...
                        ['SST = ',num2str(SST_unc)],...
                        n_stat,fign+6)
                elseif H_unc ~=0
                    imp_monte_carlo_hist(var(loni,lati),vare(loni,lati,:),units,4,lat(lati),lon(loni),'[\circN]','[\circE]',...
                        var_name,['H = ',num2str(H_unc)],...
                        n_stat,fign+5)
                    imp_monte_carlo_hist(0,vare_diff_H_mean(:),units,4,'all',[],'grid points',[],...
                        var_name,...
                        ['H = ',num2str(H_unc)],...
                        n_stat,fign+6)
                elseif W_unc ~=0
                    imp_monte_carlo_hist(var(loni,lati),vare(loni,lati,:),units,4,lat(lati),lon(loni),'[\circN]','[\circE]',...
                        var_name,['W = ',num2str(W_unc)],...
                        n_stat,fign+5)
                    imp_monte_carlo_hist(0,vare_diff_H_mean(:),units,4,'all',[],'grid points',[],...
                        var_name,...
                        ['W = ',num2str(W_unc)],...
                        n_stat,fign+6)

                end
                
                if unc_flag ~= 1
                    fign = fign+1;
                end
                
                figure(fign)
                plotm(lat(lati),lon(loni),'g.','MarkerSize',30)




                return
            end
        end
    end
end

end


