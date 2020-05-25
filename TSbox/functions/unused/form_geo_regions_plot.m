function form_geo_regions_plot(ocean,n_rows,n_cols,cur_splot,form_dat,min_clim,max_clim,lat,lon,sal,month,tframe,n_stat,k)
% geo_form_plot                             Plots geo form.   
%============================================================
% 
% USAGE:  
% geo_form_plot(n_rows,n_cols,cur_splot,form_dat,min_clim,max_clim)
% 
%  Note that geo_form_plot from dync_plot_stripes and Control_Center
%
% DESCRIPTION:
%  **As of 10/10/2019 
% Function plots geo location of formation 
%
% INPUT:
%  ocean = ocean name           [ string ] 
%  n_rows  =  number of rows of figure to plot to       [ number ]
%  n_cols = number of cols of figure to plot to     [ number ]
%  cur_splot = particular subplot to plot to    [ number ]
%  form_data = Actual formation data to be plotted  [ number ]
%  min_clim = lower limit of colorbar   [ number ]
%  max_clim = upper limit of colorbar   [ number ]
% 
% OUTPUT:
% None
% 
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1 (Friday 11th October 2019) *****STARTING FRESH COUNT
%
% REFERENCES:
% None
%
% The software is currently in development
%
%============================================================
% figure(13);
figure(13+k)
% subplot(n_rows,n_cols,cur_splot)        % correct subplot
[latitude,longitude,~] = colTSreg_v2(ocean);    % lat lon for basin
map_basin(latitude,longitude,ocean)  % correct world map plot
pcolorm(lat,lon,form_dat')      % plotting geo form
ca = [min_clim max_clim];  caxis(ca)    % for colormap and colorbar
cm = anom_cmap_nowhite(ca); 
% set(gca,'colormap',cm);        hold on
set(gcf,'colormap',cm); hold on

c = colorbar;
set(c,'Location','southoutside','Position',[0.131609885781344,...
    0.252754575630321,...
    0.774383048648828,...
    0.021333333333333])       % location of the colorbar
set(get(c,'ylabel'),'string','Formation [mseason^-^1]','fontsize',18)   % colorbar label
    title({[sal,' month = ',num2str(month),...
        ' - 20',tframe(end-1:end),' - ',ocean],...
        [num2str(n_stat),' simulations']})
end