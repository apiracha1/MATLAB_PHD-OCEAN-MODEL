function rho_geo(vare,sigma,ocean,tframe,month,n_stat,fign,SSS_unc,SST_unc,...
                H_unc,W_unc,dS,orho,latitude,longitude,lat,lon,dxx,dyy,var_ref,name,unit,...
                name_unit,unc_flag,SSS,SST,rho_e)
% rho_geo                             obtains geographical region of data through
%                                                               a specific density surface +/- binsize [ Sv/m^2 ]
%============================================================
% 
% USAGE:  
% rho_geo(vare,sigma,ocean,tframe,month,n_stat,fign,SSS_unc,SST_unc,...
%                 H_unc,W_unc,dS,orho,latitude,longitude,lat,lon,dxx,dyy,var_ref,name,unit,...
%                 name_unit,unc_flag)
%                                                   *All variables set
%                                                   through Control_Center
% 
%  Note that wm_all_funcs has all variables pre set through
%  choices in Control_Center.
%
% DESCRIPTION:
%  **As of 10/10/2019 
% Function converts transformation from density space to geographic space
%
% INPUT:
% vare = datasett for all monte-carlo simulations [ matrix ]
% sigma = density sampling range [ vector ]
% tframe = year [string ]
% month = month [ number ]
% n_stat = number of statistically random points for monte-carlo [ number ]
% fign = figure number to be plotted on [ number ]
% [SSS_unc,SST_unc,H_unc] = variable uncertainty [ number ]
% dS = bin size [ number ]
% orho = density field from reference [ matrix ]
% [longitude,latitude,lat,lon] = lat lon from colTSreg_v2 and basin_bounds
%                                                                                           [ matrix ]
% [dxx,dyy] = distances lat-lon gridpoints for region [ matrix ]
% var_ref = reference variable to be loaded [ string ]
% name = name of variable [ string ]
% unit = units of variable [ string ]
% name_unit = name and unit of variable [ string ]
% unc_flag = Uncertainty extent map ? [ number ]
% 
% OUTPUT:
% 
%
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1 (Tuesday 10th February 2020) *******STARTING FRESH COUNT
% NOTES on VERSION:
%                               
%
% REFERENCES:
%
% The software is currently in development
%
%============================================================
vare = permute(vare,[2,3,1]);
sigma = sigma +1000;
Fpeak = nan(size(orho,1),size(orho,2),n_stat);
f = waitbar(0,'Please wait for geographical conversion...');  % Message box to wait while computation is ongoing
for n_statrec = 1:n_stat
% [~,I] = max(vare(1,1:60,n_statrec));
% [~,col] = ind2sub([1 length(sigma)], I);
col = 59;
    waitbar(n_statrec/n_stat,f,[num2str(n_statrec),...
    ' Realisations computed out of ', num2str(n_stat)])         % Progress bar
    for j = 1:size(orho,1)
        for i = 1:size(orho,2)
            if orho(j,i) > sigma(col) - dS && orho(j,i) < sigma(col)+ dS
                for s = 2:length(sigma)
                    if orho(j,i) > sigma(s-1) && orho(j,i) < sigma(s)
                        Fpeak(j,i,n_statrec) = vare(1,s,...
                        n_statrec)./(dxx(j,i).*dyy(j,i));
                    end
                end
            end
        end
    end
end

geo_plot(latitude,longitude,lat,lon,Fpeak,SSS_unc,SST_unc,...
    H_unc,W_unc,tframe,ocean,n_stat,month,name_unit,fign,unit,...
    var_ref,name,[-0.2e-9 0.6e-9],[0e-9 2e-9],unc_flag,SSS,SST,rho_e)

end