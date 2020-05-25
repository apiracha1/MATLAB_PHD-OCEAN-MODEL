function rho_plot(vare,sigma,tframe,month,n_stat,fign,SSS_unc,SST_unc,H_unc,...
    W_unc,var_ref,name,unit,name_unit)
% rho_plot                             plots data versus density          [ Sv ]
%============================================================
%
% USAGE:
% rho_plot(vare,sigma,tframe,month,n_stat,fign,SSS_unc,SST_unc,H_unc,...
%     W_unc,var_ref,name,unit,name_unit)
%                                                   *All variables set
%                                                   through Control_Center
%
% DESCRIPTION:
% Function creates full plot with axis titles and correct limits of
% water mass transformation and density
%
% INPUT:
% vare = datasett for all monte-carlo simulations [ matrix ]
% sigma = density sampling range [ vector ]
% tframe = year [string ]
% month = month [ number ]
% n_stat = number of statistically random points for monte-carlo [ number ]
% fign = figure number to be plotted on [ number ]
% [SSS_unc,SST_unc,H_unc] = variable uncertainty [ number ]
% var_ref = reference variable to be loaded [ string ]
% name = name of variable [ string ]
% unit = unit of variable [ string ]
% name_unit = name and units of variable [ string ]
%
% OUTPUT:
%
% AUTHOR:
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1 (Monday 10th February 2020) *******STARTING FRESH COUNT
% NOTES on VERSION:
% None
%
% REFERENCES:
%
% The software is currently in development
%
%============================================================
var = load('/home/ap/PHD-BEC/ESA/smos_box/TSdiag/Variables/1_degree/jan13dec13/Jan/All_variables.mat',...
    var_ref);
var = struct2cell(var);
var = var{1};
vare = permute(vare,[2,3,1]);

vare_mc_mean = nanmean(vare,3);
vare_mc_std = nanstd(vare,3);
vare_diff_H_mean = var(:,:) - vare_mc_mean(:,:);

vare = permute(vare,[2 3 1]);
figure(fign)
clf
set(gcf,'Color','w')
plot(sigma,var,'r-')
hold on
plot(sigma,vare_mc_mean,'k-')
errorbar(sigma,vare_mc_mean,vare_mc_std)
yline(0,'k-')
title({['month = ',num2str(month),' - year = 20',[tframe(end-1),tframe(end)]],...
    ['Mean of ',num2str(n_stat),' simulations'],...
    ['Uncertainties: SSS = ',num2str(SSS_unc),'[%] - ',...
    'SST = ',num2str(SST_unc),'[%] - ',...
    'H = ',num2str(H_unc),'[%] - ',...
    'W = ',num2str(W_unc),'[%]']},'fontsize',14)
xlabel('Density [kgm^-^3]','FontSize',14)
ylabel(name_unit,'FontSize',14)

%% single point histogram
i = 59;
if SSS_unc ~= 0
imp_monte_carlo_hist(var(i),vare(i,:),unit,4,sigma(i),[],'[kgm^{-3}]',[],...
    name,['SSS = ',num2str(SSS_unc)],n_stat,fign+1)

imp_monte_carlo_hist(0,vare_diff_H_mean(1,:),unit,4,'all',[],'[kgm^{-3}]',[],...
    name,['SSS = ',num2str(SSS_unc)],n_stat,fign+2)

elseif SST_unc ~= 0
imp_monte_carlo_hist(var(i),vare(i,:),unit,4,sigma(i),[],'[kgm^{-3}]',[],...
    name,['SST = ',num2str(SST_unc)],n_stat,fign+1)

imp_monte_carlo_hist(0,vare_diff_H_mean(1,:),unit,4,'all',[],'[kgm^{-3}]',[],...
    name,['SST = ',num2str(SST_unc)],n_stat,fign+2)
elseif H_unc~=0
    imp_monte_carlo_hist(var(i),vare(i,:),unit,4,sigma(i),[],'[kgm^{-3}]',[],...
    name,['H = ',num2str(H_unc)],n_stat,fign+1)

imp_monte_carlo_hist(0,vare_diff_H_mean(1,:),unit,4,'all',[],'[kgm^{-3}]',[],...
    name,['H = ',num2str(H_unc)],n_stat,fign+2)
elseif W_unc~=0
    imp_monte_carlo_hist(var(i),vare(i,:),unit,4,sigma(i),[],'[kgm^{-3}]',[],...
    name,['W = ',num2str(W_unc)],n_stat,fign+1)

imp_monte_carlo_hist(0,vare_diff_H_mean(1,:),unit,4,'all',[],'[kgm^{-3}]',[],...
    name,['W = ',num2str(W_unc)],n_stat,fign+2)

end
figure(fign)
xline(sigma(i))

end
