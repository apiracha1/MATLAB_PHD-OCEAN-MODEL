function [SSS,SST,H,W,lon,lat] = load_ds(sal,temp,evap_name,prec,hflux,radflux,...
    res,time_frame)
%=======================================================================================================================
%
% USAGE:
% load_ds(sal,temp,evap_name,prec,hflux,hrad,res,tframe)
%
% DESCRIPTION:
% loading datasets 
%
% INPUT:
%  sal              = salinity dataset name            [ string ]
%  temp             = temperature dataset name         [ string ]
%  evap_name        = evaporation dataset name         [ string ]
%  prec             = precipitation dataset name       [ string ]
%  hflux            = heat flux dataset name           [ string ]
%  radflux          = radiative flux dataset name      [ string ]
%  res              = dataset spatial resolution       [ number ] (degrees)
%  time_frame       = selected year                    [ string ] (FORMAT: jan##dec##, ## = 12 for 2012 e.t.c.)
%
% OUTPUT:
% (SSS,SST,H,W) = salinity,temperature,heat and frehwater flux [ PSU/degC/Mm^-2/ms^-1 ]
% (lon,lat)     = longitude-latitude                           [ degE-degN ]
% 
% AUTHOR:
%  Aqeel Piracha                                 [ apiracha@btinternet.com ]
%
% VERSION 
% 1           = First made                       [Thursday 10th October 2019] 
% 2           = neatened                         [ Wedneday 22nd April 2020 ]
% 
% REFERENCES:
% No References
%
% The software is currently in development
%
%=======================================================================================================================

% salinity
    SSS = loading_datasets(sal,'SSS',[],time_frame,res,12,10);  
    
% temperature    
    SST = loading_datasets(temp,'SST',[],time_frame,res,12,4);  
    SST = SST - 273.15;
    
% latitude-longitude
    lon = -180:res:179.9;
    lat = -90:res:89.9;
    
% evaporation  
    evap = loading_datasets(evap_name,'Evaporation',[],time_frame,res,12,4); 

% precipitation    
    precip = loading_datasets(prec,'Precipitation',[],time_frame,res,12,1);

%% Heat and freshwater fluxes    
% latent
    lheat = loading_datasets(hflux,'Heat_flux','Latent_Heat',time_frame,res,12,4);
    
% sensible
    sheat = loading_datasets(hflux,'Heat_flux','Sensible_Heat',time_frame,res,12,4);
    
% long wave
    lwave = loading_datasets(radflux,'Heat_flux','Longwave',time_frame,res,12,4);
    
% short wave
    swave = loading_datasets(radflux,'Heat_flux','Shortwave',time_frame,res,12,4);
    
% heat and freshwater
    [H,W] = heat_freswtr(lheat,sheat,lwave,swave,evap,precip);     

end