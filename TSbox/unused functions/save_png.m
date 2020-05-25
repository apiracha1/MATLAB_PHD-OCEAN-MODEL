function save_png(plot_val_array,txt_xlabel,txt_ylabel,name_fig,ocean,val_fig)

title_xx=strcat(name_fig,'-',ocean);
h1=figure(val_fig); imagesc(plot_val_array);
    xlabel(txt_xlabel,'fontsize',18)
    ylabel(txt_ylabel,'fontsize',18)
    title(title_xx,'fontsize',18)
    colorbar
%     eval(['print -dpng ./figures/test/',title_xx]) 
    saveas(h1,strcat('./figures/test/',title_xx),'png')