function diff_datasets(longitude,latitude,fign,ocean)
% diff_datasets                             Calculates difference between density flux from multiple datasets
%                                                             [ kg/(m2s) ] *ONLY TWOCSMOS OA AND SMOS BINNED
%                                                             WILL MAKE
%                                                             DYNAMIC
%============================================================
% 
% USAGE:  
% diff_datasets(all_form_ts,longitude,latitude,fign)
%                                                   *All variables set
%                                                   through calling
%                                                   function
% 
%
% DESCRIPTION:
%  **As of 13/10/2019 
% Function calculates differences between the density flux derived from
% multiple datasets (density anomaly) and plots maps showing differences.
%
% INPUT:
%  longitude = longitude of ROI     [ vector ]
%  latitude = latitude of ROI   [ vector ]
% OUTPUT:
%  None
% 
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1 (Sunday 13th October 2019) *******STARTING FRESH COUNT
%
% REFERENCES:
% None
% 
% The software is currently in development
%
%============================================================
    
    load ('dense_flux.mat')
    
    del_denseflux = densflux.smosOA{8} - densflux.smosBIN{8};
    del_denseflux(find(del_denseflux==0)) = nan;
    
    figure(fign)
    subplot(1,2,2)
    map_basin(latitude,longitude,ocean)
    pcolorm(latitude,longitude,del_denseflux);
    title('\DeltaSMOS OA-SMOS BINNED')
    land = shaperead('landareas.shp','UseGeoCoords',true);
    geoshow(land,'FaceColor',[0.8 0.8 0.8])
    load ('cmap_STD_geo.mat','ans')  % for colormap and colorbar
    cmap = ans;
    set(gca,'Colormap',cmap)
    caxis ([-1.5e-7 1.5e-7])
    c = colorbar('Location','eastoutside');
   set(get(c,'ylabel'),'string',...
                    'Density flux [kgm^-^2s^-^1]','fontsize',18)
end