function TS_plot(Fscatt_true,Fscatt_mean,Fscatt_std,...
                        gFscatt_true,gFscatt_mean,gFscatt_std,T,S,n_stat,tframe,SSS_unc,SST_unc,H_unc,W_unc,...
                        fign)
%% Transormation
%% Reference Transformation
figure(fign)
rho_contours(T,S)
hold on 
pcolor(S,T,Fscatt_true)
shading flat
ca = [-3 65];
caxis(ca)
cm = anom_cmap_nowhite(ca);
colormap(cm)
colorbar
xlabel('SSS [PSU]')
ylabel('SST [\circC]')
axis square
title({['Reference Transformation for ',ocean],...
    ['month = ',tframe(1:3),' - ',tframe(6:8),', year = 20',tframe(end-1:end)],...
    []},...
    'FontSize',14)

%% Mean Transformation
figure(fign+1)
rho_contours(T,S)
hold on 
pcolor(S,T,Fscatt_mean)
shading flat
ca = [-3 65];
caxis(ca)
cm = anom_cmap_nowhite(ca);
colormap(cm)
colorbar
xlabel('SSS [PSU]')
ylabel('SST [\circC]')
axis square
title({['Mean Transformation for ',ocean],...
    ['month = ',tframe(1:3),' - ',tframe(6:8),', year = 20',tframe(end-1:end),' with ',numstr(n_stat),' simulation'],...
    ['Uncertainties: SSS = ',num2str(SSS_unc),' - SST = ',num2str(SST_unc),' - Fresw. flux = ',num2str(W_unc),' Heat flux = ',num2str(H_unc)]},...
    'FontSize',14)

%% STD Transformation
figure(fign+2)
rho_contours(T,S)
hold on 
pcolor(S,T,Fscatt_std)
shading flat
ca = [0 0.2];
caxis(ca)
colormap(jet)
colorbar
xlabel('SSS [PSU]')
ylabel('SST [\circC]')
axis square
title({['STD Transformation for ',ocean],...
    ['month = ',tframe(1:3),' - ',tframe(6:8),', year = 20',tframe(end-1:end),' with ',numstr(n_stat),' simulation'],...
    ['Uncertainties: SSS = ',num2str(SSS_unc),' - SST = ',num2str(SST_unc),' - Fresw. flux = ',num2str(W_unc),' Heat flux = ',num2str(H_unc)]},...
    'FontSize',14)

%% Histograms Transformation
figure(fign+2)
subplot(4,1,1:3)
h = histogram(Fscatt_true-Fscatt_mean,'Normalization','pdf');
xline(nanmean(Fscatt_true(:)-Fscatt_mean(:)))
title({['\DeltaReference - Mean Transformation for ',ocean],...
    ['month = ',tframe(1:3),' - ',tframe(6:8),', year = 20',tframe(end-1:end),' with ',numstr(n_stat),' simulation'],...
    ['Uncertainties: SSS = ',num2str(SSS_unc),' - SST = ',num2str(SST_unc),' - Fresw. flux = ',num2str(W_unc),' Heat flux = ',num2str(H_unc)]},...
    'FontSize',13)
xlim([min(Fscatt_true(:)-Fscatt_mean(:)) max(Fscatt_true(:)-Fscatt_mean(:))])
ylabel('PDF')
subplot(4,1,4)
plot(h.BinCounts)
xline(nanmean(Fscatt_true(:)-Fscatt_mean(:)))
xlim([min(Fscatt_true(:)-Fscatt_mean(:)) max(Fscatt_true(:)-Fscatt_mean(:))])
xlabel('Transformation [Sv]')
ylabel('# of points')


%% formation
%% Reference formation
figure(fign)
rho_contours(T,S)
hold on 
pcolor(S,T,gFscatt_true)
shading flat
ca = [-10 10];
caxis(ca)
cm = anom_cmap_nowhite(ca);
colormap(cm)
colorbar
xlabel('SSS [PSU]')
ylabel('SST [\circC]')
axis square
title({['Reference formation for ',ocean],...
    ['month = ',tframe(1:3),' - ',tframe(6:8),', year = 20',tframe(end-1:end)],...
    []},...
    'FontSize',14)

%% Mean formation
figure(fign+1)
rho_contours(T,S)
hold on 
pcolor(S,T,gFscatt_mean)
shading flat
ca = [-10 10];
caxis(ca)
cm = anom_cmap_nowhite(ca);
colormap(cm)
colorbar
xlabel('SSS [PSU]')
ylabel('SST [\circC]')
axis square
title({['Mean formation for ',ocean],...
    ['month = ',tframe(1:3),' - ',tframe(6:8),', year = 20',tframe(end-1:end),' with ',numstr(n_stat),' simulation'],...
    ['Uncertainties: SSS = ',num2str(SSS_unc),' - SST = ',num2str(SST_unc),' - Fresw. flux = ',num2str(W_unc),' Heat flux = ',num2str(H_unc)]},...
    'FontSize',14)

%% STD Transformation
figure(fign+2)
rho_contours(T,S)
hold on 
pcolor(S,T,gFscatt_std)
shading flat
ca = [0 0.05];
caxis(ca)
colormap(jet)
colorbar
xlabel('SSS [PSU]')
ylabel('SST [\circC]')
axis square
title({['STD formation for ',ocean],...
    ['month = ',tframe(1:3),' - ',tframe(6:8),', year = 20',tframe(end-1:end),' with ',numstr(n_stat),' simulation'],...
    ['Uncertainties: SSS = ',num2str(SSS_unc),' - SST = ',num2str(SST_unc),' - Fresw. flux = ',num2str(W_unc),' Heat flux = ',num2str(H_unc)]},...
    'FontSize',14)

%% Histograms Transformation
figure(fign+2)
subplot(4,1,1:3)
h = histogram(gFscatt_true-gFscatt_mean,'Normalization','pdf');
xline(nanmean(gFscatt_true(:)-gFscatt_mean(:)))
title({['\DeltaReference - Mean Transformation for ',ocean],...
    ['month = ',tframe(1:3),' - ',tframe(6:8),', year = 20',tframe(end-1:end),' with ',numstr(n_stat),' simulation'],...
    ['Uncertainties: SSS = ',num2str(SSS_unc),' - SST = ',num2str(SST_unc),' - Fresw. flux = ',num2str(W_unc),' Heat flux = ',num2str(H_unc)]},...
    'FontSize',13)
xlim([min(gFscatt_true(:)-gFscatt_mean(:)) max(gFscatt_true(:)-gFscatt_mean(:))])
ylabel('PDF')
subplot(4,1,4)
plot(h.BinCounts)
xline(nanmean(gFscatt_true(:)-gFscatt_mean(:)))
xlim([min(gFscatt_true(:)-gFscatt_mean(:)) max(gFscatt_true(:)-gFscatt_mean(:))])
xlabel('Formation [Sv]')
ylabel('# of points')
end