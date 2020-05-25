function map_basin(latitude,longitude,ocean,lat,lon,data)
% map_basin                              correctly maps ROI
%============================================================
% 
% USAGE:  
% map_basin(latitude,longitude,ocean)
%                                                   *All variables set
%                                                   through Control_Center
% 
% DESCRIPTION:
% Function correctly displays worldmap around ROI
%
% INPUT:
%  [latitude,longitude,lat,lon] = Latitude and Longitude of ROI output from colTSreg_v2 and 
%                                                   basin_bounds        [ vector ]
%  ocean = ROI's name       [ string ] 
%  data = data to be plotted    [ matrix ]

% OUTPUT:
%  None
%
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1 (Monday 10th February 2020) *******STARTING FRESH COUNT
% NOTES on VERSION:
%
% REFERENCES:
% None 
%
% The software is currently in development
%
%============================================================

                if strcmp (ocean,'SO')
                    worldmap ([-90 latitude(end)],...
                        [longitude(1) longitude(end)])
                elseif strcmp (ocean,'all')
                    worldmap world
                else
                    worldmap ([latitude(1) latitude(end)],...
                        [longitude(1) longitude(end)])
                end
                
                pcolorm(lat,lon,data)
                
                land = shaperead('landareas.shp','UseGeoCoords',true);
                geoshow(land,'FaceColor',[0.8 0.8 0.8])

end