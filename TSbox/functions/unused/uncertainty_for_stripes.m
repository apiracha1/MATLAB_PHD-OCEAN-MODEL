function nanmaskOA = uncertainty_for_stripes(n_stat,k,FpeakOA1)


    nanmaskOA = nan(size(FpeakOA1, 1),size(FpeakOA1,2));
    FpeakOA1 = permute(FpeakOA1,[1,2,4,3]);
    FpeakOA1 = nanmean(FpeakOA1,4);
    for l = 1:n_stat
            [i, j] = find (~isnan(FpeakOA1(:,:,l)));
            for t = 1:length(i)
                if ~isnan(nanmaskOA(i(t),j(t)))
                    nanmaskOA(i(t),j(t)) = nanmaskOA(i(t),j(t))+1;
                else
                    nanmaskOA(i(t),j(t)) = 1;
                end
            end
    end
    nanmaskOA(find(nanmaskOA==0)) = nan;
end