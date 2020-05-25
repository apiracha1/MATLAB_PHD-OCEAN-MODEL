                dT = 0.5; dS = 0.1;     % Temperature and salinity sampling intervals      [ degC ] [ PSU ]
                    T = -2:dT:35; S = 30:dS:38;     % Temperature and salinity range       [ degC ] [ PSU ]

                formation_error = nan(n_stat,length(T),length(S));        % Predefining formation matrix
                formation_error_unchanged = nan(length(T),length(S),size(SSS,3),n_stat); 
                
                function [S,T,seasons,formation_error] = wm_form_TS_error(n_stat,sal,temp,time_frame,...
    ocean,prec,seasons,evap_name,msg,months) 
% wm_form_TS_error                             Calculates (and plots) TS diagrams of water mass formation
%                                                                              with pre-defined parameters     [ Sv (x10-6 m3/s ]
%============================================================
% 
% USAGE:  
% wm_form_TS_error(n_stat,sal_name,temp_name,year,ocean_name,prec_name,seasons,...
%   evap_name,msgs,months) 
%                                                   *All variables set
%                                                   through Control_Center
% 
%  Note that wm_form_TS_error has all variables pre set through
%  choices in Control_Center.
%
% DESCRIPTION:
%  **As of 10/10/2019 
% Function derives diagrams of water mass formation in TS space (wm_form_TS_error) 
% from pre-selected datasets. 
% Calls necessary function get_fig_stripe_info which extracts connected
% component regions in TS diagram (Positive formation) to compute
% geographic pattern of formation.
%
% INPUT:
%  n_stat  =  Statistically random point for monte carlo                [ number ]
%  sal  =  salinity dataset name            [ string ] (***SMOS OA and SMOS binned (10/10/2019)
%  temp   =  temperature dataset name           [ string ]
%  time_frame = selected year           [ string ] (FORMAT: jan##dec##, ## = 12 for 2012 e.t.c.)
%  ocean = ocean name           [ string ] 
%  prec = precipitation dataset name            [ string ]
%  seasons = name of seasons             [ string ] ****NEED TO UPDATE/CHECK IF NEEDED
%  evap_name = evaporation dataset name             [ string ]
%  msg = handle to message box          [ string ] *****NOT WORKING IN CLEARING 
%                                                                                                 "PLEASE WAIT..."
% months  =  number of month from calling function          [ number ]
% OUTPUT:
%  S  =  salinity sampling           [ PSU (array) ] 
%  T  =  temperature sampling           [ degC (array) ]
%  seasons = season             [ string ]  ^(e.g. 'JFM' for January-February-March)
%  formation_error  =  TS formation with MC applied             [ Sv (x10-6 m3/s) ]
% 
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1 (Thursday 10th October 2019) *******STARTING FRESH COUNT
%
% REFERENCES:
% For calculation of formation           [ Speer and Tzipermann 1992 ]   
%
% The software is currently in development
%
%============================================================

%% -----Computes for each year---------------------------------------------
for years = 1:length(time_frame)    
    for tframe = time_frame(years)
        tframe = curr_time_frm(time_frame,tframe);      % Current year in loop
        [seasons,~] = curr_sson_mon(seasons);       % Current season in loop
        for ocean_num = 1:length(ocean)         %for the case of multiple basin choices *EXPERIMENTAL
            ocean = ocean{ocean_num};       % Current Ocean 
    %-----Defines months and seasons-------------------------------------------        
    %% -----Runs computation for each season-----------------------------------        
            for monthss = 1:length(months)    
                for month = months(monthss)
                [month,season] = curr_mon_sson_cnter(months,month,monthss,...   % Month and seas.
                    seasons);            
                longsss = dataset_titles_sal(sal);      % Salinity dataset fullname
                longsst = dataset_titles_temp(temp);    % Temperature dataset fullname 
    %% Constants
                cp = gsw_cp0;       % Specific heat capacity of water       [ J/(degC kg) ]
                p0 = 0;         % Reference density of seawater     [ kg/m3 ]       **Why is it 0???
                [latitude, longitude, aratio] = colTSreg_v2(ocean);     % Lat-Lon points for basin chosen
 % predefining formation matrix
                cd ../../smos_box/TSdiag    % Changing to correct directory
    %% Datasets
                [SSS lat lon] = load_all_v2(sal,tframe,'SSS');      % Salinity dataset      [ PSU ]
                SST = load_all_v2(strcat(temp(1,:)),tframe,'SST');      % Temperature dataset       [ degC ]
                lon = correct_lon_err(sal,ocean,lon);       % Correcting for lon error in Pacific
                evap = load_all_v2(evap_name,tframe,'evap');        % Evaporation       [ cm/yr - OAFLUX]
                precip = load_all_v2(prec,tframe);      % Precipitation  [ mm/hr - CMORPH ]
                lheat = load_all_v2('nocs',tframe,'lheat');     % Latent heat       [ W/m2 ] **CHANGE  
                sheat = load_all_v2('nocs',tframe,'sheat');     % Sensible heat         [ W/m2 ] 
                lwave = load_all_v2('nocs',tframe,'lwave');     % Long wave radiation       [ W/m2 ] 
                swave = load_all_v2('nocs',tframe,'swave');         % Short wave radiation      [ W/m2 ]
                [H,W] = heat_freswtr(lheat,sheat,lwave,swave,evap,precip);      % Heat and freshwtr fluxes
                [H,W,SSS,SST] = same_nans(H,W,SSS,SST);         % Equalising missing data points
                [Lon,Lat] = meshgrid(lon,lat); lon = Lon; lat = Lat; 
                clear Lon Lat
                [xx,yy] = deg2m(lon,lat);       % Converting latitudes and longitudes to distances      [ m ]
                dxx = diff(xx,1,2); dxx(:,360) = dxx(:,359);        % lon differences betwe. distances    [ m ]
                dyy = diff(yy,1,1); dyy(180,:) = dyy(179,:);        % lat differences betwe. distances  [ m ]
                [He,We,SSSe, SSTe, sigmaSSS, sigmaSST] =  error_computation(W,H,SSS,...
                    SST,n_stat);        % Applying Monte-Carlo simulation to datasets (if applicable)
                [H,W,SSS,SST,Fmean_e] = initialising_vars(n_stat,latitude,longitude);       % Empty
    %                                                                                                                                 variables to fill
%% Starting formation computation 
                f = waitbar(0,'Please wait...');       
                for n = 1:n_stat
                    waitbar(n/n_stat,f,[num2str(n),...
                        ' Realisations computed out of ', num2str(n_stat)])         % Progress bar
                    [H,W,SSS,SST] = fill_init_vars(He,We,SSSe,SSTe,n);      % Filling empty vars with data
                    [SSS,SST,rho,alpha,beta] = cons_SSS_SST_rho_coeff(SSS,SST,p0,lon,lat);      % For 
%                                                                                             conservative temperature        [ degC ]
%                                                                                             conservative salinity         [ PSU ]
%                                                                                             density       [ kg/m3 ]
%                                                                                             thermal expansion     [ 1/degC ]
%                                                                                             haline contraction        [ 1/PSU ]
%% select region
                    if ~strcmp(ocean,'all')
                        [indx, indy, ~] = basin_bounds(ocean);
                    elseif strcmp(ocean,'all')
                        indx = 1:360; indy = 1:180;
                     end
                     [oalpha,obeta,orho,oH,oW,oSSS,oxx,oyy,oSST] = sel_reg(ocean,alpha,beta,rho,H,...
                         W,SSS,SST,dxx,dyy,indy,indx);       % Redefining variables bounded by basin chosen
%-----Computing all variables for ocean basin selected---------------------
%-----Defining bin sizes and days in months--------------------------------
                                        ndays = [31 28 31 30 31 30 31 31 30 31 30 31];      % Days in each month  [ number ]
%% Density flux computation
                    [~,~,F] = dens_flux(oalpha,oH,cp,obeta,orho,oW,oSSS,month,...
                         n);
%% Formation computation (ACTUAL)
                   [~,formation1,formation_error,formation_error_unchanged] = transf_form_comp(T,...
                        S,F,oSSS,oSST,month,oxx,...
                        oyy,ndays,dS,dT,n,formation_error,formation_error_unchanged);
                end         % End main loop (over random variables)
    formation_error(find(formation_error == 0)) = nan;      % Making sure zero formation ignored
                close(f)        % Closing progress bar
%% -----Plotting results---------------------------------------------------
 %-----Formatting results to correct size (lat,lon,n_stat)------------------
                formation_error = permute(formation_error,[2,3,1]);
%-----Computing mean and standatd deviation of MC--------------------------
                formation_error_mean = nanmean(formation_error,3);  % Mean
                formation_error_std = nanstd(formation_error,3);    % Standard deviation
                [latitude, longitude, aratio] = colTSreg_v2(ocean);     % Lat-Lon extent of basin
%-----for collecting all geographic locations------------------------------
                Geo_formation_all_MC_locs = nan(length(latitude),...
                    length(longitude),n_stat);      % Empty matrix to be filled later       ***May not need
%-----Actual potting-------------------------------------------------------
                [h] = sub_plot_sort(time_frame,months,years,sal,season,fullname,tframe,monthss,...
                    6);         % Sorting subplots 
                draw_form_TS(formation_error_mean,season,fullname,tframe,S,T,longsss,longsst,h,0,...
                    sal,months)     % Plotting mean TS formation 
%-----STD-------------------------------------------------------
                figure(6)
                if strcmp(sal,'smosOA')
                        h = subplot (2,4,6);
                    else
                        h = subplot (2,4,2);
                        title('STD')
                end
                draw_form_TS(formation_error_std,season,fullname,tframe,S,T,longsss,longsst,h,1,sal,...
                    months)         % Plotting standard deviation formation TS
                load ('cmap_STD_TS.mat','ans');     % loading STD colormap
                ca = [0 5];     % cmap limits
                caxis(ca)
                cmap = ans;
                set(h,'colormap',cmap)      % Setting cmap
%-----Going to Compute geographic location of mean water-mass formation from "STRIPES"----
        Geo_formation_all_MC_locs = get_fig_stripe_info(2,f,5,ocean,...
                    nanmean(formation_error,3),...
                    findobj(gca,'type','surface'),oSSS,oSST,oxx,oyy,n_stat,...
                    [],Geo_formation_all_MC_locs,...
                    formation_error_unchanged,'o',1,sal,temp,tframe,prec,...
                    month,evap_name,time_frame,years,monthss,season,months,f,...
                    ocean_num,S,T,formation_error);         % Extracting connected component regions
                end
            end
        end
    end
end
end
%--------------------------------------------------------------------------
%--------------------END CODE----------------------------------------------
%--------------------------------------------------------------------------
    