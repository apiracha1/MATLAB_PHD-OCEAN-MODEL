%  %% added luigi CAstaldo 08.03.2016 TP
% [c] = latlonlabel(ocean,cb)
%
% labels the x- and y-axis for each region and creates a colorbar if cb is
% set to 1 and returns the colorbar handle c
%
% correction SO bound may 24th 2016
% %% Aqeel Piracha (piracha.aqeel@gmail.com)
%  corrected to lat in tropical pacific


function [c] = latlonlabel(ocean,cb)

if strcmp(ocean,'IO')
    set(gca,'xtick',35:15:120,'xticklabel',{'35E','50E','65E','80E','95E','110E'})
    set(gca,'ytick',[-30 -15 0 15],'yticklabel',{'30S','15S','0','15N'})
    set(gca,'fontsize',14)
    if cb == 1
        c = colorbar('v');  pos = [0.918576388888889,0.110878661087866,0.028819444444445,0.755230125523012];
        set(c,'position',pos); set(gca,'fontsize',14)
    end
elseif strcmp(ocean,'TP')
    %     longitude = 120:280;
    %     latitude = 71:110;
    set(gca,'xtick',120:30:280,'xticklabel',{'120E','150E','180E','150W','120W','90W'})
    set(gca,'ytick',-15:15:20,'yticklabel',{'15S','0','15N'})
    set(gca,'fontsize',14)
    if cb == 1
        c = colorbar('v');  pos = [0.918576388888889,0.110878661087866,0.028819444444445,0.755230125523012];
        set(c,'position',pos); set(gca,'fontsize',14)
    end
    
    
elseif strcmp(ocean,'SO')
    set(gca,'xtick',[1,60:60:360],'xticklabel',{'0','60E','120E','180','120W','60W','0'})
    set(gca,'ytick',(-79.5:15:-40.5),'yticklabel',{'79S','65S','50S'})
%  set(gca,'ytick',(-40.5:20:-89.5),'yticklabel',{'49S','70S','90S'})
    set(gca,'fontsize',14)
    if cb == 1
        c = colorbar('v');  pos = [0.918576388888889,0.110878661087866,0.028819444444445,0.755230125523012];
        set(c,'position',pos); set(gca,'fontsize',14)
    end
elseif strcmp(ocean,'SP')
    set(gca,'xtick',120:20:300,'xticklabel',{'120E','140E','160E','180','160W','140W','120W','100W','80W','60W'})
    set(gca,'ytick',-40:10:-10,'yticklabel',{'40S','30S','20S','10S'})
    set(gca,'fontsize',14)
    if cb == 1
        c = colorbar('v');  pos = [0.918576388888889,0.110878661087866,0.028819444444445,0.755230125523012];
        set(c,'position',pos); set(gca,'fontsize',14)
    end
elseif strcmp(ocean,'EP')
    set(gca,'xtick',120:20:280,'xticklabel',{'120E','140E','160E','180','160W','140W','120W','100W','80W'})
    set(gca,'ytick',-4:4:4,'yticklabel',{'4S','0','4N'})
    set(gca,'fontsize',14)
    if cb == 1
        c = colorbar('v');  pos = [0.918576388888889,0.110878661087866,0.028819444444445,0.755230125523012];
        set(c,'position',pos); set(gca,'fontsize',14)
    end
elseif strcmp(ocean,'NP')
    set(gca,'xtick',140:20:220,'xticklabel',{'140E','160E','180','160W','140W'})
    set(gca,'ytick',10:20:50,'yticklabel',{'10N','30N','50N'})
    set(gca,'fontsize',14)
    if cb == 1
        c = colorbar('v');  pos = [0.918576388888889,0.110878661087866,0.028819444444445,0.755230125523012];
        set(c,'position',pos); set(gca,'fontsize',14)
    end
elseif strcmp(ocean,'NA')
    set(gca,'xtick',-80:15:0,'xticklabel',{'80W','65W','50W','35W','20W','5W'})
    set(gca,'ytick',0:10:40,'yticklabel',{'0','10N','20N','30N','40N'})
    set(gca,'fontsize',14)
    if cb == 1
        c = colorbar('v');  pos = [0.918576388888889,0.110878661087866,0.028819444444445,0.755230125523012];
        set(c,'position',pos); set(gca,'fontsize',14)
    end
    
elseif strcmp(ocean,'NA2')
    set(gca,'xtick',-70:20:20,'xticklabel',{'70W','50W','30W','10W','10E'})
    set(gca,'ytick',-10:10:50,'yticklabel',{'10S','0','10N','20N','30N','40N','50N'})
    set(gca,'fontsize',14)
    if cb == 1
        c = colorbar('v');  pos = [0.918576388888889,0.110878661087866,0.028819444444445,0.755230125523012];
        set(c,'position',pos); set(gca,'fontsize',14)
    end
elseif strcmp(ocean,'NAext')
    set(gca,'xtick',-80:15:0,'xticklabel',{'80W','65W','50W','35W','20W','5W'})
    set(gca,'ytick',-20:10:50,'yticklabel',{'20S','10S','0','10N','20N','30N','40N','50N'})
    set(gca,'fontsize',14)
    if cb == 1
        c = colorbar('v');  pos = [0.918576388888889,0.110878661087866,0.028819444444445,0.755230125523012];
        set(c,'position',pos); set(gca,'fontsize',14)
    end
elseif strcmp(ocean,'SA')
    set(gca,'xtick',-50:10:30,'xticklabel',{'50W','40W','30W','20W','10W','0','10E','20E'})
    set(gca,'ytick',-35:10:-5,'yticklabel',{'35S','25S','15S','5S'})
    set(gca,'fontsize',14)
    if cb == 1
        c = colorbar('v');  pos = [0.918576388888889,0.110878661087866,0.028819444444445,0.755230125523012];
        set(c,'position',pos); set(gca,'fontsize',14)
    end
elseif strcmp(ocean,'all')
    c = [];
    set(gca,'xtick',[1,60:60:360],'xticklabel',{'0','60E','120E','180','120W','60W','0'})
    set(gca,'ytick',-90:30:90,'yticklabel',{'90S','60S','30S','0','30N','60N','90N'})
    if cb == 1
        c = colorbar('v');  pos = [0.918576388888889,0.110878661087866,0.028819444444445,0.755230125523012];
        set(c,'position',pos); set(gca,'fontsize',14)
    end
%     set(gca,'position',[0.13 0.16 0.775 0.815])
    set(gca,'fontsize',14)
end
