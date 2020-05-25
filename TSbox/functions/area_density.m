function area_density(var,var_e,sigma,dxx,dyy,n_stat,ocean,BinSize,fign)

lat_len = size(var,2);
lon_len = size(var,1);

num_classes = round(length(sigma(1):BinSize:sigma(end)));
bin_edges = linspace(sigma(1),sigma(end),num_classes);

[var_discretized,e] = discretize(var,bin_edges);

num_points = nan(1,num_classes);
num_points_e = nan(1,num_classes,n_stat);

area = nan(1,num_classes);
area_e = nan(1,num_classes,n_stat);

for n = 1:num_classes
    bin_ind = find(var_discretized == n);
    [row,col] = ind2sub([lon_len,lat_len],bin_ind);
    hold on
    num_points(1,n) = length(col);
%     areaa = dxx(row,col).*dyy(row,col);
%     area(1,n) = sum(areaa(:))/length(row);
    for o = 1:n_stat
        var_discretized_e = discretize(var_e(:,:,o),bin_edges);
        bin_ind = find(var_discretized_e == n);
        [row,col] = ind2sub([lon_len,lat_len],bin_ind);
        num_points_e(1,n,o) = length(col);
%         areaa = dxx(row,col).*dyy(row,col);
%         area_e(1,n,o) = sum(areaa(:))/length(row);
    end
    
end

Dif = abs(num_points-nanmean(num_points_e,3));
% Dif_a = abs(area-nanmean(area_e,3));
figure(fign)
clf
set(gcf,'Color','w')
plot(e,num_points,'r--')
hold on
errorbar(e,nanmean(num_points_e,3),nanstd(num_points_e,3),'k--')
plot(e,Dif,'m-.')
ylabel('# of points')
xlabel('\rho [kgm^{-3}]')
ylim([min(num_points(:)) max(num_points(:))])
legend('Ref. # of points','Mean # of points with error bars','Ref-Mean')
title({['# of points per density class w/ bin size = ',num2str(BinSize)],...
    ['Total # of points in ',ocean,' = ',num2str(sum(num_points))]})

figure(fign+1)
clf
set(gcf,'color','w')
plot(e,area/1e6,'r-')
hold on
errorbar(e,nanmean(area_e,3)/1e6,nanstd(area_e,3)/1e6,'k-')
plot(e,Dif_a/1e6,'m-.')
ylabel('Area [km^2]')
ylim([min(area(:))/1e6 max(area(:))/1e6])
xlabel('\rho [kgm^{-3}]')
legend('Ref. Area', 'Mean area with errorbars','Ref-Mean')
title({['Area per density class w/ bin size = ',num2str(BinSize)],...
    ['Total area of ',ocean,' = ',num2str(nansum(area)/1e6)]})

end