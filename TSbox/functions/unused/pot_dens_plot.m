function pot_dens_plot(monthss,orho,sal,latitude,longitude,fign)
%plotting density maps of user selected region
if strcmp(sal,'smosOA')
        figure(fign)
subplot(4,3,monthss)
    worldmap ([latitude(1) latitude(end)],...
        [longitude(1) longitude(end)])
    pcolorm(latitude,longitude,orho(:,:,monthss)-1000)
    cm = anom_cmap_nowhite([22 28]);
    colormap(cm)
    caxis([22 28])
    land = shaperead('landareas.shp','UseGeoCoords',true);
                geoshow(land,'FaceColor',[0.8 0.8 0.8])
                    c = colorbar('Location','eastoutside');
                
                set(get(c,'ylabel'),'string',...
                    'Potential Density[kgm^-^3','fontsize',18)
                
                title(['Potential Density  month = ',num2str(monthss)])

    else
                       figure(7)
subplot(4,3,monthss)
    worldmap ([latitude(1) latitude(end)],...
        [longitude(1) longitude(end)])
    pcolorm(latitude,longitude,orho(:,:,monthss)-1000)
    cm = anom_cmap_nowhite([22 28]);
    colormap(cm)
    caxis([22 28])
    land = shaperead('landareas.shp','UseGeoCoords',true);
                geoshow(land,'FaceColor',[0.8 0.8 0.8])
                    c = colorbar('Location','eastoutside');
                
                set(get(c,'ylabel'),'string',...
                    'Potential Density[kgm^-^3','fontsize',18)
                
                title(['Potential Density  month = ',num2str(monthss)])

    end


end