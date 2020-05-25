function satellite_N2(longsss,longsst,sal,temp,ocean,tframe,hflux,radflux,evapo,prec,n_stat) 
    [SSS, lat, ~] = load_all_v2(sal,tframe,'SSS');
    SST = load_all_v2(temp,tframe,'SST');

    load('./data/NCEP-NCAR/AverageSeaLevelPressure/SSPjan12_dec17.mat');
    h = figure(2);
    
    for i = 1:12
        [N2, p_mid] = gsw_Nsquared(SSS(:,:,i),SST(:,:,i),SSP(:,:,i)*10e4,lat);
        n = real(N2);

        k = real(sqrt(n));
        find (isnan(k));
        ind = find (isnan(k));
        k(ind)=0;

        worldmap world
        load coast.mat
        plotm(lat,long)

        [~, lat, lon] = load_all_v2(sal,tframe,'SSS');
        pcolorm(lat,lon,k)
        land = shaperead('landareas.shp','UseGeoCoords',true);
        geoshow(land,'FaceColor',[0.8 0.8 0.8])
%         c = colorbar;
%         caxis([-1.5 3]);
%         ca = [-1.5 3];
%         cm = anom_cmap(ca);
%         colormap(cm);
%         set(get(c,'ylabel'),'string',strcat('N^2 (s^-^1)'),'fontsize',10)
%         
        title({['month = ' num2str(i)], [longsss,' SSS ' longsst,' SST']});
        drawnow
          frame = getframe (h);
        im{i} = frame2im(frame);
    
    end
    
filename = (['satellite_N2.gif']);


original_dir = pwd;
mkdir([original_dir,'\gifs\','satellite_N2/',tframe,'/',sal,'/',temp,'/',hflux,'/',radflux,'/',evapo,'/',prec,'/',ocean(1:2),'/mc',num2str(n_stat)])
cd ([original_dir,'\gifs\','satellite_N2/',tframe,'/',sal,'/',temp,'/',hflux,'/',radflux,'/',evapo,'/',prec,'/',ocean(1:2),'/mc',num2str(n_stat)])

for i = 1:12
    [A,Map] = rgb2ind(im{i},256);
    if i == 1
        imwrite(A,Map,filename,'gif','LoopCount',inf,'DelayTime',1);
    else
        imwrite(A,Map,filename,'gif','WriteMode','append','DelayTime',1);        
    end
end

cd (original_dir)
end   