function form_geo_plot(stripes,str_num,Fpeak_mean,tframe,ocean,S,T,sal,lat,lon,month)
%drawing formation in geographic space
        figure(7)
        [latitude, longitude, ~] = colTSreg_v2(ocean);        
        map_basin(latitude,longitude,ocean)
        land = shaperead('landareas.shp','UseGeoCoords',true);
        geoshow(land,'FaceColor',[0.8 0.8 0.8])
            figure(8)
        [row,col] = ind2sub([75 81], stripes{1,str_num});
        plot(S(col),T(row),'r.','MarkerSize',10)
        figure(7)
        %     hold off
        pcolorm(lat,lon,Fpeak_mean');

        title([sal,' - month = ',month,' - 20',tframe(end-1:end),' - MEAN'])
        ca = [0 100];  caxis(ca)
        cm = anom_cmap_nowhite(ca); set(gca,'colormap',cm); hold on
        c = colorbar;
        set(get(c,'ylabel'),'string','Formation [mseason^-^1]','fontsize',18)


        pause(2)
        figure(8)
        plot(S(col),T(row),'g.','MarkerSize',10)
end
        