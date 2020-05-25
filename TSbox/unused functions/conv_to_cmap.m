function conv_to_cmap (fignum)
% %%------------------------Start of Header--------------------------------
%
% ROUTINE                    conv_to_cmap
% AUTHOR                     Aqeel Piracha
% MAIL                       apiracha@btinternet.com
% DATE                       November 13th 2017
% VERSION                    1.0
% PURPOSE                    corrects STD cmap for option 1
%
%
% INPUT
% hh      -   figure 
% %%------------------------End of Header----------------------------------
figure(fignum);
    ca = [floor(0) ceil(0.08)];
    caxis (ca);
    cm = anom_cmap_white(ca);
    colormap (cm);
end
