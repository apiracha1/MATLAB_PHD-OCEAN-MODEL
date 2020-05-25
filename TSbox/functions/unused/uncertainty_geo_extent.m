function nanmask = uncertainty_geo_extent(Fpeak,n_stat)
% uncertainty_geo_extent                             finds frequency each
%                                                                       grid point occupied by a value
%============================================================
% 
% USAGE:  
% uncertainty_geo_extent(Fpeak,n_stat)
%                                                   *All variables set
%                                                   through Control_Center
% 
% DESCRIPTION:
% Function calculates all parameters from density flux to formation (both
% TS and rho)
%
% INPUT:
% Fpeak = peak temperature salinity area converted to geo space [ matrix ]
% n_stat = number of statistically random points for monte-carlo simulation 
% 
% OUTPUT:
% nanmask = frequency of occupied grid points   [ matrix ]
% 
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1 (Monday 10th February 2020) *******STARTING FRESH COUNT
% NOTES on VERSION:
%
% REFERENCES:
% For calculation of density flux           [ Speer and Tzipermann 1992 ]   
%
% The software is currently in development
%
%============================================================
nanmask = nan(size(Fpeak, 1),size(Fpeak,2));
for l = 1:n_stat
    [i, j] = find (~isnan(Fpeak(:,:,l)));
    for t = 1:length(i)
        if ~isnan(nanmask(i(t),j(t)))
            nanmask(i(t),j(t)) = nanmask(i(t),j(t))+1;
        else
            nanmask(i(t),j(t)) = 1;
        end
    end
end


