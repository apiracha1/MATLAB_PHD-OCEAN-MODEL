function [He,We,SSSe,SSTe] =  error_computation(W,H,SSS,SST,n_stat,month,~,~,...
    ~,~,~,~,~,~,SSS_unc,SST_unc,H_unc,W_unc,randnumgen,seed)
% error_computation                            applies random statistical sampling to inputted variable fields 
%                                                                         using the Monte Carlo Method.
%============================================================
% 
% USAGE:  
% error_computation(W,H,SSS,SST,n_stat)
%                                                   *All variables set
%                                                   through Control_Center
% 
%  Note that error_computation has all variables pre set through
%  choices in Control_Center.
%
% DESCRIPTION:
%  **As of 11/11/2019 
% Function applies statistical random sampling via the monte carlo method
% in order to introduce uncertainties into inputted datasets.
%
% INPUT:
% [W, H] =  freshwater flux and Total heat     [ 3-D matrix ]
% [SSS,SST] = Salinity and temperature         [ 3-D matrix ]
% n_stat = number of statistically random points        [ number ] 
% res = dataset resolution   [ number ]
% tframe = selected year           [ string ] (FORMAT: jan##dec##, ## = 12 for 2012 e.t.c.)
%  sal  =  salinity dataset name            [ string ] (***SMOS OA and SMOS binned (10/10/2019)
%  temp   =  temperature dataset name           [ string ]
%  evap_name = evaporation dataset name             [ string ]
%  prec = precipitation dataset name            [ string ]
%  hflux = product name of turbulant heat fluxes        [ string ]
%  hrad = product name of radiant heat fluxes       [ string ]
% 
% OUTPUT:
% [He, We] =   Total heat and freshwater flux after monte-carlo simulations   [ 3-D matrix ]
% [SSSe,SSTe] = Salinity and temperature  after monte-carlo simulations       [ 3-D matrix ]
% 
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1.1 (Thursday 19th November 2019) *******STARTING FRESH COUNT
% NOTES on VERSION:
% 1.1 (Thursday 19th November 2019) Improved performance (now uses less
%                                                                                                           ram)
%
% REFERENCES:
% None
%
% The software is currently in development
%
%============================================================
%% standard routine
msg = msgbox('Please wait while simulation is running');
[SSSe,SSTe,He,We] = monte_carlo_sim(n_stat,...
    SSS,SST,H,W,month,SSS_unc,SST_unc,H_unc,W_unc,randnumgen,seed);
close(msg)
end