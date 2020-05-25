function [Fmean_mean,Fmean_std] = mean_STD_densflux(Fmean_e,lat,lon)
% mean_STD_densflux                            calculates the mean and the
%                                                           STD over the Monte-carlo simulations
%============================================================
% 
% USAGE:  
% mean_STD_densflux(Fmean_e,lat,lon)
%                                                   *All variables set
%                                                   through Control_Center
% 
%  Note that mean_STD_densflux has all variables pre set through
%  choices in Control_Center.
%
% DESCRIPTION:
%  **As of 11/11/2019 
% Function calculates the mean and the median over all monte carlo
% imulations performed
%
% INPUT:
% Fmean_e = density flux for all monte-carlo simulations        [ kgm-1s-2 ]
% [lat,lon] = latitude and longitude    [ vector ]
% 
% OUTPUT:
% [Fmean_mean,Fmean_std] =   mean and STD over all monte-carlo simulations   [ 3-D matrix ]
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
aa = max(size(lat));
bb = max(size(lon));
Fmean_std=zeros(bb,aa);
Fmean_mean=Fmean_std;
for xe=1:bb
    for ye=1:aa
        Fmean_std(xe,ye)  = std(Fmean_e(:,xe,ye));
        Fmean_mean(xe,ye)  = mean(Fmean_e(:,xe,ye));
    end
end

end