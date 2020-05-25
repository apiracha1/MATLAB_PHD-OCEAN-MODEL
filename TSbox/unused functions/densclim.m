%
%
% SIGMA = densclim(SSSIN,SSTIN,TFRAME)
% loads the datasets indicated by the strings SSSIN and SSTIN and calulates 
% density fields (sigma theta, i.e. potential density -1000) 
%
%

function sigma = densclim(sssin,sstin,tframe)

% load SSS and SST
SSS = load_all(sssin,tframe,'SSS');
[SST lat lon] = load_all(sstin,tframe,'SST');

if ~strcmp(sssin,'woa09')
    [lon lat] = meshgrid(lon,lat); 
end
Lon = nan(size(SSS)); Lat = nan(size(SSS));
for m = 1:size(Lon,3)
    Lon(:,:,m) = lon; Lat(:,:,m) = lat;
end
lon = Lon; lat = Lat; clear Lon Lat

  
% calculate absolute salinity and conservative temperature
auxs = nan(size(SSS)); auxt = nan(size(SST));
for m = 1:size(SSS,3)
    auxs(:,:,m) = gsw_SR_from_SP(squeeze(SSS(:,:,m)),0,squeeze(lon(:,:,m)),squeeze(lat(:,:,m)));
    auxt(:,:,m) = gsw_CT_from_t(squeeze(auxs(:,:,m)),squeeze(SST(:,:,m)),0);
end
SSS = auxs; SST = auxt; 

% calculate surface density
rho_surf = gsw_rho_CT(SSS,SST,0);
sigma = rho_surf - 1000;



