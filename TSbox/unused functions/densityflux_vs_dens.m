New_Fstd = nan(12,80);
New_Fmean = nan(12,80);
New_Fmean_error = nan (10,1,80);
for n = 1:10
    for h = 1:12
        Fmean_at_bin = [];
        for i = 1020.1:0.1:1028
            [indices_of_bins] = find(orho(:,:,h) > (i-0.1) & orho(:,:,h) < i);
            Fmean_at_MC = Fmean1(:,:,n);
            Fmean_in_bins = Fmean_at_MC(indices_of_bins);
            Fmean_for_bins = nanmean(Fmean_in_bins(:));
            Fmean_at_bin = [Fmean_at_bin Fmean_for_bins];
        end
        New_Fmean(h,:) = Fmean_at_bin;
    end
    New_Fmean = New_Fmean*1e6;
    New_Fmean = nanmean(New_Fmean,1);
    figure (10)
    subplot(3,1,1)
    mblu = [0 0.4 1];
    dred = [0.8 0 0];
    ora = [1 0.5 0];
%     hold off
%     plot (20.1:.1:28,New_Fmean,'color',ora,'linewidth',1.5)
%     hold on
%     plot(20:30,zeros(size(20:30)),'k-')
    ylim([-4.5 1.5])
    xlim([20 28])
%     pause
%     title([num2str(n)],'fontsize',10)
    drawnow
    New_Fmean_error(n,:,:) = New_Fmean;
end
New_Fmean_error = permute(New_Fmean_error,[2 3 1]);

plot (20.1:.1:28,nanmean(New_Fmean_error,3),'color',mblu,'linewidth',1.5)
   


for h = 1:12
    Fstd_at_bin = [];
    for i = 1020.1:0.1:1028
        [indices_of_bins] = find(orho(:,:,h) > (i-0.1) & orho(:,:,h) < i);
        Fmean_in_bins = Fmean_std(indices_of_bins);
        Fmean_for_bins = nanmean(Fmean_in_bins(:));
        Fstd_at_bin = [Fstd_at_bin Fmean_for_bins];
    end
    New_Fstd(h,:) = Fstd_at_bin;
end
New_Fstd = New_Fstd*1e6;
New_Fstd = nanmean(New_Fstd,1);
figure (10)
subplot(3,1,1)
errorbar(20.1:.1:28,New_Fmean,New_Fstd,'color',mblu,'linewidth',0.5)
% ylabel('density flux [kgm^-^2s^-^1]','fontsize',10)