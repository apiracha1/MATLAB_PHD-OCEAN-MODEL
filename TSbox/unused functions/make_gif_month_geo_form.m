function make_gif_month_geo_form(ocean,Fpeak,n_stat,prec,evapo,radflux,hflux,temp,sal,tframe,ca_bar,thetaS,thetaT,longsss,longsst,season)
season = 1;
% %%------------------------Start of Header----------------------------------
%
% ROUTINE                    make_gif_month_geo_form
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
% Fpeak                      matrix containing geographic formation values for each of
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
% thetaS,thetaT              2 value vector for min and max sal and temp of
%                            bounding box around peak formation (TS space)
%                            if polygon of formation reagion is choosen the
%                            vector becomes the min and max sal and temp of
%                            the polygon 
% %%------------------------END of Header----------------------------------    

    [latitude,longitude,~] = colTSreg_v2(ocean);

    long=0;
    
%     load lat
%     load long

    
    Fpeak = permute(Fpeak,[3,4,2,1]);
    h = figure;
    if strcmp (ocean,'SO')
        worldmap ([-90 latitude(end)],[longitude(1) longitude(end)])
    else
        worldmap ([latitude(1) latitude(end)],[longitude(1) longitude(end)])
    end
%     load coastlines
%     plotm(coastlat,coastlon)
    load coast
    plotm(lat,long)
    land = shaperead('landareas.shp','UseGeoCoords',true);
    geoshow(land,'FaceColor',[0.8 0.8 0.8])
    
    if strcmp(ocean,'NP') || strcmp(ocean,'SO') || strcmp(ocean,'SP') || strcmp(ocean,'TP')...
            || strcmp(ocean,'IO') ... %% added luigi castaldo || strcmp(ocean,'IO')%
            || strcmp(ocean,'EP')
        long(long<0) = long(long<0) + 360;
        long(long>359.5 | long < 0.5) = nan;
    elseif strcmp(ocean,'SA')
        Fpeak = [Fpeak(:,31:end,:,:) Fpeak(:,1:30,:,:)];
    elseif strcmp(ocean,'NA2')
        Fpeak = [Fpeak(:,16:end,:,:) Fpeak(:,1:15,:,:)];
    elseif strcmp(ocean,'all')
        Fpeak = [Fpeak(:,181:end,:) Fpeak(:,1:180,:,:)];
        longitude = -179.5:179.5;
    end

    
    
    
    set (gcf,'Color',[1 1 1 1])
    set(h,'units','normalized','outerposition',[0 0 1 1])
     cb = colorbar;
            set(cb,'Position',[0.9229,0.1108,0.0187,0.8135])
            if strcmp(ocean,'SA')
                set(cb,'Position',[0.9229,0.1108,0.0187,0.8135])
            end
            
     
            
            ca = ca_bar;
            cm = anom_cmap_white(ca); colormap(cm);
            
%             hold on; 
%             plot(long,lat,'k','linewidth',1.5); 
            caxis ([ca(1) ca(2)])
            
             textm(latitude(1+7),longitude(1+8),[num2str(round(thetaS(1),1)),' to ',...
                num2str(round(thetaS(2),1)),' g/kg'],'fontsize',14)
            textm(latitude(1+3),longitude(1+7),[num2str(round(thetaT(1),1)),....
                ' to ',num2str(round(thetaT(2),1)),' ^{\circ}C'],'fontsize',14)
            set(get(cb,'ylabel'),'string','Formation [Sv]','fontsize',15)
            %set (gcf,'fontsize',15')
            set(gca,'color',[0.8 0.8 0.8]);
            set(gcf,'color',[1 1 1])
            set(gcf, 'InvertHardCopy', 'off');
            grid on; set(gca,'layer','top')
            
    
    load lat
    load long
    
    sizes = size(Fpeak);

    for j = 1:12
        for i = 1:n_stat
        
        %% plotting peaks
            
                      Fpeak_m__(1:sizes(1),1:sizes(2)) = Fpeak(:,:,j,i);
            Fpeak_m__(find(Fpeak_m__ == 0)) = NaN;
%             pcolorm(longitude,latitude,Fpeak_m__);
            p = pcolorm(latitude,longitude,Fpeak_m__);


%             shading flat
            
%             cb = latlonlabel(ocean,1);
           
            
%             set(gca,'position',[0.1200    0.1100    0.7750    0.7567])
            
            title({[longsss,' SSS and ',longsst,' SST'];['month = ', num2str(j), ' and MC = ', num2str(i)]},...
                'fontsize',15)            
           
%             hold off

            drawnow
%             pause (0.5)
            frame = getframe (h);
            im{i,j} = frame2im(frame);
            delete (p)
        end
        
            

    end

    filename = (['annual_form.gif']);

    original_dir = pwd;
    mkdir([original_dir,'\gifs\','annual_form/',tframe,'/',sal,'/',temp,'/',hflux,'/',radflux,'/',evapo,'/',prec,'/',ocean(1:2),'/mc',num2str(n_stat),'/',num2str(season)])
    cd ([original_dir,'\gifs\','annual_form/',tframe,'/',sal,'/',temp,'/',hflux,'/',radflux,'/',evapo,'/',prec,'/',ocean(1:2),'/mc',num2str(n_stat),'/',num2str(season)])
    
    
    for j = 1:12
        for i = 1:n_stat
        [A,Map] = rgb2ind(im{i,j},256);
            if j == 1 && i == 1
                imwrite(A,Map,filename,'gif','LoopCount',inf,'DelayTime',1);
            else
                imwrite(A,Map,filename,'gif','WriteMode','append','DelayTime',1);        
            end
        end
    end

    cd (original_dir)

end














