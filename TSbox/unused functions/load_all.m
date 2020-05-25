%--------------------------------------------------------------------------
%
% [OUT LAT LON] = LOAD_ALL(dtype,tframe,[vartype]) loads the following data
% sets: SMOS OI, Aquarius OI, ARGO-NRT, WOA 09, OSTIA SST, GHRSST, CMORPH.
% It rotates and arranges the data in a uniform way (pacific centered), so
% that it can be used for the function basin_bounds.m
% 
% all data sets which can be loaded have been saved as matfiles using the
% allin1_*.m routines in the folder "readers".
%
%   'dtype' names the dataset and can be either
%   'smosOI','aqOI',
%   'wsat','smosbin','aqbin',
%   'argoNRT','woa09',
%   'ostia','ghrsst',
%   'cmorph','oaflux','nocs','ssmi'
%   'jason',
%   or 'oscar'.
%
%   For every new dataset a new 'dtype' option could be introduced with a
%   new if statement.
%   
%   'tframe' specifies the time for which you want to load the data. This
%   can differ, depending on the data set. Current options are:
%   'jan11dec11' (all except Aquarius)
%   'aug11dec11'  (all)
%   'jan10dec12' (CMORPH and OAFlux)
%   once longer data sets are available, new tframe options can be added.
%   The paths to the new .mat files will need to be adapted as well as the
%   timestep selection for the old tframe options.
%
%   'vartype' is otional and specifies the variable to load if there is
%   more than one variable within the respective .mat file
%   it is 'SST'or 'SSS' for the data sets ARGO-NRT and WOA09.
%   or 'evap','lheat', 'sheat' if the data set is OAFlux
%   or 'sheat','lheat','swave','lwave' if the data set is NOCS ICOADS
%   or 'SST', 'WS' if the data set is WindSat
%   or 'precip','WS' if the data set is SSM-I
%
%--------------------------------------------------------------------------

function [out lat lon] = load_all(dtype,tframe,varargin)
%% SMOS OI -----------------------------------------------------------------
if strcmp(dtype,'smosOI')
    % choose timeframe
    if strcmp(tframe,'aug11dec11') 
        load ./data/SMOS/OI/SSS_jan11dec11.mat
        SSS = smosOI_jan11dec11; clear smosOI_jan11dec11
            if strcmp(tframe,'aug11dec11')
                SSS = SSS(:,:,8:12);
            end
    elseif strcmp(tframe,'jan11dec11')
        load ./data/SMOS/OI/SSS_jan11dec11.mat
        SSS = smosOI_jan11dec11; clear smosOI_jan11dec11
    end
    
    % rotate
    auxs = nan(180,360,size(SSS,3));
    for m = 1:size(SSS,3)
        auxs(:,:,m) = squeeze(SSS(:,:,m))';
    end
    SSS = auxs; 
        
    % pacific centered view
    for m = 1:size(SSS,3)
        auxs(:,:,m) = [squeeze(SSS(:,181:end,m)) squeeze(SSS(:,1:180,m))];
    end
    SSS = auxs; 
    lon = lon';
    Lon = [lon(181:end) lon(1:180)]; lon = Lon; clear Lon
    out = SSS;
    
%% SMOSbin -----------------------------------------------------------------
elseif strcmp(dtype,'smosbin')
    load ./data/SMOS/Binned/smos-binned_2011.mat
    SSS = nan(180,360,size(smosbin_2011,3));
    
    % rotate and pacific centered view
    for m = 1:size(SSS,3)
        SSS(:,:,m) = squeeze(smosbin_2011(:,:,m))';
        SSS(:,:,m) = [squeeze(SSS(:,181:360,m)) squeeze(SSS(:,1:180,m))];
    end
    
    if strcmp(tframe,'aug11dec11')
        SSS = SSS(:,:,8:12);
    end
    
    out = SSS;
    lon = 1:360;
    
%% Aquarius OI -------------------------------------------------------------
elseif strcmp(dtype,'aqOI')
    if strcmp(tframe,'jan11dec11')
        disp('Timeframe not available for Aquarius data')
        return
    end
    load ./data/Aquarius/v2.0/smoothed/SSS_aug11dec12.mat
    SSS = aqOI_aug11dec12; clear aqOI_aug11dec12
    SSS(SSS<0 | SSS>40) = nan;

    % rotate
    auxs = nan(180,360,size(SSS,3));
    for m = 1:size(SSS,3)
        auxs(:,:,m) = rot90(SSS(:,:,m));
    end
    SSS = auxs; 

    % pacific centered view
    for m = 1:size(SSS,3)
        auxs(:,:,m) = [squeeze(SSS(:,181:end,m)) squeeze(SSS(:,1:180,m))];
    end
    SSS = auxs; 

    lon = 0.5:360;
    if strcmp(tframe,'aug11dec11')
        out = SSS(:,:,1:5);
    elseif strcmp(tframe,'aug11dec12')
        out = SSS;
    end

