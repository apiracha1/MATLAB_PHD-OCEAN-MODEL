function [H,W,SSS,SST] = same_nans(H,W,SSS,SST)
%homogenises location of NAN values in all datasets
                nanmask = uni_nan_mask(0);
                H(isnan(nanmask)) = nan;
                W(isnan(nanmask)) = nan;
                SSS(isnan(nanmask)) = nan;
                SST(isnan(nanmask)) = nan;

end