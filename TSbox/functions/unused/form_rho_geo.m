function form_rho_geo(Frho_all,sigma,orho,dS,n_stat,oxx,oyy)
% form_rho_geo                             obtains geographical region of transformation through
%                                                               a specific density surface +/- binsize [ Sv/m^2 ]
%============================================================
% 
% USAGE:  
% transf_rho_geo()
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
%  Frho_all = Transformation in density space for all monte-carlo
%                                                           simulations [ 3-D Matrix ]
%  sigma = density range seperated by bin width [ vector ]
%  orho = density map for month in question [ 3-D matrix ]
%  dS = bin size                                                            [ scalar ]
%  n_stat = number of monte-carlo simulations       [ scalar ]
%  [oxx,oyy] = distances within area in question [ vectors ]
% 
% OUTPUT:
% 
%
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1 (Tuesday 28th January 2020) *******STARTING FRESH COUNT
% NOTES on VERSION:
%                               
%
% REFERENCES:
% For calculation of density flux           [ Speer and Tzipermann 1992 ]   
%
% The software is currently in development
%
%============================================================


Frho = nanmean(Frho_all,2);
[V,I] = max(Frho(:));
[row,col] = ind2sub([1 101], I);
figure(28)
xline((sigma(I)-1000)-dS)
xline((sigma(I)-1000)+dS)
Fpeak = nan(size(orho,1),size(orho,2),n_stat);
f = waitbar(0,'Please wait for geographical conversion...');  % Message box to wait while computation is ongoing
for n_statrec = 1:n_stat
    waitbar(n_statrec/n_stat,f,[num2str(n_statrec),...
    ' Realisations computed out of ', num2str(n_stat)])         % Progress bar
    for j = 1:size(orho,1)
        for i = 1:size(orho,2)
            if orho(j,i) > sigma(col) - dS && orho(j,i) < sigma(col)+ dS
                for s = 2:length(sigma)
                    if orho(j,i) > sigma(s-1) && orho(j,i,m) < sigma(s)
                        Fpeak(j,i,n_statrec) = Frho_all(1,s,...
                        n_statrec)./(oxx(j,i).*oyy(j,i));
                    end
                end
            end
        end
    end
end

form_geo_plot()

end