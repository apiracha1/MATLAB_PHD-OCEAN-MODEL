function wm_code_main(n_stat,sal,temp,time_frame,ocean,prec,...
    month,evap_name,hflux,radflux,res)
%=======================================================================================================================
%
% USAGE:
% wm_code_main(n_stat,sal,temp,time_frame,ocean,prec,...
%     seasons,evap_name,hflux,radflux)
%
% DESCRIPTION:
% Main code 
%
% INPUT:
%  n_stat           = # of Monte Carlo simulations     [ number ]
%  sal              = salinity dataset name            [ string ]
%  temp             = temperature dataset name         [ string ]
%  time_frame       = selected year                    [ string ] (FORMAT: jan##dec##, ## = 12 for 2012 e.t.c.)
%  ocean            = ocean name                       [ string ]
%  prec             = precipitation dataset name       [ string ]
%  month            = month number                     [ number ] (from 1 to 12)  
%  evap_name        = evaporation dataset name         [ string ]
%  hflux            = heat flux dataset name           [ string ]
%  radflux          = radiative flux dataset name      [ string ]
%  res              = dataset spatial resolution       [ number ] (degrees)
%  randnumgen       = random number generator          [ string ]
%  seed             = seed for random number           [ number ]
% (SSS,SST,H,W)_unc = dataset uncertainties            [ number ]
%
% OUTPUT:
%  No Output                                     [ none ]
%
% AUTHOR:
%  Aqeel Piracha                                 [ apiracha@btinternet.com ]
%
% VERSION 
% 1           = First made                       [Thursday 10th October 2019] 
%
% REFERENCES:
% No References
%
% The software is currently in development
%
%=======================================================================================================================
%% for debugging
    n_stat = 2000;
    sal = 'smosOA';
    temp = 'GHRSST';
    time_frame = 'jan13dec13';
    ocean = 'NA';
    prec = 'trmm';
    month = 1;
    evap_name = 'oaflux';
    hflux = 'ncep-ncar';
    radflux = 'ncep-ncar';
    res = 1;
    randnumgen = 'simdTwister';
    seed = 0;
    SSS_unc = 0.2;
    SST_unc = 0;
    H_unc = 0;
    W_unc = 0;

%% For all
    [Frho_true,Frho_mean,Frho_std,...
                    gFrho_true,gFrho_mean,gFrho_std,...
                        Fscatt_true,Fscatt_mean,Fscatt_std,...
                            gFscatt_true,gFscatt_mean,gFscatt_std] = wm_all_funcs(n_stat,sal,temp,...
        time_frame,ocean,prec,month,evap_name,hflux,radflux,res,randnumgen,seed,...
        SSS_unc,SST_unc,H_unc,W_unc);

end
