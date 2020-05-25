(180,360,size(wsatwind1deg,3));
        % rotate
        for m = 1:size(SST,3)
            SST(:,:,m) = squeeze(wsatSST1deg(:,:,m))';
            WS10(:,:,m) = squeeze(wsatwind1deg(:,:,m))';
        end

        vartype = varargin{:};
        if strcmp(vartype,'SST')
            out = SST;
        elseif strcmp(vartype,'WS')
            out = WS10;
        end

        if strcmp(tframe,'aug11dec11')
            out = out(:,:,8:12);
        end
     end
     
%% ASCAT -------------------------------------------------------------------
elseif strcmp(dtype,'ascat')
    load ./data/ASCAT/ascat_1deg_jan11dec11
    xwind = nan(180,360,12); ywind = nan(180,360,12);
    % rotate
    for m = 1:size(xwind,3)
        xwind(:,:,m) = squeeze(xws1deg(:,:,m))';
        ywind(:,:,m) = squeeze(yws1deg(:,:,m))';
    end
    
    out = sqrt(xwind.*xwind + ywind.*ywind);
    lat = lat1deg; lon = lon1deg;
    if strcmp(tframe,'aug11dec11')
        out = out(:,:,8:12);
    end
        
%% SSM-I -------------------------------------------------------------------
elseif strcmp(dtype,'ssmi')
    if isempty(varargin)
        disp('Error: you need to specify the variable (precip or WS)')
        out = []; 