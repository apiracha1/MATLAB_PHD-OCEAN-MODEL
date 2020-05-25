function [Frho_true,Frho_e,...
            gFrho_true,gFrho_e,...
                Fscatt_true,Fscatt_e,...
                    gFscatt_true,gFscatt_e] = all_variables_error(SSS,SSS_e,SST,SST_e,F,F_e,T,S,...
                       sigma,dxx,dyy,dT,dS,rho,rho_e,n_stat)
%=======================================================================================================================
%
% USAGE:
% all_variables_error(SSS,SSS_e,SST,SST_e,F,F_e,T,S,...
%                        sigma,dxx,dyy,dT,dS,rho,rho_e,n_stat)%
% 
% DESCRIPTION:
% Code containing all functions 
%
% INPUT:
%  (F,F_e)          = density flux (ref,MC)            [ kg/m^2s ]
%  sigma            = denity classes                   [ kg/m^3 ] 
%  (rho,rho_e)      = density data (ref,MC)            [ kg/m^3 ]
%  n_stat           = # of Monte Carlo simulations     [ number ]
%  dS               = density/salinity bin width       [ kg/m^3 / PSU ]
%  (dxx,dyy)        = distance (latitude,longitude     [ m ]
%  S                = salinity classes                 [ PSU ] 
%  (SSS,SSS_e)      = salinity data (ref,MC)           [ PSU ]
%  T                = temperature classes              [ degC ] 
%  (SST,SST_e)      = temperature data (ref,MC)        [ degC ]
%  dT               = temperature bin width            [ degC ]
%
% OUTPUT:
% (Frho,gFrho,Fscatt,gFscatt)_true = ref. trans(formation) in density and
%               temperature-salinity space             [ sv = 1e6 m^3s^-1 ] 
% (Frho,gFrho,Fscatt,gFscatt)_e = MC trans(formation) in density and
%               temperature-salinity space             [ sv = 1e6 m^3s^-1 ]            
%  
% AUTHOR:
%  Aqeel Piracha                                 [ apiracha@btinternet.com ]
%
% VERSION 
% 1           = First made                       [ Thursday 10th October 2019 ] 
% 2           = neatened                         [ Sunday 26th April 2020 ]
%
% REFERENCES:
% No References
%
% The software is currently in development
%
%=======================================================================================================================

%% Transformation and formation in rho space
    [Frho_true,Frho_e,...
        gFrho_true,gFrho_e] = transf_form_rho_space(F,sigma,rho,n_stat,0.1,F_e,rho_e,dxx,dyy);        

%% Transformation and formation in TS space
    [Fscatt_true,Fscatt_e,...
                gFscatt_true,gFscatt_e] = transf_form_TS_space(F,S,T,SSS,SST,n_stat,dS,dT,F_e,...
                SSS_e,SST_e,dxx,dyy);

end
