function [H,W,SSS,SST] = fill_init_vars(He,We,SSSe,SSTe,n)
% fill_init_vars                             Filling previously initialised
%                                       variables with output from individual monte-carlo simulations
%============================================================
% 
% USAGE:  
% fill_init_vars(He,We,SSSe,SSTe,n)
%                                                   *All variables set
%                                                   through Control_Center
% 
%  Note that fill_init_vars has all variables pre set through
%  choices in Control_Center.
%
% DESCRIPTION:
%  **As of 11/11/2019 
% Function fills variables by individual monte-carlo simulation results (computing uncertainty for each
% simulation).
%
% INPUT:
% [He,We] = Total heat and fresh water flux for all monte-carlo simulations   [ 4-D matrix ]
% [SSSe,SSTe] = Salinity and temperature for all Monte-Carlo simulations     [4-D matrix ] 
%  n  =  Statistically random point for monte carlo                [ number ]
%  
% OUTPUT:
% [H, W] = Total heat and freshwater flux for current monte-carlo simulation        [ 3-D matrix ]
% [SSS,SST] = Salinity and temperature for current monte-carlo simulation       [ 3-D matrix ]
%
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1 (Monday 11th November 2019) *******STARTING FRESH COUNT
% NOTES on VERSION:
% None
%
% REFERENCES:
% None
%
% The software is currently in development
%
%============================================================
H = He(:,:,n);
W = We(:,:,n);
SSS = SSSe(:,:,n);
SST = SSTe(:,:,n);

end