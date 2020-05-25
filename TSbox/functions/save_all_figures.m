function save_all_figures(fignum,fig_num_name,var,unc)
% save_all_figures                              saves all figures output by
%                                                               computation run
%============================================================
% 
% USAGE:  
% save_all_figures()
%                                                   
% DESCRIPTION:
%  **As of 16/10/2019 
% Function saves outputted figures from computation run in 3 formats
%         [ *.fig ]
%         [ *.png ]
%         [ *.jpg ]
%
% INPUT:
%  fignum = figure number(s) to save  [ number ]
%  fig_num_name = figure number to start figure name count [ number ]
% 
% OUTPUT:
%  None
%
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1 ( Saturday 2nd November 2019) *******STARTING FRESH COUNT
% NOTES on VERSION:
%                                   None
%
% REFERENCES:
% None 
%
% The software is currently in development
%
%============================================================
orig_dir = pwd;
mkdir (['/home/ap/PHD-BEC/Figures/*.fig/',var,'/',unc])
mkdir (['/home/ap/PHD-BEC/Figures/*.png/',var,'/',unc])
mkdir (['/home/ap/PHD-BEC/Figures/*.jpg/',var,'/',unc])
for fign = fignum
    figure(fign)
% save figure as *.fig
cd (['/home/ap/PHD-BEC/Figures/*.fig/',var,'/',unc])
% cd /run/media/apiracha/Drive/Documents/LatexDocuments/PHD-BEC/Figures/.fig/
    savefig(['fig',num2str(fig_num_name+(fign-fignum(1)))])
%  save as *.png
cd (['/home/ap/PHD-BEC/Figures/*.png/',var,'/',unc])
% cd /run/media/apiracha/Drive/Documents/LatexDocuments/PHD-BEC/Figures/.png/
    print(['fig',num2str(fig_num_name+(fign-fignum(1)))],'-dpng','-r600')
% save as *.jpg
cd (['/home/ap/PHD-BEC/Figures/*.jpg/',var,'/',unc])
% cd /run/media/apiracha/Drive/Documents/LatexDocuments/PHD-BEC/Figures/.jpg/
    print(['fig',num2str(fig_num_name+(fign-fignum(1)))],'-djpeg','-r600')
end
cd(orig_dir)
end