%% ARGO NRT ----------------------------------------------------------------
elseif strcmp(dtype,'argoNRT')
        
    if isempty(varargin)
        disp('Error: you need to specify the variable (SSS or SST)')
    else
        load ./data/D2CAS2-argo/NRT/ARGO1deg_jan11dec11
        if strcmp(tframe,'aug11dec11')
            argoSSS1deg = argoSSS1deg(:,:,8:12);
            argoSST1deg = argoSST1deg(:,:,8:12);
        end
        vartype = varargin{:};

        % rotate
        auxs = nan(180,360,size(argoSSS1deg,3));
        auxt = nan(180,360,size(argoSSS1deg,3));
        for m = 1:size(argoSSS1deg,3)
            auxs(:,:,m) = squeeze(argoSSS1deg(:,:,m))';
            auxt(:,:,m) = squeeze(argoSST1deg(:,:,m))';
        end
        SSS = auxs; SST = auxt; clear argo*

       % pacific centered view
        for m = 1:size(SSS,3)
            auxs(:,:,m) = [squeeze(SSS(:,181:end,m)) squeeze(SSS(:,1:180,m))];
            auxt(:,:,m) = [squeeze(SST(:,181:end,m)) squeeze(SST(:,1:180,m))];
        end
        SSS = auxs; SST = auxt;
        lon = lon';
        Lon = [lon(181:end) lon(1:180)]; lon = Lon; clear Lon
        if strcmp(vartype,'SSS')
            out = SSS;
        elseif strcmp(vartype,'SST')
            out = SST;
        end
    end

%% OSTIA SST ---------------------------------------------------------------
elseif strcmp(dtype,'ostia')
        load ./data/OSTIAnew/OSTIASST_jan11mar12.mat
        SST = sst1degav; clear sst1degav
    
    % rotate
    auxt = nan(180,360,size(SST,3));
    for m = 1:size(SST,3)
        auxt(:,:,m) = squeeze(SST(:,:,m))';
    end
    
    if strcmp(tframe,'jan11dec11')
        SST = auxt(:,:,1:12); 
    elseif strcmp(tframe,'aug11dec11')
        clear SST
        SST = squeeze(auxt(:,:,8:12));
    end

    % pacific centered view
    auxt = nan(size(SST));
    for m = 1:size(SST,3)
        auxt(:,:,m) = [squeeze(SST(:,181:end,m)) squeeze(SST(:,1:180,m))];
    end
    SST = auxt;
    lon = lon'; 
    Lon = [lon(181:end) lon(1:180)]; lon = Lon; clear Lon
    out = SST;
    
%% GHRSST ------------------------------------------------------------------
elseif strcmp(dtype,'ghrsst')
    load ./data/GHRSST/SST_sep11mar12.mat
    SST = ghrsst_sep11mar12; clear ghrsst_sep11mar12

    % rotate
    auxt = nan(180,360,size(SST,3));
    for m = 1:size(SST,3)
        auxt(:,:,m) = squeeze(SST(:,:,m))';
    end
    SST = auxt; 

    % flip upside dwon
    for m = 1:size(SST,3)
        auxt(:,:,m) = flipud(squeeze(SST(:,:,m)));
    end
    SST = auxt; 
    lon = lon';
    Lon = [lon(181:end) lon(1:180)]; lon = Lon; clear Lon
    out = SST;
 
%% WOA 09 ------------------------------------------------------------------
elseif strcmp(dtype,'woa09')
    if isempty(varargin)
        disp('Error: you need to specify the variable (SSS or SST)')
        out = []; return
        else
        load ./data/WOA09/SSS_woa09.mat
        load ./data/WOA09/SST_woa09.mat
        vartype = varargin{:};

        % rotate
        lat = lat'; lon = lon';
        auxs = nan(180,360,12);
        auxt = nan(180,360,12);
        for m = 1:12
            auxs(:,:,m) = squeeze(SSS(:,:,m))';
            auxt(:,:,m) = squeeze(SST(:,:,m))';
        end
                
        if strcmp(tframe,'jan11dec11')
            SSS = auxs; SST = auxt; clear auxs auxt
        elseif strcmp(tframe,'aug11dec11')
            SSS = auxs(:,:,8:12); SST = auxt(:,:,8:12); clear auxs auxt
        end

        if strcmp(vartype,'SSS')
            out = SSS;
        elseif strcmp(vartype,'SST')
            out = SST;
        end
    end

%% WindSat ----------------------------------------------------------------
elseif strcmp(dtype,'wsat')
     if isempty(varargin)
        disp('Error: you need to specify the variable (SST or WS)')
        out = []; return
     else
        load ./data/WindSat/windsat_jan11dec11
        SST = nan(180,360,size(wsatSST1deg,3));
        WS10 = nan(180,360,size(wsatwind1deg,3));
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
        out = []; return
    else
        load ./data/SSM-I/ssmi_jan11dec11.mat
        precip = nan(180,360,size(ssmiRR1deg,3));
        WS10 = nan(180,360,size(ssmiWS1deg,3));

        % rotate
        for m = 1:size(precip,3)
            precip(:,:,m) = squeeze(ssmiRR1deg(:,:,m))';
            WS10(:,:,m) = squeeze(ssmiWS1deg(:,:,m))';
        end

        vartype = varargin{:};
        if strcmp(vartype,'precip')
            out = precip;
        elseif strcmp(vartype,'WS')
            out = WS10;
        end

        if strcmp(tframe,'aug11dec11')
            out = out(:,:,8:12);
        end
    end
