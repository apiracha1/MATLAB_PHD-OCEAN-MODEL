function [indx, indy]=basin_bounds(ocean,lat,lon)
% basin_bounds                             restricts latitudes and longitudes by ROI          
%============================================================
% 
% USAGE:  
% basin_bounds(ocean,lat,lon)
%                                                   *All variables set
%                                                   through Control_Center
% 
%  Note that basin_bounds has all variables pre set through
%  choices in Control_Center.
%
% DESCRIPTION:
%  **As of 21/11/2019 
% Function restricts the latitudes and longitudes of global variable fields
% by region selected by user
%
% INPUT:
%  ocean = ocean name           [ string ] 
%  [lat,lon] = global latitudes in dataset resolution   [ vector ]
% 
% OUTPUT:
%  [indx,indy] = restricted latitudes and longitude         
%
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1 (Thursday 21st October 2019) *******STARTING FRESH COUNT
% NOTES on VERSION:
% None
%
% REFERENCES:
% None
%
% The software is currently in development
%
%============================================================

if strcmp(ocean,'SO')
    indx = 1:360;    indy = 11:50;              % Southern Ocean
elseif strcmp(ocean,'IO')
    indx = 30:120;   indy = 51:110;            % Indian Ocean
elseif strcmp(ocean,'all')
    indx = 1:360;   indy = 1:180;            % Indian Ocean
elseif strcmp(ocean,'SP')
    indx = 110:310;  indy = 51:85;             % South Pacific
elseif strcmp(ocean,'EP')
    indx = 110:290;  indy = 86:95;             % Equatorial Pacific
elseif strcmp(ocean,'TP')                      
    indx = 120:280;  indy = 71:110;            % Tropical Pacific
elseif strcmp(ocean,'NP')
    indx = find(lon>=120 & lon <= 240);      % North Pacific
    indy = find(lat>=-5 & lat <= 59);
elseif strcmp(ocean,'SA')
    indx = [1:30 300:360]; indy = 51:90;       % South Atlantic
elseif strcmp(ocean,'NA')
    indx = find(lon>=-90.5 & lon <= -0.5);  
    indy = find(lat>=0 & lat <= 44);      % North Atlantic
end
end
