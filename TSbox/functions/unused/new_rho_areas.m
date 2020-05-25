function new_rho_areas(rho_e,rho,sigma,tframe,month,n_stat,fign,SSS,SST,SSS_unc,SST_unc,H_unc,...
                    W_unc,dxx,dyy,lon,lat,latitude,longitude,ocean)
                

num_points = [];
num_points_e = [];
num_points_err = nan(1,length(sigma),n_stat);
area = [];
area_err = zeros(1,length(sigma),n_stat);


for i = sigma(1):0.1:sigma(end)
    [row,col]=find(rho>i & rho<i+0.1);
    num_points = [num_points length(row)];
%     area = [area sum(dxx(row,col).*dyy(row,col),'all')/length(row)];





for n = 1:n_stat    
    [row_err,col_err]=find(rho_e(:,:,n)>i & rho_e(:,:,n)<i+0.1);
    num_points_err(1,find(sigma == i),n) = length(row_err);
%     area_err(1,find(sigma == i),n) = sum(dxx(row_err,col_err).*dyy(row_err,col_err),'all')/length(row_err);
end
    
end

figure(fign)
clf
set(gcf,'Color','w')
plot(sigma-1000,area./1e6,'r-')
hold on
errorbar(sigma-1000,nanmean(area_err,3)./1e6,nanstd(area_err,3)./1e6,'k-')
legend('Reference',['Mean [',num2str(SSS_unc),'PSU]'])
title({['month = ',num2str(month),' - year = 20',[tframe(end-1),tframe(end)]],...
    ['Mean of ',num2str(n_stat),' simulations'],...
    ['Uncertainties: SSS = ',num2str(SSS_unc),'[PSU] - ',...
    'SST = ',num2str(SST_unc),'[\circC] - '],...
    ['Total Area = ',num2str(nansum(area)/1e6)]},'fontsize',14)
xlabel('Density [kgm^-^3]','FontSize',14)
ylabel('area [km^{2}]','FontSize',14)
ylim([-1 12e5])

