function init_var_analysis(var,var_e,tframe,month,n_stat,SSS_unc,SST_unc,H_unc,W_unc,var_name,lat,lon,fign,BinSize,unit,...
    limit)

figure(fign)
clf
set(gcf,'Color','w')
difff = var_e - var;
STD = nanstd(difff(:));
MEAN = nanmean(difff(:));

histogram(var_e-var,-limit:BinSize:limit)
xline(-STD,'label',...
    '-1\sigma','labelhorizontal','left')

xline(MEAN,'label',...
    'Mean difference')

xline(STD,'label',...
    '+1\sigma')


title({['month = ',num2str(month),' - year = 20',[tframe(end-1),tframe(end)]],...
    ['Mean of ',num2str(n_stat),' simulations'],...
    ['Uncertainties: SSS = ',num2str(SSS_unc), 'PSU - ',...
    'SST = ',num2str(SST_unc),'\circC - ',...
    'H = ',num2str(H_unc),' Wm^{-2} - ',...
    'W = ',num2str(W_unc)]},'fontsize',14)

legend({[var_name,' - ',var_name,'^\prime' newline...
    'STD = ',num2str(STD) newline ...
    'Mean = ',num2str(MEAN)]})

xlabel([var_name,' - ',var_name,'^\prime',' ',unit])
ylabel('# of points')

if strcmp(unit,'[kgm^{-3}]')
    figure(fign+1)    
    clf
    set(gcf,'Color','w')

    MEAN = nanmean(var(:));
    STD = nanstd(var(:));
    
    MEAN_e = nanmean(var_e(:));
    STD_e = nanstd(var_e(:));
       
    hold on
    histogram(nanmean(var_e,3),20:0.1:28,'FaceColor','k') 
    histogram(var,20:0.1:28,'FaceColor','r')
    
    legend({[var_name newline...
        'STD = ',num2str(STD) newline ...
        'Mean = ',num2str(MEAN)],...
        [var_name,'^\prime' newline...
        'STD = ',num2str(STD_e) newline ...
        'Mean = ',num2str(MEAN_e)]},'Location','Northeast')

    xlabel([var_name,' ',unit])
    ylabel('# of points')
    box on
    
    title({['month = ',num2str(month),' - year = 20',[tframe(end-1),tframe(end)]],...
        ['Mean of ',num2str(n_stat),' simulations'],...
        ['Uncertainties: SSS = ',num2str(SSS_unc), 'PSU ',...
        'SST = ',num2str(SST_unc),'\circC']},'fontsize',14)
end


end