%% CMORPH precipitation ----------------------------------------------------
elseif strcmp(dtype,'cmorph')
        
    if strcmp(tframe,'jan11dec11') || strcmp(tframe,'aug11dec11')
        load ./data/CMORPH/precip-1deg-jan11dec11
        if strcmp(tframe,'jan11dec11')
            precip = nan(180,360,12);
        elseif strcmp(tframe,'aug11dec11')
            precip = nan(180,360,5);
            mprecip1deg = mprecip1deg(:,:,8:12);
        end
    
        % set on a grid from -90 to 90 deg
        for m = 1:size(mprecip1deg,3)
            precip(31:end-30,:,m) = squeeze(mprecip1deg(:,:,m))';
        end
       
        out = precip;
        lat = -89.5:89.5; lon = 0.5:360;
    end
        
    if strcmp(tframe,'jan10dec11')
        load ./data/CMORPH/precip-0point25deg-jan10dec12.mat
        out = nan(720,1440,24);
        for m = 1:24
            out(:,:,m) = precip(:,:,m)';
        end
        lat = -89.875:0.25:89.875;
        lon = 0.125:0.25:360;
    end
    


%% OAflux evaporation ------------------------------------------------------
elseif strcmp(dtype,'oaflux')
    vartype = varargin{:};
    eval(['load ./data/OAFlux/',vartype,'/',vartype,'_oaflux_jan10dec12'])
    clear *_err
    
    if strcmp(vartype,'evap')
    oaflux = evap;
    elseif strcmp(vartype,'lheat')
    oaflux = lheat;
    elseif strcmp(vartype,'sheat')
    oaflux = sheat;
    end
    
    % rotate
    auxe = nan(180,360,size(oaflux,3));
    for m = 1:size(oaflux,3)
        auxe(:,:,m) = squeeze(oaflux(:,:,m))';
    end
    
    if strcmp(tframe,'jan11dec11')
        out = auxe(:,:,13:24);
    elseif strcmp(tframe,'aug11dec11')
        out = auxe(:,:,20:24);
    elseif strcmp(tframe,'jan10dec11')
        out = auxe(:,:,1:24);
    end
    
%% NOCS ICOADS Surface heat fluxes
elseif strcmp(dtype,'nocs')
    vartype = varargin{:};
    
    load ./data/ICOADS/nocs_heatflux_jan11dec11.mat
    
    if strcmp(vartype,'swave')
    nocs = swave;
    elseif strcmp(vartype,'lwave')
    nocs = lwave;
    elseif strcmp(vartype,'sheat')
    nocs = sheat;
    elseif strcmp(vartype,'lheat')
    nocs = lheat;
    end
    
    % rotate
    auxe = nan(180,360,size(nocs,3));
    for m = 1:size(nocs,3)
        auxe(:,:,m) = squeeze(nocs(:,:,m))';
    end
    
    % pacific centered view
    auxp = nan(size(auxe));
    for m = 1:size(auxe,3)
        auxp(:,:,m) = [squeeze(auxe(:,181:end,m)) squeeze(auxe(:,1:180,m))];
    end
    auxe = auxp;
    lon = lon'; 
    Lon = [lon(181:end) lon(1:180)]; lon = Lon; clear Lon
    
    if strcmp(tframe,'jan11dec11')
        out = auxe;
    elseif strcmp(tframe,'aug11dec11')
        out = auxe(:,:,8:12);
    end
    

%% OSCAR -------------------------------------------------------------------
elseif strcmp(dtype,'oscar')
    load ./data/OSCAR/oscar_jan10dec12
    
    % rotate
    auxu = nan(180,360,size(uvel,3));
    auxv = nan(180,360,size(uvel,3));
    for m = 1:size(uvel,3)
        auxu(:,:,m) = rot90(squeeze(uvel(:,:,m)));
        auxv(:,:,m) = rot90(squeeze(vvel(:,:,m)));
    end
    
    if strcmp(tframe,'jan11dec11')
        out = complex(auxu(:,:,13:24),auxv(:,:,13:24));
    elseif strcmp(tframe,'aug11dec11') 
        out = complex(auxu(:,:,20:24),auxv(:,:,20:24));
    end
    lat = flipud(lat);
    
%% JASON SSH ---------------------------------------------------------------
elseif strcmp(dtype,'jason')
    load ./data/SSH/ssh1deg_jan11dec11
    
    % rotate
    out = nan(180,360,size(ssh2011global,3));
    for m = 1:size(ssh2011global,3)
        out(:,:,m) = squeeze(ssh2011global(:,:,m))';
    end
    
    if strcmp(tframe,'aug11dec11')
        out = out(:,:,8:12);
    end
    
end


