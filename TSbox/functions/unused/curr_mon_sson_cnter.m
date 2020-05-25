function [month,season] = curr_mon_sson_cnter(months,month,monthss,seasons)
% curr_mon_sson_cnter                             extraxcts current month
%                                                                               and season from array
%============================================================
% 
% USAGE:  
% curr_mon_sson_cnter(months,month,monthss,seasons)
%                                                   *All variables set
%                                                   through Control_Center
% 
%  Note that curr_mon_sson_cnter has all variables pre set through
%  choices in Control_Center.
%
% DESCRIPTION:
%  **As of 11/11/2019 
% Function gets the name for the season/month user has chosen and the
% corresponding months/month of the season and extracts from array. 
%
% INPUT:
%  seasons  =  user initial choice for season          [ Char array ]
% months = month number/s       [ array ]
% month = current month in loop     [ number ]
% monthss = current position in  months array   [ number ]
% seasons = season title     [ string ]
%  
% OUTPUT:
% season = current season title     [ string ]
% month = month number/s       [ number ]
% 
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1.1 (Thursday 21st November 2019) *******STARTING FRESH COUNT
% NOTES on VERSION:
% None
%
% REFERENCES:
% None
%
% The software is currently in development
%
%============================================================

 if length(months) > 1
                    month = month{1};
                    season = seasons{monthss};
                else
                    season = seasons{1};
                    month = month{1};
 end
end