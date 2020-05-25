function true_pert_scatter(rho_e,fign,SSS,SST,lat,lon,SSS_unc,SST_unc)

[rho,~,~] = gsw_rho_alpha_beta(SSS,SST,0);

rho_true = rho(:);
rho_pert = nanmean(rho_e,3);
rho_pert = rho_pert(:);

figure(fign)
clf
set(gcf,'Color','w')
scatter(rho_true-1000,rho_pert-1000,'.');
hold on
hline = refline([1 0]);
hline.Color = 'k';

xlabel('Ref. Density [\rho - kgm^{-3}]','fontsize',14)
ylabel('Pert. Density [\rho\prime - kgm^{-3}]','FontSize',14)


rho_true(isnan(rho_true)) = 0;
rho_pert(isnan(rho_pert)) = 0;

title({['STD = ', num2str(nanstd(rho_true-rho_pert))],['Mean = ',num2str(nanmean(rho_true-rho_pert))],...
    ['Correlation = ',num2str(corr(rho_true,rho_pert,'type','Kendall'))],...
    ['Uncertainties: SSS = ',num2str(SSS_unc),' - SST = ',num2str(SST_unc)]},'fontsize',14)

box on

xlim([22.9 23])
ylim([22.9 23])

end