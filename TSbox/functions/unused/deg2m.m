%
% [XX YY] = DEG2M(LON,LAT)
% converts degrees latitude/longitue into meters
% needed to calculate e.g. gradients


function [xx,yy] = deg2m(lon,lat)

% xx = lon*111320.*cos(lat*pi/180);
% yy = lat*111320;


xx = lon*111320.*cos(lat*pi/180); % deg2rad: lat*pi/180
yy = lat*110574; %correction Luigi Castaldo
% The approximate conversions are:
% Latitude: 1 deg = 110.574 km
% Longitude: 1 deg = 111.320*cos(latitude) km
% This doesn't fully correct for the Earth's polar flattening -- for that 
% you'd probably want a more complicated formula using the WGS84 reference 
% ellipsoid (the model used for GPS). 
% But the error is probably negligible for this purposes.