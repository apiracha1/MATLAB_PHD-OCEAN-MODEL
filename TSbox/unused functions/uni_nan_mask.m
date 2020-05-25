%
%
% [mask] = uni_nan_mask(ws)
% ensures that data has the same missing values
% input ws can either be 0 or 1 and idicates if wind speed products are
% included (1) into the nan mask or not (0)
%
%

function [mask] = uni_nan_mask(ws)

SSSsmos = load_all('smosOI','jan11dec11');
SSTostia = load_all('ostia','jan11dec11');
SSSargo = load_all('argoNRT','jan11dec11','SSS');
SSTargo = load_all('argoNRT','jan11dec11','SST');
% SSSwoa = load_all('woa09','jan11dec11','SSS');
% SSTwoa = load_all('woa09','jan11dec11','SST');
% SSSaq = load_all('aqOI','aug11dec11'); SSSaqua = zeros(size(SSSsmos));
% SSSaqua(:,:,8:12) = SSSaq;

precip = load_all('cmorph','jan11dec11');
if ws == 1
    %wsat = load_all('wsat','jan11dec11','WS');
    %ascat = load_all('ascat','jan11dec11','WS');
%     ssmi = load_all('ssmi','jan11dec11','WS');
end
evap = load_all('oaflux','jan11dec11','evap');
lheat = load_all('nocs','jan11dec11','lheat');
sheat = load_all('nocs','jan11dec11','sheat');
lwave = load_all('nocs','jan11dec11','lwave');
swave = load_all('nocs','jan11dec11','swave');

%uv = load_all('oscar','jan11dec11');

%
mask = zeros(size(SSSsmos));
mask(isnan(SSSsmos)) = nan;
mask(isnan(SSTostia)) = nan;
mask(isnan(SSSargo)) = nan;
mask(isnan(SSTargo)) = nan;
%

% mask(isnan(SSSwoa)) = nan;
% mask(isnan(SSTwoa)) = nan;
% mask(isnan(SSSaqua)) = nan;
mask(isnan(precip)) = nan;
if ws == 1
    %mask(isnan(wsat)) = nan;
    %mask(isnan(ascat)) = nan;
%     mask(isnan(ssmi)) = nan;
end
mask(isnan(evap)) = nan;
mask(isnan(lheat)) = nan;
mask(isnan(sheat)) = nan;
mask(isnan(swave)) = nan;
mask(isnan(lwave)) = nan;
%mask(isnan(uv)) = nan;

for m = 1:12
    for j = 1:size(mask,1)
        for i = 1:size(mask,2)
            if isnan(mask(j,i,m))
                mask(j,i,:) = nan;
            end
        end
    end
end


    
    
    
    
    