unc_unit = '0.2 [\circC]';
unc_unit_SSS = '0.2 [PSU]';
unc_unit_SST = '0 [\circC]';
figure(fign)
clf
set(gcf,'Color','w')
plot(sigma-1000,area./1e6,'r-')
hold on
% errorbar(sigma-1000,nanmean(area_er./1e6,nanstd(area_err,3)./1e6,'k-')
plot(sigma-1000,area_err(:,:,800)./1e6,'m-')
plot(sigma-1000,area_err(:,:,10)./1e6,'k-')
plot(sigma-1000,abs((area-area_err(:,:,800))./1e6),'m-.')
plot(sigma-1000,abs((area-area_err(:,:,10))./1e6),'k-.')
legend('Reference',['Mean ',unc_unit,' - 800 MC'],['Mean ',unc_unit,' - 10 MC'],...
    ['\Delta Ref -','Mean ',unc_unit,' - 800 MC'],['\Delta Ref -','Mean ',unc_unit,' - 10 MC'])
title({['month = ',num2str(month),' - year = 20',[tframe(end-1),tframe(end)]],...
    ['Mean of ',num2str(n_stat),' simulations'],...
    ['Uncertainties: SSS = ',unc_unit_SSS,...
    'SST = ',unc_unit_SST],...
    ['Total Area = ',num2str(nansum(area)/1e6)]},'fontsize',14)
xlabel('Density [kgm^-^3]','FontSize',14)
ylabel('area [km^{2}]','FontSize',14)
ylim([-1 12e5])
save_all_figures([1],1,'SSS','Meeting16/WOA18')
clf
histogram(area_err(1,find(sigma == 1023),:)./1e6)
hold on
histogram(area_err(1,find(sigma == 1026),:)./1e6)
xline(area(1,find(sigma == 1023))./1e6,'b-')
xline(area(1,find(sigma == 1026))./1e6,'r-')
legend('23 kgm^{-3}','26 kgm^{-3}','23 kgm^{-3} - Reference','26 kgm^{-3} - Reference')
title({['month = ',num2str(month),' - year = 20',[tframe(end-1),tframe(end)]],...
['Mean of ',num2str(n_stat),' simulations'],...
['Uncertainties: SSS = ',num2str(SSS_unc),'[PSU] - ',...
'SST = ',num2str(SST_unc),'[\circC] - ',...
'H = ',num2str(H_unc),'[%] - ',...
'W = ',num2str(W_unc),'[%]'],...
['Total Area = ',num2str(nansum(area)/1e6)]},'fontsize',14)
xlabel('Density [kgm^-^3]','FontSize',14)
ylabel('# of points','FontSize',14)
save_all_figures([1],4,'SSS','Meeting16/WOA18')

figure(fign+1)
clf
set(gcf,'Color','w')
plot(sigma-1000,num_points,'r-')
hold on
errorbar(sigma,nanmean(num_points_err,3),nanstd(num_points_err,3),'k-')
legend('Reference',['Mean [',num2str(SSS_unc),'%]'])
title({['month = ',num2str(month),' - year = 20',[tframe(end-1),tframe(end)]],...
    ['Mean of ',num2str(n_stat),' simulations'],...
    ['Uncertainties: SSS = ',num2str(SSS_unc),'[%] - ',...
    'SST = ',num2str(SST_unc),'[%] - ',...
    'H = ',num2str(H_unc),'[%] - ',...
    'W = ',num2str(W_unc),'[%]']},'fontsize',14)
xlabel('Density [kgm^-^3]','FontSize',14)
ylabel('# of points','FontSize',14)
ylim([0 150])

figure(fign)
clf
set(gcf,'Color','w')
scatter(area./1e6,area_e./1e6,'.');
hold on
hline = refline([1 0]);
hline.Color = 'k';

xlabel('Ref. Density [\rho_{area} - km^{2}]','fontsize',14)
ylabel('Pert. Density [\rho\prime_{area} - km^{2}]','FontSize',14)

mean = num2str(nanmean(area-area_e)./1e6);
std = num2str(nanstd(area-area_e)./1e11);
area(isnan(area)) = 0;
area_e(isnan(area_e)) = 0;

title({['STD = ', std],['Mean = ',mean],...
    ['Correlation = ',num2str(corr(area',area_e','type','Kendall'))],...
    ['Uncertainties: SSS = ',num2str(SSS_unc),' - SST = ',num2str(SST_unc)]},'fontsize',14)

box on



h = figure(fign+3);
clf
% subplot(1,2,1)
set(gcf,'Color','w')
plot(sigma-1000,area./1e6,'r-')
axis square
hold on
plot(sigma-1000,area_e./1e6,'k-')
legend('Reference',['Mean [',num2str(SSS_unc),'%]'])
title({['month = ',num2str(month),' - year = 20',[tframe(end-1),tframe(end)]],...
    [num2str(n_stat),' Realisations'],...
    ['Uncertainties: SSS = ',num2str(SSS_unc),'[%] - ',...
    'SST = ',num2str(SST_unc),'[%] - ',...
    'H = ',num2str(H_unc),'[%] - ',...
    'W = ',num2str(W_unc),'[%]'],...
    ['Total Area = ',num2str(nansum(area)/1e6)]},'fontsize',14)
xline(sigma(30)-1000)
xline(sigma(31)-1000)

figure(fign+4)
% subplot(1,2,2)
set(gcf,'Color','w')
[row,col]=find(rho>sigma(30) & rho<sigma(31));
[row_e,col_e]=find(nanmean(rho_e,3)>sigma(30) & nanmean(rho_e,3)<sigma(31));
map_basin(latitude,longitude,ocean,lat,lon,rho');    
plotm(lat(col),lon(row)','ro')
plotm(lat(col_e),lon(row_e)','kx')
title({['month = ',num2str(month),' - year = 20',[tframe(end-1),tframe(end)]],...
    ['Uncertainties: SSS = ',num2str(SSS_unc),'[%] - ',...
    'SST = ',num2str(SST_unc),'[%] - ',...
    'H = ',num2str(H_unc),'[%] - ',...
    'W = ',num2str(W_unc),'[%]'],...
    ['Total Area = ',num2str(nansum(area)/1e6)]},'fontsize',14)
colormap jet
caxis([1020 1028])

% 
% for n = 1:n_stat
% 
%     subplot(1,2,2);
%     title([num2str(n),' Realisation'])
%     [row_e,col_e]=find(rho_e(:,:,n)>sigma(30) & rho_e(:,:,n)<sigma(31));
%     k = plotm(lat(col_e),lon(row_e)','kx'); 
%     title({['month = ',num2str(month),' - year = 20',[tframe(end-1),tframe(end)]],...
%     [num2str(n),' Realisation - \rho'],...
%     ['Uncertainties: SSS = ',num2str(SSS_unc),'[%] - ',...
%     'SST = ',num2str(SST_unc),'[%] - ',...
%     'H = ',num2str(H_unc),'[%] - ',...
%     'W = ',num2str(W_unc),'[%]'],...
%     ['Total Area = ',num2str(nansum(area)/1e6)]},'fontsize',14)
% 
%     subplot(1,2,1)
%     j = plot(sigma-1000,area_err(1,:,n)./1e6,'k-'); 
%     title({['month = ',num2str(month),' - year = 20',[tframe(end-1),tframe(end)]],...
%         [num2str(n),' Realisation'],...
%         ['Uncertainties: SSS = ',num2str(SSS_unc),'[%] - ',...
%         'SST = ',num2str(SST_unc),'[%] - ',...
%         'H = ',num2str(H_unc),'[%] - ',...
%         'W = ',num2str(W_unc),'[%]'],...
%         ['Total Area = ',num2str(nansum(area)/1e6)]},'fontsize',14)
%     legend('Reference',[num2str(n),' Realisation'])
%     drawnow; 
%     pause(1);
%           frame = getframe(h); 
%       im = frame2im(frame); 
%       [imind,cm] = rgb2ind(im,256); 
%       % Write to the GIF File 
%       if n == 1 
%           imwrite(imind,cm,'rhoproblem.gif','gif', 'Loopcount',inf); 
%       else 
%           imwrite(imind,cm,'rhoproblem.gif','gif','WriteMode','append'); 
%       end 
%     delete(j);
%     delete(k);
% end

end