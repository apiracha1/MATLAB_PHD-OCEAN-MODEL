function [dT,dS,T,S,sigma,p0,cp,latitude,longitude,rho_e,SSS_e,...
    SST_e,F_e] = var_param(ocean,n_stat,lat,lon)
%=======================================================================================================================
%
% USAGE:
% var_param(ocean,n_stat,lat,lon)
%
% DESCRIPTION:
% Initialising variables and returning parameters 
%
% INPUT:
%  ocean    = ocean name                       [ string ]
%  n_stat   = # of Monte Carlo simulations     [ number ]
% (lat,lon) = latitude-longitude               [ vector ] (degrees)
%
% OUTPUT:
% (dT,dS)                = temperature and salinity/density bin width        [ degC/PSU/kgm^-3 ]
% (T,S,sigma)            = temperature, salinity and density sampling range  [ degC/PSU/kgm^-3 ]
% p0                     = pressure                                          [ mbars ] 
% cp                     = specific heat capacity of water                   [ J/Kkg ] 
% (latitude,longitude)   = latitude-longitude                                [ degN-degE ]
% (rho_e,SSS_e,SST_e,F_e = initialised datasets for Monte-Carlo              [ matrix ]
% 
% AUTHOR:
%  Aqeel Piracha                                 [ apiracha@btinternet.com ]
%
% VERSION 
% 1           = First made                       [ Thursday 10th October 2019 ] 
% 2           = neatened                         [ Wedneday 22nd April 2020 ]
%
% REFERENCES:
% No References
%
% The software is currently in development
%
%=======================================================================================================================
%% Variables
% latitude-longitude
    [latitude, longitude] = colTSreg_v2(ocean);

% density     
    rho_e = nan(1425,705,n_stat);

% salinity
    SSS_e = nan(1425,705,n_stat);

% temperature
    SST_e = nan(1425,705,n_stat);

% density flux
    F_e = nan(1425,705,n_stat);
    
%% parameters
    cp = 3991.86795711963;      
    p0 = 0;     

% temperature salinity bin spacing    
    dT = 0.5; dS = 0.1;
    T = -2:dT:35; S = 30:dS:40;
    sigma = (20:dS:28)+1000;

end