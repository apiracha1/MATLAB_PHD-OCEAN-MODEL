function form_TS_plot(formation_error,S,T,ocean,tframe,sal,month,n_stat)
% form_TS_plot                             plots formation versus temp and sal        [ Sv ]
%============================================================
% 
% USAGE:  
% form_TS_plot(formation_error,S,T,ocean,tframe,sal,month)
%                                                   *All variables set
%                                                   through Control_Center
% 
%  Note that form_TS_plot has all variables pre set through
%  choices in Control_Center.
%
% DESCRIPTION:
%  **As of 19/11/2019 
% Function creates full plot with axis titles and correct limits of
% water mass formation with temp and sal
%
% INPUT:
%  formation_error = formation in TS space accross all monte-carlo simulations      [ 3-D matrix ]
% [T,S] = temperature salinity bins  [ vector (kgm-3) ]
% ocean = name of basin     [ string ]
% tframe = selected year           [ string ] (FORMAT: jan##dec##, ## = 12 for 2012 e.t.c.)
% sal = salinity dataset name   [ string ]
% month = month chosen   [ number ]
% 
% OUTPUT:
% None
% 
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1 (Tuesday 19th November 2019) *******STARTING FRESH COUNT
% NOTES on VERSION:
% None
%
% REFERENCES:
%
% The software is currently in development
%
%============================================================


%% Mean
    figure(12)
%     subplot(1,2,1)
    formation_error = permute(formation_error,[2 3 1]);
    pcolor(S,T,nanmean(formation_error,3));
    shading flat
    hold on
    trange = -5:0.5:37;
    srange = 20:0.2:40;
    rho_contours(trange,srange);
    xlabel('Salinity [PSU]')
    ylabel('Temperature (\circC)')
    title({[sal,' month = ',num2str(month),...
        ' - 20',tframe(end-1:end),' - ',ocean],...
        [num2str(n_stat),' simulations']})
    axis('square')
    ca = [-7 7]; 
    cm = anom_cmap_nowhite(ca);
    caxis(ca)
    colormap(cm)
    c = colorbar;
    c.Label.String = 'Formation [Sv]';

%% STD
%     fig = subplot(1,2,2);  
    fig = figure(13);
    ca = [0 9]; 
    pcolor(S,T,nanstd(formation_error,3));
%     set(gca,'Colormap',jet)
    set(fig,'colormap',jet); 
    caxis(ca)
    shading flat
    hold on
    trange = -5:0.5:37;
    srange = 20:0.2:40;
    rho_contours(trange,srange);
    xlabel('Salinity [PSU]')
    ylabel('Temperature (\circC)')
    title({[sal,' month = ',num2str(month),...
        ' - 20',tframe(end-1:end),' - ',ocean],...
        [num2str(n_stat),' simulations']})
    axis('square')
    c = colorbar;
    c.Label.String = 'Formation [Sv]';
end
