function tframe = curr_time_frm(time_frame,tframe)
% curr_time_frm                             selects current time frame/year in loop and converts to string out
%                                                                         out of array
%============================================================
% 
% USAGE:  
% curr_time_frm(time_frame,tframe)
%                                                   *All variables set
%                                                   through Control_Center
% 
%  Note that curr_time_frm has all variables pre set through
%  choices in Control_Center.
%
% DESCRIPTION:
%  **As of 21/11/2019 
% Function selects the current time frame in the loop to contine with
% loading corresponding datasets for specific time period chosen
%
% INPUT:
%  time_frame = selected year           [ char array ] (FORMAT: jan##dec##, ## = 12 for 2012 e.t.c.)
%  tframe = current year           [ char array ] (FORMAT: jan##dec##, ## = 12 for 2012 e.t.c.)
% 
% OUTPUT:
%  tframe = current year           [ string ] (FORMAT: jan##dec##, ## = 12 for 2012 e.t.c.)
%
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1 (Thursday 21st October 2019) *******STARTING FRESH COUNT
% NOTES on VERSION:
% 1.1 (Thursday 21st November 2019) finding bounds dynamically by altering
%                                                           finding correct indices from lat lon fields
%
% REFERENCES:
% None
%
% The software is currently in development
%
%============================================================

        if length(time_frame) > 1
            tframe = tframe{1};
        else
            tframe = tframe{1};
        end
end