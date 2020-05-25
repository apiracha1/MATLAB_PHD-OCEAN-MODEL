function [latitude, longitude, aratio] = colTSreg_v2(ocean)
% colTSreg_v2                                   obtains lat-lon for given
%                                                                               ocean basin
%============================================================
% 
% USAGE:  
% colTSreg_v2(ocean)
%                                                   *All variables set
%                                                   through Control_Center
%
% DESCRIPTION:
% Function extracts correct lat lon for basin given
%
% INPUT:
%  ocean = ocean name           [ string ] 
% 
% OUTPUT:
%  latitude  =  latitude ranges of basin        [ deg ]
%  longitude  =  longitude ranges of basin          [ deg ]
%  aration = ??? 
% 
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1 (Monday 10th February 2020) *******STARTING FRESH COUNT
% NOTES on VERSION:
%                               
%
% REFERENCES:
%
% The software is currently in development
%
%============================================================
if strcmp(ocean,'SO')
    latitude = -79.5:-40.5;
    longitude = 0:359;
%     
    aratio = [3 1 1];
elseif strcmp(ocean,'IO')
    latitude = -40:19;
    longitude = 29:119;
    aratio = [2 1 1];
elseif strcmp(ocean,'SP')
    latitude = -40:-5.5;
    longitude = 109:309;
    aratio = [2 1 1];
elseif strcmp(ocean,'EP')
    latitude = -4.5:4.5;
    longitude = 109:289;
    aratio = [2 1 1];
elseif strcmp(ocean,'NP')
    latitude = 5:59;
    longitude = 119:239;
    aratio = [2 1 1];
elseif strcmp(ocean,'NA')
    latitude = 3:44;
    longitude = -90:-2;
    aratio = [2 1 1];
elseif strcmp(ocean,'NA2')
    latitude = -10:54;
    longitude = -90.5:14.5;
    aratio = [1.25 1 1];
elseif strcmp(ocean,'NAext')
    latitude = -20:54;
    longitude = -90.5:-0.5;
    aratio = [1 1 1];
elseif strcmp(ocean,'SA')
    latitude = -40:-1;
    longitude = -60.5:29.5;
    aratio = [2 1 1];
elseif strcmp(ocean,'TP') %% added luigi castaldo 03.03.2016 
                            % %% Aqeel Piracha (piracha.aqeel1@gmail.com)
                                %  corrected to lat in tropical pacific
    longitude = 120:280;
    latitude = -19:20;
    aratio=[2 1 1];
elseif strcmp(ocean,'all')
    latitude = -89.5:90;
    longitude = 0.5:359.5;
    aratio = [1.7 1 1];
end

