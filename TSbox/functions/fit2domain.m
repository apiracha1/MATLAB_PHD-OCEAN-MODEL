function [dxx,dyy,SSS,SST,H,W,lat,lon] = fit2domain(SSS,SST,H,W,lat,lon,ocean)
%=======================================================================================================================
%
% USAGE:
% fit2domain(SSS,SST,H,W,lat,lon,ocean)
%
% DESCRIPTION:
% fitting variables to domain 
%
% INPUT:
% (SSS,SST,H,W) = salinity,temperature,heat and frehwater flux [ PSU/degC/Mm^-2/ms^-1 ]
% (lon,lat)     = longitude-latitude                           [ degE-degN ]
%  ocean        = ocean name                                   [ string ]
%
% OUTPUT:
% (dxx,dyy) = spacing lat - spacing lon                        [ m ]
% (SSS,SST,H,W) = salinity,temperature,heat and frehwater flux [ PSU/degC/Mm^-2/ms^-1 ]
% (lon,lat)     = longitude-latitude                           [ degE-degN ]
% 
% 
% AUTHOR:
%  Aqeel Piracha                                 [ apiracha@btinternet.com ]
%
% VERSION 
% 1           = First made                       [ Thursday 10th October 2019 ] 
% 2           = neatened                         [ Wedneday 22nd April 2020 ]
%
% REFERENCES:
% No References
%
% The software is currently in development
%
%=======================================================================================================================

    [xx,yy] = deg2m(lon,lat);       % Converting latitudes and longitudes to distances      [ m ]
    dxx = diff(xx,1,2); dxx(:,360) = dxx(:,359);        % lon differences betwe. distances    [ m ]
    dyy = diff(yy,1,1); dyy(180,:) = dyy(179,:);        % lat differences betwe. distances  [ m ]
    [~,~,~,H,W,SSS,~,~,SST,lat,lon] = data_bound(ocean,[],[],[],H,W,SSS,SST,dxx,...
        dyy,lat(:,1),lon(1,:));

end