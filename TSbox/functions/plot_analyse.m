function plot_analyse(SSS,SST,H,W,SSS_e,SST_e,He,We,rho,rho_e,Frho_true,Frho_e,...
    gFrho_true,gFrho_e,Fscatt_true,Fscatt_e,...
            gFscatt_true,gFscatt_e,SSS_unc,SST_unc,H_unc,W_unc,tframe,month,n_stat,...
                lat,lon,dS,dT,ocean,...
                    dxx,dyy,sigma)
%=======================================================================================================================
%
% USAGE:
% plot_analyse(SSS,SST,H,W,SSS_e,SST_e,H_e,W_e,rho,rho_e,Frho_true,Frho_e,...
%     gFrho_true,gFrho_e,Fscatt_true,Fscatt_e,...
%             gFscatt_true,gFscatt_e,SSS_unc,SST_unc,H_unc,W_unc,time_frame,month,n_stat,...
%     lat,lon,dS,dT,ocean,...
%     dxx,dyy,sigma)
%
% DESCRIPTION:
% Plotting function
%
% INPUT:
%  n_stat                          = # of Monte Carlo simulations     [ number ]
%  time_frame                      = selected year                    [ string ] (FORMAT: jan##dec##, ## = 12 for 2012
%  ocean                           = ocean name                       [ string ]
%  month                           = month number                     [ number ] (from 1 to 12)  
%  (SSS,SST,H,W)_unc                = dataset uncertainties            [ number ]
%  (F,F_e)                         = density flux (ref,MC)            [ kg/m^2s ]
%  sigma                           = denity classes                   [ kg/m^3 ] 
%  (rho,rho_e)                     = density data (ref,MC)            [ kg/m^3 ]
%  n_stat                          = # of Monte Carlo simulations     [ number ]
%  dS                              = density/salinity bin width       [ kg/m^3 / PSU ]
%  (dxx,dyy)                       = distance (latitude,longitude     [ m ]
%  S                               = salinity classes                 [ PSU ] 
%  (SSS,SSS_e)                     = salinity data (ref,MC)           [ PSU ]
%  T                               = temperature classes              [ degC ] 
%  (SST,SST_e)                     = temperature data (ref,MC)        [ degC ]
%  dT                              = temperature bin width            [ degC ]
%  (Frho,gFrho,Fscatt,gFscatt)_true = ref. trans(formation) in density and
%               temperature-salinity space                            [ sv = 1e6 m^3s^-1 ] 
%  (Frho,gFrho,Fscatt,gFscatt)_e = MC trans(formation) in density and
%               temperature-salinity space                            [ sv = 1e6 m^3s^-1 ]            
%
% OUTPUT:
% None
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
% salinity
    init_var_analysis(SSS,SSS_e,tframe,month,n_stat,SSS_unc,SST_unc,H_unc,W_unc,'SSS',lat,lon,1,dS/10,'[PSU]',...
        3*SSS_unc)
    var_true_pert(SSS,SSS_e,SSS_unc,SST_unc,H_unc,W_unc,tframe,month,n_stat,1,[32,37.5],'SSS [PSU]',...
        {linspace(32,37,40) linspace(32,37,40)},40)
    
% temperature
    init_var_analysis(SST,SST_e,tframe,month,n_stat,SSS_unc,SST_unc,H_unc,W_unc,'SST',lat,lon,1,dT/10,'[\circC]',...
        3*SST_unc)
    var_true_pert(SST,SST_e,SSS_unc,SST_unc,H_unc,W_unc,tframe,month,n_stat,1,[16,27],'SST [\circC]',...
        {linspace(16,27,40) linspace(16,27,40)},40)
    
% heat flux
    init_var_analysis(H,He,tframe,month,n_stat,SSS_unc,SST_unc,H_unc,W_unc,'Heat Flux',lat,lon,1,H_unc/5,...
        '[Wm^{-2} (Positive Down)]',3*H_unc)
    var_true_pert(H,He,SSS_unc,SST_unc,H_unc,W_unc,tframe,month,n_stat,1,[-200,200],...
        'H [Wm^{-2}] (Positive down)',...
        {linspace(-200,200,40) linspace(-200,-200,40)},40)

% freshwater flux
    init_var_analysis(W,We,tframe,month,n_stat,SSS_unc,SST_unc,H_unc,W_unc,'Freshwater Flux',lat,lon,1,W_unc/5,...
        '[ms^{-1} (Positive Down)]',3*W_unc)
    var_true_pert(W,We,SSS_unc,SST_unc,H_unc,W_unc,tframe,month,n_stat,1,[-2e-7,2e-7],...
        'W [ms^{-1}] (Positive down)',...
        {linspace(-5e-8,5e-8,40) linspace(-5e-8,5e-8,40)},40)

%% Density
    init_var_analysis(rho-1000,rho_e-1000,tframe,month,n_stat,SSS_unc,SST_unc,'\rho',lat,lon,1,dS/10,'[kgm^{-3}]')
    var_true_pert(rho-1000,rho_e-1000,SSS_unc,SST_unc,tframe,month,n_stat,1,[20,28],'\rho [kgm^{-3}]',...
        {linspace(20,28,40) linspace(20,28,40)},40)
    hist_analysis(rho,rho_e,sigma,n_stat,month,tframe,SSS_unc,SST_unc,0.1,1)
% (areas and number of points)
    area_density(rho,rho_e,sigma,dxx,dyy,n_stat,ocean,0.1,1)
    
%% Density flux

%% Transformation
    init_var_analysis(Frho_true,Frho_e,tframe,month,n_stat,SSS_unc,SST_unc,H_unc,W_unc,'Transformation',lat,...
        lon,1,dS/5,...
        '[Sv]',5)
    var_true_pert(Frho_true,Frho_e,SSS_unc,SST_unc,H_unc,W_unc,tframe,month,n_stat,1,[-25,10],...
        'Transformation [Sv]',...
        {linspace(-25,10,40) linspace(-25,10,40)},40)

%% Formation
    init_var_analysis(gFrho_true,gFrho_e,tframe,month,n_stat,SSS_unc,SST_unc,H_unc,W_unc,'Formation',lat,...
        lon,1,dS/5,...
        '[Sv]',3)
    var_true_pert(gFrho_true,gFrho_e,SSS_unc,SST_unc,H_unc,W_unc,tframe,month,n_stat,1,[-10,10],...
        'Formation [Sv]',...
        {-10:3:10 -10:3:10})

%% Maps


end