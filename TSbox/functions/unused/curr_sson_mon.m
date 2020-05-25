function [seasons,months] = curr_sson_mon(seasons)
% curr_sson_mon                             Gets season name and month
%                                                           numbers for user selected season
%============================================================
% 
% USAGE:  
% curr_sson_mon(seasons)
%                                                   *All variables set
%                                                   through Control_Center
% 
%  Note that curr_sson_mon has all variables pre set through
%  choices in Control_Center.
%
% DESCRIPTION:
%  **As of 11/11/2019 
% Function gets the name for the season/month user has chosen and the
% corresponding months/month of the season
%
% INPUT:
%  seasons  =  user initial choice for season          [ string ]
%  
% OUTPUT:
% season = season title     [ string ]
% month = month number/s       [ array ]
% 
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1.1 (Thursday 21st November 2019) *******STARTING FRESH COUNT
% NOTES on VERSION:
% 1.1 (Thursday 21st November 2019) Ability to choose any month
%
% REFERENCES:
% None
%
% The software is currently in development
%
%============================================================
    if strcmp(seasons,'JFM')
                seasons = {'JFM'};
                months = {1:3};
            elseif strcmp(seasons,'AMJ')
                seasons = {seasons};
                months = {4:6};
            elseif strcmp(seasons,'JAS')
                seasons = {seasons};
                months = {7:9};        
            elseif strcmp(seasons,'OND')
                seasons = {seasons};
                months = {10:12};  
            elseif strcmp(seasons,'all')
                seasons = {seasons};
                months = {1:12};
            elseif strcmp(seasons,'Jan')
                seasons = {seasons};
                months = {1};
            elseif strcmp(seasons,'Feb')
                seasons = {seasons};
                months = {2};
            elseif strcmp(seasons,'Mar')
                seasons = {seasons};
                months = {3};        
            elseif strcmp(seasons,'Apr')
                seasons = {seasons};
                months = {4};  
            elseif strcmp(seasons,'May')
                seasons = {seasons};
                months = {5};
            elseif strcmp(seasons,'Jun')
                seasons = {seasons};
                months = {6};
            elseif strcmp(seasons,'Jul')
                seasons = {seasons};
                months = {7};
             elseif strcmp(seasons,'Aug')
                seasons = {seasons};
                months = {8};
            elseif strcmp(seasons,'Sep')
                seasons = {seasons};
                months = {9};
            elseif strcmp(seasons,'Oct')
                seasons = {seasons};
                months = {10};
            elseif strcmp(seasons,'Nov')
                seasons = {seasons};
                months = {11};
            elseif strcmp(seasons,'Dec')
                seasons = {seasons};
                months = {12};
    end
end