function hist_analysis(var,var_e,sigma,n_stat,month,tframe,SSS_unc,SST_unc,BinSize,fign)

figure(fign)
clf
set(gcf,'Color','w')

sigma = sigma(1):BinSize:sigma(end);

true_count = histogram(var(:),linspace(1020,1028,length(sigma(1):BinSize:sigma(end))+1));
true_count = true_count.BinCounts;

mean_counts = histogram(nanmean(var_e,3),linspace(1020,1028,length(sigma(1):BinSize:sigma(end))+1));
mean_counts = mean_counts.BinCounts;

pert_count_all = nan(length(true_count),n_stat);
for n = 1:n_stat
    pert_count = histogram(var_e(:,:,n),linspace(1020,1028,length(sigma(1):BinSize:sigma(end))+1));
    pert_count = pert_count.BinCounts;
    pert_count_all(:,n) = pert_count;
end

figure(fign)
clf
set(gcf,'Color','w')

plot(sigma,true_count,'r-')
hold on
errorbar(sigma,mean_counts,nanstd(pert_count_all,2),'k-')
plot(sigma,pert_count_all(:,10),'c-')
plot(sigma,pert_count_all(:,50),'b-')
plot(sigma,pert_count_all(:,100),'m-')

xlabel('\rho [kgm^{-3}]')
ylabel('# of points')
title({['month = ',num2str(month),' - year = 20',[tframe(end-1),tframe(end)]],...
['Mean of ',num2str(n_stat),' simulations'],...
['Uncertainties: SSS = ',num2str(SSS_unc), 'PSU ',...
'SST = ',num2str(SST_unc),'\circC']},'fontsize',14)

xline(1023,'k-.')
xline(1026,'r-.')
legend(['ref. # of points = ',num2str(sum(true_count))],['Mean. # of points = ',num2str(sum(mean_counts))],...
    ['10^{th} MC. # of points = ',num2str(sum(pert_count_all(:,10)))],...
    ['50^{th} MC. # of points = ',num2str(sum(pert_count_all(:,50)))],...
    ['100^{th} MC. # of points = ',num2str(sum(pert_count_all(:,100)))],...
    '23 kgm^{-3}','26 kgm^{-3}')


figure(fign+1)
clf
set(gcf,'Color','w')

IND_23 = round(find(sigma==1023));
IND_26 = round(find(sigma==1026));
histogram(pert_count_all(IND_23,:),length(sigma(1):BinSize:sigma(end)),'FaceColor','k');
xline(true_count(IND_23),'k-.')
xline(mean_counts(IND_23),'k--')
hold on
histogram(pert_count_all(IND_26,:),length(sigma(1):BinSize:sigma(end)),'FaceColor','r');
xline(true_count(IND_26),'r-.')
xline(mean_counts(IND_26),'r--')
xlabel('# of points')
ylabel('# of points')
legend('23 kgm^{-3} (pert)','23 kgm^{-3} (Ref.)','23 kgm^{-3} (Mean)','26 kgm^{-3} (pert)','26 kgm^{-3} (Ref.)','26 kgm^{-3} (Mean)')
title({['month = ',num2str(month),' - year = 20',[tframe(end-1),tframe(end)]],...
['Mean of ',num2str(n_stat),' simulations'],...
['Uncertainties: SSS = ',num2str(SSS_unc), 'PSU ',...
'SST = ',num2str(SST_unc),'\circC']},'fontsize',14)

figure(fign+2)
clf
set(gcf,'Color','w')

plot(sigma(1):BinSize:sigma(end),mean_counts,'k-')
hold on
errorbar(sigma(1):BinSize:sigma(end),nanmean(pert_count_all,2),nanstd(pert_count_all,2),'r-')
title({['Histograms of # of points in each density class from a mean of 2000 density maps'],['and from each individual density maps from amongst 2000 Monte-Carlo realisations']})
legend('mean of 2000 \rho maps -> single # of points in density class histogram','2000 \rho maps -> Mean of 2000 # of points in density class histograms ')



end

