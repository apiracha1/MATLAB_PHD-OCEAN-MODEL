function initial_maps(oH,oW,oSSS,oSST,latitude,longitude,~,sal,month,ocean,lat,lon,tframe,fign)
% initial_maps                              plots all initial variables
%                                                                                  SSS - [ PSU ]
%                                                                                  SST - [ degC ]
%                                                                       Heat fluxes - [ W/m^2 ]
%                                                                  Freshw. fluxes - [ mm/day ]
%============================================================
% 
% USAGE:  
% initial_maps(oH,oW,oSSS,oSST,latitude,longitude,fign,sal)
%                                                   *All variables set
%                                                   through Control_Center
% 
% DESCRIPTION:
%  **As of 16/10/2019 
% Function plots maps of all variables specified by user choices of
% datasets
%
% INPUT:
%  [oH oW] = Heat and freshater flux data       [ 3-d matrix ]
%  [oSSS oSST] = Salinit and Temperature data       [ 3-d matrix ]
%  [latitude longitude] = Latitude and Longitude of ROI         [ matrix ]
%  fign = figure number         [ number ]
%  sal = salinity dataset name          [ string ]
%  month = month number/s       [ number ]
%  ocean = ROI's name       [ string ]
%  [lat,lon] = global latitudes in dataset resolution   [ vector ]
%  tframe = current year           [ string ] (FORMAT: jan##dec##, ## = 12 for 2012 e.t.c.)
% 
% OUTPUT:
%  None
%
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1 (Wednesday16th October 2019) *******STARTING FRESH COUNT
% NOTES on VERSION:
% None
%
% REFERENCES:
% None 
%
% The software is currently in development
%
%============================================================

        

    %% SSS
        figure(fign)
        clf
        set(gcf,'Color','w')
        map_basin(latitude,longitude,ocean,lat,lon,oSSS(:,:,month)')
        set(gcf,'Colormap',jet)
        c = colorbar('Location','eastoutside','FontSize',18);
        set(get(c,'ylabel'),'string',...
                        'SSS [PSU]','fontsize',18)
        title({['month = ',num2str(month),' year = 20',[tframe(end-1),tframe(end)]],...
            ['SSS [PSU]']},'fontsize',14)
        caxis([32 37])

    %% SST    
        figure(fign+1)
        clf
        set(gcf,'Color','w')
        map_basin(latitude,longitude,ocean,lat,lon,oSST(:,:,month)')
        set(gca,'Colormap',jet)
        c = colorbar('Location','eastoutside','FontSize',18);
        set(get(c,'ylabel'),'string',...
                       'SST [\circC]','fontsize',18)
        title({['month = ',num2str(month),' year = 20',[tframe(end-1),tframe(end)]],...
            ['SST [\circC]']},'fontsize',14)
        caxis([15 30])

    %% Heat fluxes
        figure(fign+2)
        clf
        set(gcf,'Color','w')
        map_basin(latitude,longitude,ocean,lat,lon,oH(:,:,month)')
        set(gca,'Colormap',jet)
        c = colorbar('Location','eastoutside','FontSize',18);
        set(get(c,'ylabel'),'string',...
                        'Heat Flux [Wm^-^2]','fontsize',18)
        title({['month = ',num2str(month),' year = 20',[tframe(end-1),tframe(end)]],...
            ['Heat flux [Wm^-^2]']},'fontsize',14)
        caxis([-60 130])

    %% Freshwater fluxes
        figure(fign+3)
        clf
        set(gcf,'Color','w')
        map_basin(latitude,longitude,ocean,lat,lon,oW(:,:,month)')   
        set(gca,'Colormap',jet)
        c = colorbar('Location','eastoutside','FontSize',18);
        set(get(c,'ylabel'),'string',...
                        'Freswater Flux [ms^-^1]','fontsize',18)
        title({['month = ',num2str(month),' year = 20',[tframe(end-1),tframe(end)]],...
            ['Freshwater flux [ms^-^1]']},'fontsize',14)
        caxis([-1e-7 2e-7])
    %% rho
    SSS = gsw_SA_from_SP(oSSS(:,:,month),0,lon,lat);
    SST = gsw_CT_from_t(oSSS(:,:,month),oSST(:,:,month),0);
    [rho,~,~] = gsw_rho_alpha_beta(oSSS(:,:,month),oSST(:,:,month),0);

        figure(fign+4)
        clf
        set(gcf,'Color','w')
        map_basin(latitude,longitude,ocean,lat,lon,rho(:,:,month)')
        set(gcf,'Colormap',jet)
        c = colorbar('Location','eastoutside','FontSize',18);
        set(get(c,'ylabel'),'string',...
                        '\rho [kgm^{-3}]','fontsize',18)
        title({['month = ',num2str(month),' year = 20',[tframe(end-1),tframe(end)]],...
            ['\rho [kgm^{-3}]']},'fontsize',14)
        caxis([1020 1028])
        
                figure(fign+5)
        clf
        set(gcf,'Color','w')
        map_basin(latitude,longitude,ocean,lat,lon,rho(:,:,month)')
        set(gcf,'Colormap',jet)
        c = colorbar('Location','eastoutside','FontSize',18);
        set(get(c,'ylabel'),'string',...
                        '\rho [kgm^{-3}]','fontsize',18)
        title({['month = ',num2str(month),' year = 20',[tframe(end-1),tframe(end)]],...
            ['\rho [kgm^{-3}]']},'fontsize',14)
        caxis([1020 1022])
        
                figure(fign+6)
        clf
        set(gcf,'Color','w')
        map_basin(latitude,longitude,ocean,lat,lon,rho(:,:,month)')
        set(gcf,'Colormap',jet)
        c = colorbar('Location','eastoutside','FontSize',18);
        set(get(c,'ylabel'),'string',...
                        '\rho [kgm^{-3}]','fontsize',18)
        title({['month = ',num2str(month),' year = 20',[tframe(end-1),tframe(end)]],...
            ['\rho [kgm^{-3}]']},'fontsize',14)
        caxis([1022 1024])
        
                figure(fign+7)
        clf
        set(gcf,'Color','w')
        map_basin(latitude,longitude,ocean,lat,lon,rho(:,:,month)')
        set(gcf,'Colormap',jet)
        c = colorbar('Location','eastoutside','FontSize',18);
        set(get(c,'ylabel'),'string',...
                        '\rho [kgm^{-3}]','fontsize',18)
        title({['month = ',num2str(month),' year = 20',[tframe(end-1),tframe(end)]],...
            ['\rho [kgm^{-3}]']},'fontsize',14)
        caxis([1024 1026])
        
                figure(fign+8)
        clf
        set(gcf,'Color','w')
        map_basin(latitude,longitude,ocean,lat,lon,rho(:,:,month)')
        set(gcf,'Colormap',jet)
        c = colorbar('Location','eastoutside','FontSize',18);
        set(get(c,'ylabel'),'string',...
                        '\rho [kgm^{-3}]','fontsize',18)
        title({['month = ',num2str(month),' year = 20',[tframe(end-1),tframe(end)]],...
            ['\rho [kgm^{-3}]']},'fontsize',14)
        caxis([1026 1028])

        %% Density flux
%         load('/home/ap/PHD-BEC/ESA/smos_box/TSdiag/Variables/1_degree/jan13dec13/Jan/All_variables.mat',...
% 'Fmean','Fpeak_f_r','Fpeak_f_ts','Fpeak_t_r','Fpeak_t_ts')
% 
%         figure(fign+4)
%         clf
%         set(gcf,'Color','w')
%         map_basin(latitude,longitude,ocean,lat,lon,Fmean(:,:)')   
%         set(gca,'Colormap',jet)
%         c = colorbar('Location','eastoutside','FontSize',18);
%         set(get(c,'ylabel'),'string',...
%                         'Density flux [kgm^{-2}s^{-1}]','fontsize',18)
%         title({['month = ',num2str(month),' year = 20',[tframe(end-1),tframe(end)]],...
%             ['Density flux [kgm^{-2}s^{-1}]']},'fontsize',14)
%         caxis([-1e-5 2e-5])
%         
%         figure(fign+)
% clf
% set(gcf,'Color','w')
% plot(sigma,var,'r-')
% hold on
% plot(sigma,vare_mc_mean,'k-')
% errorbar(sigma,vare_mc_mean,vare_mc_std)
% yline(0,'k-')
% title({['month = ',num2str(month),' - year = 20',[tframe(end-1),tframe(end)]],...
%     ['Mean of ',num2str(n_stat),' simulations'],...
%     ['Uncertainties: SSS = ',num2str(SSS_unc),'[%] - ',...
%     'SST = ',num2str(SST_unc),'[%] - ',...
%     'H = ',num2str(H_unc),'[%] - ',...
%     'W = ',num2str(W_unc),'[%]']},'fontsize',14)
% xlabel('Density [kgm^-^3]','FontSize',14)
% ylabel(name_unit,'FontSize',14)




end