function var_true_pert(var,var_e,SSS_unc,SST_unc,H_unc,W_unc,tframe,month,n_stat,fign,ca,name,edges,BinNum)

sizex = size(var,1);
sizey = size(var,2);

IND = sizex*sizey;
var_all = nan(IND,1);
var_ll = nan(IND,1);



for n = 1:n_stat
    if size(var) > 2
        var_n = var_e(:,:,n);
    else 
        var_n = var_e(:,:,n);
    end
if n == 1
    var_all(1:IND,1) = var_n(:);
elseif n > 1
    var_all(((n-1)*IND+1):((n*IND)),1) = var_n(:);
end
end


for n = 1:n_stat
if n == 1
    var_ll(1:IND,1) = var(:);
elseif n > 1 
    var_ll(((n-1)*IND+1):((n*IND)),1) = var(:);
end
end

var_ll(isnan(var_all)) = [];
var_all(isnan(var_all)) = [];


[n,c] = hist3([var_ll(:),var_all(:)],[BinNum BinNum]);

figure(fign)
clf
set(gcf,'Color','w')

contour(c{2},c{1},n)
h = colorbar;
h.Label.String = '# of Points';
h.Label.FontSize = 14;

hold on


h = refline([1,0]);
h.Color = 'k';

ylim(ca)
xlim(ca)

xlabel(['Ref. ',name],'fontsize',14)
ylabel(['Pert. ',name],'FontSize',14)



title({['month = ',num2str(month),' - year = 20',[tframe(end-1),tframe(end)]],...
    ['Mean of ',num2str(n_stat),' simulations'],...
    ['Uncertainties: SSS = ',num2str(SSS_unc), 'PSU - ',...
    'SST = ',num2str(SST_unc),'\circC - ',...
    'H = ',num2str(H_unc),' Wm^{-2} - ',...
    'W = ',num2str(W_unc)]},'fontsize',14)
% 
% hold on
% x = edges{1};
% disc = discretize(var_all,edges{1});
% disc1 = discretize(var_ll,edges{1});
% 
% for i = 1:length(x)
%     plot(x(i),nanmean(var_all(find(disc == i))),'ks')
%     plot(nanmean(var_ll(find(disc1 == i))),x(i),'ro')
% end

legend({['STD = ', num2str(nanstd(var_ll-var_all)),newline,'Mean = ',num2str(nanmean(var_ll-var_all)),newline,...
'Correlation = ',num2str(corr(var_ll(1:length(var_all)),var_all,'type','Pearson')),newline,...
'Total # of Points = ',num2str(sum(n(:)))]},'Position',...
[0.592885074746714,0.200743601268585,0.200675531313892,0.112676053166576])

end