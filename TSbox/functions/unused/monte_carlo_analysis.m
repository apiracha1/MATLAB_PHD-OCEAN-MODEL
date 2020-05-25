function monte_carlo_analysis(He,We,SSSe,SSTe,ocean,H,W,SSS,SST,sal,latitude,longitude,lat,lon,...
    month,tframe,n_stat,~,randnumgen,seed,SSS_unc,SST_unc,H_unc,W_unc,fign)
% monte_carlo_analysis                              analyses the uncertainty components from Monte-carlo
%                                                                                  SSS - [ PSU ]
%                                                                                  SST - [ K ]
%                                                                       Heat fluxes - [ W/m^2 ]
%                                                                  Freshw. fluxes - [ mm/day ]
%============================================================
%
% USAGE:
% monte_carlo_analysis(He,We,SSSe,SSTe,ocean,H,W,SSS,SST,sal,latitude,longitude,lat,lon,...
%     month,tframe,n_stat,msg)
%                                                   *All variables set
%                                                   through Control_Center
%
% DESCRIPTION:
%  **As of 16/10/2019
% Function plots the analysis of the uncertainty components from all
% variables from the Monte-carlo simulations
%                                                                       MEAN
%                                                                       MEDIAN
%                                                                       DIFF FROM THE SATELLITE TRUTH
%                                                                                          - MEAN
%                                                                                          - MEDIAN
%                                                                       HISTOGRAM AT USER SELECTED POINT
%
% INPUT:
%  [He We H W] = Heat and freshater flux data with(e)/without error       [ 3-d matrix ]
%  [SSSe SSTe SSS SST] = Salinit and Temperature data with(e)/without error       [ 3-d matrix ]
%  ocean = ocean name       [ string ]
%  sal = salinity dataset name          [ string ]
%  [latitude longitude] = Latitude and Longitude of ROI         [ matrix ]
%  [lat,lon] = global latitudes in dataset resolution   [ vector ]
%  month = month number         [ number ]
%  tframe = time frame/year         [ string ]
%  n_stat  =  Statistically random point for monte carlo                [ number ]
%  msg = handle of message box      [ handle ]
% randnumgen = random number generator used [ string ]
% seed = seeding for random number generator [ number ]
% [SSS_unc,SST_unc,H_unc,W_unc] = dataset uncertainties [ number ]

%
% OUTPUT:
%  None
%
% AUTHOR:
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1 (Monday 10th February 2020) *******STARTING FRESH COUNT
% NOTES on VERSION:
%                                   None
%
% REFERENCES:
% None
%
% The software is currently in development
%
%============================================================

if SSS_unc ~= 0
    geo_plot(latitude,longitude,lat,lon,SSSe,SSS_unc,SST_unc,...
    H_unc,W_unc,tframe,ocean,n_stat,month,'SSS [PSU]',fign,'[PSU]',SSS,...
    'SSS',[32 37],[0 2*nanmean(SSS(:))/100*SSS_unc],0,[],[],[])
elseif SST_unc ~=0
    geo_plot(latitude,longitude,lat,lon,SSTe,SSS_unc,SST_unc,...
    H_unc,W_unc,tframe,ocean,n_stat,month,'SST [\circC]',fign,'[\circC]',SST,...
    'SST',[15 30],[0 2*nanmean(SST(:))/100*SST_unc],0,[],[],[])
elseif H_unc ~= 0
    geo_plot(latitude,longitude,lat,lon,He,SSS_unc,SST_unc,...
    H_unc,W_unc,tframe,ocean,n_stat,month,'Net. Heat flux [Wm^{-2}]',fign,'[Wm^{-2}]',H,...
    'Net. Heat flux ',[-60 130],[0 2*abs(nanmean(H(:)))/100*H_unc],0,[],[],[])
elseif W_unc ~= 0
    geo_plot(latitude,longitude,lat,lon,We,SSS_unc,SST_unc,...
    H_unc,W_unc,tframe,ocean,n_stat,month,'Freshwater flux [ms^{-1}]',fign,'[ms^{-1}]',W,...
    'Freshwater flux ',[-1e-7 2e-7],[0 2*nanmean(W(:))/100*W_unc],0,[],[],[])
end

end