function plot_transform_rho(sigma,Frho_true,Frho_e,gFrho_true,gFrho_e,month,n_stat,...
    SSS_unc,SST_unc,H_unc,W_unc,tframe,fign)


dS = 0.1;

figure(fign)
plot(sigma(1):dS:sigma(end),Frho_true,'r-')
hold on
errorbar(sigma(1):dS:sigma(end),nanmean(Frho_e,3),nanstd(Frho_e,3),'k-')
legend('Ref.',['Mean of ',num2str(n_stat),' simulations'])

title({['month = ',num2str(month),' - year = 20',[tframe(end-1),tframe(end)]],...
    ['Mean of ',num2str(n_stat),' simulations'],...
    ['Uncertainties: SSS = ',num2str(SSS_unc), 'PSU - ',...
    'SST = ',num2str(SST_unc),'\circC - ',...
    'H = ',num2str(H_unc),' Wm^{-2} - ',...
    'W = ',num2str(W_unc),' ms^{-1}']},'fontsize',14)
xlabel('\rho [kgm^{-3}]')
ylabel('Transformation [Sv]')
xlim([1020 1028])
ylim([-25 10])

figure(fign+1)
plot(sigma,gFrho_true,'r-')
hold on
errorbar(sigma,nanmean(gFrho_e,3),nanstd(gFrho_e,3),'k-')
legend('Ref.',['Mean of ',num2str(n_stat),' simulations'])

title({['month = ',num2str(month),' - year = 20',[tframe(end-1),tframe(end)]],...
    ['Mean of ',num2str(n_stat),' simulations'],...
    ['Uncertainties: SSS = ',num2str(SSS_unc), 'PSU - ',...
    'SST = ',num2str(SST_unc),'\circC - ',...
    'H = ',num2str(H_unc),' Wm^{-2} - ',...
    'W = ',num2str(W_unc)]},'fontsize',14)

xlabel('\rho [kgm^{-3}]')
ylabel('formation [Sv]')
xlim([1020 1028])
ylim([-10 10])


end
