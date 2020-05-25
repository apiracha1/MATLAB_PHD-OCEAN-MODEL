function make_gif_global_transf(Fmean_e,ocean,tframe,sal,temp,hflux,radflux,evapo,prec,n_stat,longsss,longsst)
% %%------------------------Start of Header----------------------------------
%
% ROUTINE                    make_gif_global_transf
% AUTHOR                     Aqeel Piracha
% MAIL                       apiracha@btinternet.com
% DATE                       march 19th 2018
% VERSION                    1.0
% PURPOSE                    pcolor plot of all components of MC and creates 
%                            subsequent gif file, devised
%                            to verify MC 
%                            
%
%
% INPUT
% Fmean_e                    matrix containing transformation values for each of
%                            the MC runs. 
% sal, temp,                 salinity and temperature product
% hflux,radflux,evapo,prec   heat flux, radiation,evaporation and
%                            precipitation product
% n_stat                     Number of MC realizations
% formation1                 Formation values when run without any MC
% ca_bar                     Colorbar values [min max]
% colormap_jet_flag          Choice of customize or default cmap (true=1
%                            false = 0
% longsss,longsst            fullname of Temperature Salinit product (SMOS,
%                            OSTIA)
% ocean,fullname             Abbreviation and fullname of basin (SA,South
%                            Atlantic
% %%------------------------END of Header----------------------------------
%     [latitude,longitude,aratio] = colTSreg_v2(ocean);
    Fmean = permute(Fmean_e,[2,3,1]);
    
%     if strcmp(ocean,'NP') || strcmp(ocean,'SO') || strcmp(ocean,'SP')
%         long(long<0) = long(long<0) + 360;
%         long(long>359.5 | long < 0.5) = nan;
%     elseif strcmp(ocean,'SA')
%         Fmean = [Fmean(:,31:end,:) Fmean(:,1:30,:)];
%     elseif strcmp(ocean,'NA2')
%         Fmean = [Fmean(:,16:end,:) Fmean(:,1:15,:)];
%     elseif strcmp(ocean,'all')
%         Fmean = [Fmean(:,181:end,:) Fmean(:,1:180,:)];
%         longitude = -179.5:179.5;
%     end
    
% ocean = 'NA2';
    h = figure (2);
%     xlim([-180 180])
%     ylim([-79.5 79.5])
    
    set (gcf,'Color',[1 1 1 1])
    set(h,'units','normalized','outerposition',[0 0 1 1])
    
      cb = colorbar('southoutside');
        set(gca,'fontsize',14)
        set(gca,'xtick',-150:50:150,'xticklabel',{'150W','100W','50W','0','50E','100E','150E'})
        ca = [-1e-5 1e-5];
        cm = anom_cmap(ca);
        colormap(cm);caxis(ca);
        set(get(cb,'ylabel'),'string','density flux [kgs^{-1}m^{-2}]','fontsize',15)
        hold on;
%         plot(long,lat,'k','linewidth',1); 
%         pbaspect(aratio);set(gca,'color',[0.8 0.8 0.8]);
        set(gcf,'color',[1 1 1])
        set(gcf, 'InvertHardCopy', 'off');
        grid on; 
        set(gca,'layer','top')
    

    
        [latitude, longitude, ~] = colTSreg_v2(ocean);
    
    for i = 1:n_stat
%         load lat
%         load long
    if strcmp (ocean,'SO')
        worldmap ([-90 latitude(end)],[longitude(1) longitude(end)])
    else
        worldmap ([latitude(1) latitude(end)],[longitude(1) longitude(end)])
    end
%     load coastlines
    load coast
%     plotm(coastlat,coastlon)
    plotm(lat,long)
    land = shaperead('landareas.shp','UseGeoCoords',true);
    geoshow(land,'FaceColor',[0.8 0.8 0.8])
    [~, lat, lon] = load_all_v2('smosbin','jan11dec11','SSS');
%         hold on;         
%         contourm(lat,lon,Fmean(:,:,i)*1e6,'k-');    
        p = pcolorm(lat,lon,Fmean(:,:,i)*1e6); 
        contourm(lat,lon,Fmean(:,:,i)*1e6,'k-');    
%         p = pcolor(longitude,latitude,Fmean(:,:,i)*1e6);
% hold on
        
%         box on

%         contour(longitude,latitude,Fmean(:,:,i)*1e6,'k-');

        title({[longsss,' SSS and ',longsst,' SST'],['Global density flux for n = ',num2str(i)]},'fontsize',10)
       
        
%         plot([-180 180 180 -180 -180],[-79.5 -79.5 -40.5 -40.5 -79.5],'k-','linewidth',2) % southern ocean
%         plot([30 120 120 30 30],[-39 -39 20 20 -39 ],'k-','linewidth',2) %indian ocean
%         dgre = [0.2 0.8 0];
%         plot([180 150 150 180 ],[-39 -39 -7 -7 ],'k-','linewidth',2) %south Pacific
%         plot([-180 -50 -50 -180 ],[-39 -39 -7 -7 ],'k-','linewidth',2)% south pacific
% 
%         ora = [1 0.5 0];
% 
%         plot([-60.5 29.5 29.5 -60.5 -60.5],[-39 -39 0 0 -39],'k-','linewidth',2) %south atlantic
%         plot([180 120 120 180 ],[7 7 60 60 ],'k-','linewidth',2) % north pacific
%         plot([-180 -120 -120 -180 ],[7 7 60 60 ],'k-','linewidth',2) % north pacific
%         plot([180 150 150 180 ],[-5 -5 5 5],'k-','linewidth',2) %equatorial pacific
%         plot([-180 -50 -50 -180 ],[-5 -5 5 5],'k-','linewidth',2)% equatorial pacific
%         plot([-90.5 -0.5 -0.5 -90.5 -90.5],[1 1 45 45 1],'k-','linewidth',2) % North atlantic
%         plot ([180 120 120 180 ], [-19 -19 20 20],'k-','linewidth',3) %tropical pacific
%         plot ([-180 -60 -60 -180 ], [-19 -19 20 20],'k-','linewidth',3) %tropical pacific

        
        set(p,'edgecolor','none');
%         cb = latlonlabel(ocean,1);
      
        
%         hold off
        drawnow
        hold off
        
        frame = getframe (h);
        im{i} = frame2im(frame);
    
    end
    
filename = (['global_transf.gif']);


original_dir = pwd;
mkdir([original_dir,'\gifs\','annual_glob_transf/',tframe,'/',sal,'/',temp,'/',hflux,'/',radflux,'/',evapo,'/',prec,'/',ocean(1:2),'/mc',num2str(n_stat)])
cd ([original_dir,'\gifs\','annual_glob_transf/',tframe,'/',sal,'/',temp,'/',hflux,'/',radflux,'/',evapo,'/',prec,'/',ocean(1:2),'/mc',num2str(n_stat)])

for i = 1:n_stat
    [A,Map] = rgb2ind(im{i},256);
    if i == 1
        imwrite(A,Map,filename,'gif','LoopCount',inf,'DelayTime',1);
    else
        imwrite(A,Map,filename,'gif','WriteMode','append','DelayTime',1);        
    end
end

cd (original_dir)
end   