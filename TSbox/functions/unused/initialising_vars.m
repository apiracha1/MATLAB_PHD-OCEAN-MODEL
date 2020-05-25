function [H,W,SSS,SST,Fmean_e] = initialising_vars(n_stat,~,~,aa,bb,cc)
% initialising_vars                             Initialises variables to be
%                                                               filled in later 
%============================================================
% 
% USAGE:  
% initialising_vars(n_stat,~,~,aa,bb,cc)
%                                                   *All variables set
%                                                   through Control_Center
% 
%  Note that initialising_vars has all variables pre set through
%  choices in Control_Center.
%
% DESCRIPTION:
%  **As of 11/11/2019 
% Function Initialises data variables i  order to be filled later by
% individual monte-carlo simulation results (computing uncertainty for each
% simulation).
%
% INPUT:
%  n_stat  =  Statistically random point for monte carlo                [ number ]
% [aa,bb,cc] = size of the 3 dimensions of variables    [ number ]
%  
% OUTPUT:
% [H, W] = Total heat and freshwater flux empty         [ 3-D matrix ]
% [SSS,SST] = Salinity and temperature empty        [ 3-D matrix ]
% Fmean_e = empty final variable        [ 3-D matrix ]
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

W = nan(aa,bb,cc);
H = nan(aa,bb,cc);
SSS = nan(aa,bb,cc);
SST = nan(aa,bb,cc);   
Fmean_e = nan(n_stat,aa,bb);

end