function [Frho_true,Frho_mean,Frho_std,...
                gFrho_true,gFrho_mean,gFrho_std,...
                    Fscatt_true,Fscatt_mean,Fscatt_std,...
                        gFscatt_true,gFscatt_mean,gFscatt_std] = wm_all_funcs(n_stat,sal,temp,...
    tframe,ocean,prec,month,evap_name,hflux,radflux,res,randnumgen,seed,...
    SSS_unc,SST_unc,H_unc,W_unc)
%=======================================================================================================================
%
% USAGE:
% wm_all_funcs(n_stat,sal,temp,...
%     tframe,ocean,prec,month,evap_name,hflux,radflux,res,randnumgen,seed,...
%     SSS_unc,SST_unc,H_unc,W_unc)
%
% DESCRIPTION:
% Code containing all functions
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
%  res              = dataset spatial resolution       [ degrees ]
%  randnumgen       = random number generator          [ string ]
%  seed             = seed for random number           [ number ]
% (SSS,SST,H,W)_unc = dataset uncertainties            [ number ]
%
% OUTPUT:
% (Frho,gFrho,Fscatt,gFscatt)_true = ref. trans(formation) in density and
%               temperature-salinity space             [ sv = 1e6 m^3s^-1 ]
% (Frho,gFrho,Fscatt,gFscatt)_mean = mean trans(formation) in density and
%               temperature-salinity space             [ sv = 1e6 m^3s^-1 ]
% (Frho,gFrho,Fscatt,gFscatt)_std  = ref. trans(formation) in density and
%               temperature-salinity space             [ sv = 1e6 m^3s^-1 ]
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
%% For debugging
    load(...
    '/home/ap/PHD-BEC/ESA/smos_box/TSdiag/Variables/1_degree/jan13dec13/Jan/All_variables.mat',...
    'SST','SSS','SSS_WOA01','SSS_WOA18','H','W','lat','lon','dxx','dyy')

% salinity
    SSS = SSS(:,:,month);
    % SSS = SSS_WOA01;
    % SSS = SSS_WOA18;

%     SSS = nanmean(SSS,3);
    % SSS = nanmean(SSS_WOA01,3);
    % SSS = nanmean(SSS_WOA18,3);

%     SSS = gsw_SA_from_SP(SSS,0,lon,lat);

% temperature
    % SST = SST - 273.15;
    SST = nanmean(SST,3) - 273.15;
%     SST = gsw_CT_from_t(SSS,SST,0);

% heat flux
    H = nanmean(H,3);

% freshwater flux
    W = nanmean(W,3);

%% Starting code
    [dT,dS,T,S,sigma,p0,cp,latitude,longitude,rho_e,SSS_e,...
        SST_e,F_e] = var_param(ocean,n_stat,lat,lon);

%% Loading data
%     [SSS,SST,H,W,lon,lat] = load_ds(sal,temp,evap_name,prec,hflux,hrad,res,tframe);
%     [dxx,dyy,SSS,SST,H,W,lat,lon] = fit2domain(SSS,SST,H,W,lat,lon,ocean);
%                      initial_maps(H,W,SSS,SST,latitude,longitude,1,sal,month,ocean,lat,lon,tframe,2)

%% Monte-Carlo simulation
    [He,We,SSSe, SSTe] =  error_computation(W,H,SSS,...
            SST,n_stat,month,res,tframe,sal,temp,evap_name,prec,hflux,radflux,...
            SSS_unc,SST_unc,H_unc,W_unc,randnumgen,seed);

%% Computing perturbed variables from Monte-Carlo
    f = waitbar(0,'Please wait...');
    tic
    for n = 1:n_stat
        waitbar(n/n_stat,f,['MC = ',num2str(n),'/',num2str(n_stat)])
        [H,W,SSS,SST] = fill_init_vars(He,We,SSSe,SSTe,n);
        [rho,alpha,beta] = gsw_rho_alpha_beta(SSS,SST,0);
        F = densflux_geo_space(alpha,H,cp,beta,rho,W,SSS);

        rho_e(:,:,n) = rho;
        SSS_e(:,:,n) = SSS;
        SST_e(:,:,n) = SST;
        F_e(:,:,n) = F;
    end
    x = toc;
    msg1 = msgbox([num2str(n_stat),' simulations took ',num2str(x),' seconds to run.'],...
        'INFO');
    pause(2)
    close(f)
    close(msg1)
%% Loading and calc. ref. variables
    load('/home/ap/PHD-BEC/ESA/smos_box/TSdiag/Variables/1_degree/jan13dec13/Jan/All_variables.mat',...
        'SST','SSS','SSS_WOA01','SSS_WOA18','H','W')

% salinity
    SSS = SSS(:,:,month);
    % SSS = SSS_WOA01(:,:,month);
    % SSS = SSS_WOA18(:,:,month);

%     SSS = nanmean(SSS,3);
    % SSS = nanmean(SSS_WOA01,3);
    % SSS = nanmean(SSS_WOA18,3);

    SSS = gsw_SA_from_SP(SSS,p0,lon,lat);

% temperature
    % SST = SST(:,:,month);
    SST = nanmean(SST,3)-273.15;

    SST = gsw_CT_from_t(SSS,SST,p0);

% heat flux
    H = nanmean(H,3);

% freshwater flux
    W = nanmean(W,3);

% density, expansion and contraction coeff.
    [rho,alpha,beta] = gsw_rho_alpha_beta(SSS,SST,0);

% density flux
    F = densflux_geo_space(alpha,H,cp,beta,rho,W,SSS);

%% Calculating (Trans)formation
    [Frho_true,Frho_e,...
            gFrho_true,gFrho_e,...
                Fscatt_true,Fscatt_e,...
                    gFscatt_true,gFscatt_e] = all_variables_error(SSS,SSS_e,SST,SST_e,F,F_e,T,S,...
                                        sigma,dxx,dyy,dT,dS,rho,rho_e,n_stat);

%% Plotting and Analysis of variables
    plot_analyse(SSS,SST,H,W,SSSe,SSTe,He,We,rho,rho_e,Frho_true,Frho_e,...
        gFrho_true,gFrho_e,Fscatt_true,Fscatt_e,...
                gFscatt_true,gFscatt_e,SSS_unc,SST_unc,H_unc,W_unc,time_frame,month,n_stat,...
                    lat,lon,dS,dT,ocean,...
                        dxx,dyy,sigma)
end
