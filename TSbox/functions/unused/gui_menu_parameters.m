function [parameter_evaporation, parameters_MC, parameters_datasets_SSS,...
    parameters_datasets_SST,...
    parameters_computation, parameters_year, parameters_ocean, parameter_precipitation,...
    parameters_season, parameter_heatfluxls, parameter_radfluxls] = gui_menu_parameters()
% gui_menu_parameters                             initialising
%                                                           empty parameters to be filled in through Control_Center.m
%============================================================
% 
% USAGE:  
% gui_menu_parameters()
%                                                   *called from
%                                                   Control_center.m
%                                                   without input arguments
%
% DESCRIPTION:
%  **As of 04/11/2019 
% Function initialises empty variables that are to be fillled in by the choices for each respective variable 
% by the user. for this purpose, the empty variables produced by this function are filled in via 
% Control_Center.m  
%
% INPUT:
%  None
% 
% OUTPUT:
% parameter_evaporation = to hold evaporation dataset choice        [ vector ]
% parameters_MC = to hold number of MC simulations choosen          [ vector ]
% [parameters_datasets_SSS, parameters_datasets_SST] = to hold SSS and SST
%                                                                                                   datasets choice name    [ vector ]  
% parameters_computation = to hold the function to be run       [ vector ]
% parameters_year = to hold the year chosen for the computation to be run       [ array ]
% parameters_ocean = to hold the basin name over which the computation will
%                                                                                           be run          [ vector ]
% parameter_precipitation = to hold the name of the precipitation dataset
%                                                                   chosen           [ vector ]
% parameters_season = to hold the season over which the computation will be run       [ array ]
% parameter_heatfluxls = to hold the name of the heat flux (turbulant comp.) product chosen    
%                                                                                                                 [ vector ]
% parameter_radfluxls = to hold the name of the heat flux product (radiative comp.) product chosen.
%                                                                                                     [ vector ]
% 
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1.1 (Monday 4th November 2019) *******STARTING FRESH COUNT
% NOTES on VERSION:
%
% REFERENCES:
% None
% 
% The software is currently in development
%
%============================================================

parameter_evaporation = [];
parameters_MC = [];
parameters_datasets_SSS = [];
parameters_datasets_SST = [];
parameters_computation = [];
parameters_year = {};
parameters_ocean = [];
parameter_precipitation = [];
parameters_season = {};
parameter_heatfluxls = [];
parameter_radfluxls = [];

end
