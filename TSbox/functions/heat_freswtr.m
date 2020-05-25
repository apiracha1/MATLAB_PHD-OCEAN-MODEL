function [H,W] = heat_freswtr(lheat,sheat,lwave,swave,evap,precip)
% heat_freswtr                            converts all components of heat
% flux into total heat flux and computes E-P (frehwater flux)
%                                                                                             E-P           [ ms-1 ]
%                                                                                             Total heat flux       [ Wm-2 ]
%============================================================
% 
% USAGE:  
% heat_freswtr(lheat,sheat,lwave,swave,evap,precip)
%                                                   *All variables set
%                                                   through Control_Center
% 
%  Note that heat_freswtr has all variables pre set through
%  choices in Control_Center.
%
% DESCRIPTION:
%  **As of 13/11/2019 
% Function calculates heat and freshwater fluxes from heat component datasets and
%evaporation and precipitation datasets
%
% INPUT:
% [lheat, sheat] =  turbulant components of heat flux     [ 3-D matrix ]
% [lwave, swave] = radiative components of heat flux    [ 3-D matrix ]
% evap = evaporation data       [ 3-D matrix ]
% precip = precipitation data       [ 3-D matrix ]
% 
% OUTPUT:
% [H, W] =   Total heat and freshwater flux   [ 3-D matrix ]
% 
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1 (Wednesday 13th November 2019) *******STARTING FRESH COUNT
% NOTES on VERSION:
% None
%
% REFERENCES:
% None
%
% The software is currently in development
%
%============================================================

           H = lheat + sheat + lwave + swave; % [W/m^2] and positive downward
           precip= precip*24; % [mm/day]
           evap = evap/36.5; % [mm/day]
           W = (evap - precip); % [mm/day] 
           W = W/8.64e7; % [m/s] 

end