function errorpercentcalculation (Fmean_mean,n_stat,ocean,sigmaSSS,sigmaSST)

    save('anything','Fmean_mean')
    load (['1_1_',ocean,'.mat'])
    fmean_1 = Fmean_mean;
    load ('anything.mat')
    
    err = Fmean_mean./fmean_1;
    err = err.*100;
    
    Fmean = err - 100;
    
    [latitude, longitude, ~] = colTSreg_v2(ocean);
    load coast
    
    if strcmp(ocean,'NP') || strcmp(ocean,'SO') || strcmp(ocean,'SP')
    long(long<0) = long(long<0) + 360;
    long(long>359.5 | long < 0.5) = nan;
    elseif strcmp(ocean,'SA')
    Fmean = [Fmean(:,31:end,:) Fmean(:,1:30,:)];
    elseif strcmp(ocean,'NA2')
    Fmean = [Fmean(:,16:end,:) Fmean(:,1:15,:)];
    elseif strcmp(ocean,'all')
    Fmean = [Fmean(:,181:end,:) Fmean(:,1:180,:)];
    longitude = -179.5:179.5;
    end
    
    if strcmp (ocean,'SO')
        worldmap ([-90 latitude(end)],[longitude(1) longitude(end)])
    else
        worldmap ([latitude(1) latitude(end)],[longitude(1) longitude(end)])
    end
    
    land = shaperead('landareas.shp','UseGeoCoords',true);
    geoshow(land,'FaceColor',[0.8 0.8 0.8])
    
    pcolorm(latitude,longitude,Fmean)
    
    c = colorbar;
    set(c,'position', [[0.912959566029328,0.103556485355647,0.013888888888889,0.814853556485356]])
    set(get(c,'ylabel'),'string',strcat('Percentage error [%]'),'fontsize',10)
    ca = [-150 150];
    caxis (ca)
    
    title({[' MC realisations = ', num2str(n_stat)], [' - \sigma_S_S_S = ', num2str(sigmaSSS),' - \sigma_S_S_T = ', num2str(sigmaSST)]})
    cm = anom_cmap(ca);
    colormap(cm);
    
   
    
    err = nanmean(err(:));
    
    title({['Percentage error = ',num2str(err), '% - MC realisations = ', num2str(n_stat)], [' - \sigma_S_S_S = ', num2str(sigmaSSS),' - \sigma_S_S_T = ', num2str(sigmaSST)]})
    mkdir(['percentage_error','/',ocean,'/',num2str(n_stat),'/',num2str(sigmaSSS),'/',num2str(sigmaSST)])
    cd (['percentage_error','/',ocean,'/',num2str(n_stat),'/',num2str(sigmaSSS),'/',num2str(sigmaSST)])
    print ('-dpng','-r300',[ocean,'.png'])
    
    fprintf(['the percentage error is = ',num2str(err),' with ',num2str(n_stat),' realisations ','\n'])
end    