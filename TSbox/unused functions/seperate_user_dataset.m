function[SSS,lat,lon,longsss] = seperate_user_dataset (sal,tframe)
    longsss = sal{4};

    [~,lat,lon] = load_all_v2('smosbin','jan11dec11','SSS');
    
    load([sal{3},sal{4}],'SSS','lat','lon');
    SSS_change = SSS;
    auxs = nan(180,360,size(SSS_change,3));
    for m = 1:size(SSS_change,3)
        auxs(:,:,m) = squeeze(SSS_change(:,:,m))';
    end
    SSS = auxs;

    % pacific centered view
    for m = 1:size(SSS,3)
        auxs(:,:,m) = [squeeze(SSS(:,181:end,m)) squeeze(SSS(:,1:180,m))];
    end
    SSS = auxs;
    lon = lon';
    %     lon=wrapTo180(lon);
    Lon = [lon(181:end) lon(1:180)]; lon = Lon; clear Lon


    if strcmp(tframe,'jan10dec10')
        out = SSS(:,:,1:12);
    elseif strcmp(tframe,'jan11dec11')
        out = SSS(:,:,13:24);
    elseif strcmp(tframe,'jan12dec12')
        out = SSS(:,:,25:36);
    elseif strcmp(tframe,'jan13dec13')
        out = SSS(:,:,37:48);
    elseif strcmp(tframe,'jan14dec14')
        out = SSS(:,:,49:60);
    elseif strcmp(tframe,'jan15dec15')
        out = SSS(:,:,61:72); 
    elseif strcmp(tframe,'jan16dec16')
        out = SSS(:,:,73:84);        
    end

    SSS = out;
end
