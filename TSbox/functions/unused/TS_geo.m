function TS_geo(vare,S,T,dS,dT,oSSS,oSST,n_stat,ocean,longitude,latitude,lat,lon,...
    tframe,SSS_unc,SST_unc,H_unc,W_unc,units,name_unit,oxx,oyy,fign,load_var,var_name,ca,...
    ca_std,unc_flag,month,peak_num,fig_orig,SSS,SST,rho_e)
% TS_geo                             Converts matrix from TS to geographic
%                                               space
%============================================================
% 
% USAGE:  
% TS_geo(vare,S,T,dS,dT,oSSS,oSST,n_stat,ocean,longitude,latitude,lat,lon,...
%     tframe,SSS_unc,SST_unc,H_unc,W_unc,units,name_unit,oxx,oyy,fign,load_var,var_name,ca,...
%     ca_std,unc_flag,month,peak_num,fign_g)
%                                                   *All variables set
%                                                   through Control_Center
% 
% DESCRIPTION:
% Function calculates all parameters from density flux to formation (both
% TS and rho)
%
% INPUT:
% vare = dataset for all monte-carlo simulations [ matrix ]
% [S,T] = sal temp sampling frequency [ vector ]
% [dS,dT] = sal and temp bin size [ numbers ]
% [oSSS,oSST] = S and T from reference datasets [ matrix ]
%  n_stat  =  Statistically random point for monte carlo                [ number ]
%  ocean = ocean name           [ string ] 
% [longitude,latitude,lat,lon] = lat lon from colTSreg_v2 and basin_bounds
%                                                                                           [ matrix ]
%  time_frame = selected year           [ char array ] (FORMAT: jan##dec##, ## = 12 for 2012 e.t.c.)
% [SSS_unc,SST_unc,H_unc,W_unc] = dataset uncertainties [ number ]
% units = unit of variable [ string ]
% name_unit = name and unit of variable [ string ]
% [oxx,oyy] = distances lat-lon gridpoints for region [ matrix ]
% fign = figure number to plot to [ number ]
% load_var = reference dataset name to be loaded [ string ]
% var_name = variable name [ string ]
% [ca,ca_std] = colorbar limits for mean and std [ vectors ]
% [ unc_flag ] = uncertainty plot? [ number ]
% month = month [number ]
% peak_num = number of peak [ number ]
% 
% OUTPUT:
% 
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1 (Monday 10th February 2020) *******STARTING FRESH COUNT
% NOTES on VERSION:
%
% REFERENCES:
%
% The software is currently in development
%
%============================================================
if ~size(vare,3) == n_stat 
vare = permute(vare,[2,3,1]);
else
end
Fpeak = nan(size(oSSS,1),size(oSSS,2),n_stat);
figure(fig_orig)
f = waitbar(0,'Please wait for geographical conversion...');  % Message box to wait while computation is ongoing
    for n_statrec = 1:n_stat
vare_n = vare(:,:,n_statrec);
vare_n(vare_n<((max(vare_n(:))/100)*20))=0;
vare_n(vare_n>((max(vare_n(:))/100)*20))=1;
CC=bwconncomp(vare_n,4);
[~,I] = sort(cellfun(@length,CC.PixelIdxList),'descend');
% figure(fign_g)
[row,col] = ind2sub([size(vare_n,1) size(vare_n,2)],CC.PixelIdxList{1,I(peak_num)});
T_thresh = T(row) > 15 & T(row) < 22;
S_thresh = S(col) > 36 & S(col) < 37.5;
if sum(T_thresh == 0) > 1 && sum(S_thresh == 0) > 1
        continue

else
end
plot(S(col),T(row),'g.','MarkerSize',10)
drawnow

    waitbar(n_statrec/n_stat,f,[num2str(n_statrec),...
    ' Realisations computed out of ', num2str(n_stat)])         % Progress bar
        for m = 1:size(oSST,3)
            for j = 1:size(oSST,1)
                for i = 1:size(oSST,2)
                    for t = 1:length(row)
                        if oSSS(j,i,m) > S(col(t)) - dS && oSST(j,i,m) < S(col(t))+ dS
                            if oSST(j,i,m) > T(row(t)) - dT && oSST(j,i,m) < T(row(t)) + dT
                                for t = 2:length(T)
                                    if oSST(j,i,m) > T(t-1) && oSST(j,i,m) < T(t)
                                        for s = 2:length(S)
                                            if oSSS(j,i,m) > S(s-1) && oSSS(j,i,m) < S(s)
                                                Fpeak(j,i,n_statrec) = vare(t,...
                                                s,n_statrec)./(oxx(j,i).*oyy(j,i));
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
geo_plot(latitude,longitude,lat,lon,Fpeak,SSS_unc,SST_unc,...
    H_unc,W_unc,tframe,ocean,n_stat,month,name_unit,fign,units,load_var,...
    var_name,ca,ca_std,unc_flag,SSS,SST,rho_e)
end
