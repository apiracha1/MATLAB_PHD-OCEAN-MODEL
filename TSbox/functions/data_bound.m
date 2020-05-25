function [oalpha,obeta,orho,oH,oW,oSSS,oxx,oyy,oSST,olat,olon] = data_bound(ocean,alpha,beta,rho,H,...
                         W,SSS,SST,dxx,dyy,lat,lon)
% data_bound                             restricts variables to chosen ROI
%============================================================
% 
% USAGE:  
% cons_SSS_SST_rho_coeff(SSS,SST,p0,lon,lat)
%                                                   *All variables set
%                                                   through Control_Center
% 
%  Note that cons_SSS_SST_rho_coeff has all variables pre set through
%  choices in Control_Center.
%
% DESCRIPTION:
%  **As of 11/11/2019 
% Function Calculates fields of the thermal and haline expansion and
% cotraction coefficents, respectively. as well as a density field. given
% the input of an SSS field
%
% INPUT:
%  ocean = ocean name           [ string ] 
% [alpha,beta] = thermal and haline expansion and contraction coefficent  [ PSU-1,degC-1 ]
% rho = density field       [ kgm-3 ] 
% [W, H] =  freshwater flux and Total heat     [ 3-D matrix ]
%  [SSS,SST] = the salinity and temperature fields      [ PSU, degC ]
% [dxx,dyy] = distances between lats and lons       [ 2-D matrix ]
% [lon,lat] = latitude and longitude extent of ROI      [ vectors ] 
%  
% OUTPUT:
% all restricted to chosen ROI
% [oalpha,obeta] = thermal and haline expansion and contraction coefficent  [ PSU-1,degC-1 ]
% orho = density field       [ kgm-3 ] 
% [oW,o H] =  freshwater flux and Total heat     [ 3-D matrix ]
%  [oSSS,oSST] = the salinity and temperature fields      [ PSU, degC ]
% [oxx,oyy] = distances between lats and lons       [ 2-D matrix ]
% [lon,lat] = latitude and longitude extent of ROI      [ vectors ] 
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
                     [indx, indy] = basin_bounds(ocean,lat,lon);  
                     %confining variables to region selected

                    if ~isempty(alpha)
                        oalpha = squeeze(alpha(indx,indy,:));
                        obeta = squeeze(beta(indx,indy,:));
                        orho = squeeze(rho(indx,indy,:));                    
                    else
                        oalpha = [];
                        obeta = [];
                        orho = [];
                    end
                    
                    if length(size(H)) > 3
                        oH = squeeze(H(:,indx,indy,:));
                        oW = squeeze(W(:,indx,indy,:));
                        oSSS = squeeze(SSS(:,indy,indx,:));
                        oSST = squeeze(SST(:,indx,indy,:));
                    else
                        oH = squeeze(H(indx,indy,:));
                        oW = squeeze(W(indx,indy,:));
                        oSSS = squeeze(SSS(indx,indy,:));
                        oSST = squeeze(SST(indx,indy,:));
                    end
                        
                    oxx = squeeze(dxx(indx,indy));
                    oyy = squeeze(dyy(indx,indy));
                    olat = lat(indy);
                    olon = lon(indx);

end