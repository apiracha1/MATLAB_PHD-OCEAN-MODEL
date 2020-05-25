function [F] = densflux_geo_space(oalpha,oH,cp,obeta,orho,oW,oSSS)
% densflux_geo_space                                            calculation for deriving density flux from data     [ kgm-1s-2 ]
%                                                                   1/11/2019
%============================================================
% 
% USAGE:  
% densflux_geo_space(oalpha,oH,cp,obeta,orho,oW,oSSS,month,...
%                          n,Fmean,Fmean_e)
%                                                   *All variables set
%                                                   through Control_Center
% 
%  Note that densflux_geo_space has all variables pre set through
%  choices in Control_Center.
%
% DESCRIPTION:
%  **As of 1/11/2019 
% Function derives calculation of density flux in geographic space given an
% area of interest (Ocean Basin). Function is given a number of
% statistically random point that is currently in the loop of the calling
% function (if choosen). returns 3-d matrix of (stat. rand. points,
% latitude, longitude). In other words, spatial density flux output from all
% statistical random points (monte carlo simulations).
% months
% 
% INPUT:
%  [oalpha, obeta] = thermal and haline expansion and contraction coeff.
%                                   for all grid points in ocean basin      [ 3-D matrix ]
%  [ oH, oW ] = total heat flux and Freshwater flux (E-P) over the Ocean
%                                   basin      [ 3-D matrix ]
%  oSSS = Salinity for the ocean basin      [ 3-D matrix ] 
%  cp = Heat capacity of water      [ number ]
%                                   MC simulation    [ 3-D matrix ]
% 
% OUTPUT:
%  F = density flux [ 3-D matrix ]
%
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1 (Thursday 10th October 2019) ******STARTING FRESH COUNT
%
% REFERENCES:
% For calculation of density flux           [ Speer and Tzipermann 1992 ]   
%
% The software is currently in development
%
%============================================================
                 

                    F = -oalpha.*oH/cp  +  obeta.*orho.*oW.*oSSS./...
                        (1-oSSS*1e-3);
end