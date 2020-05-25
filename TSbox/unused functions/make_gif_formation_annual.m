function make_gif_formation_annual (formation1_e, S, T, n_stat, formation1, ca_bar,colormap_jet_flag,longsss,longsst,ocean,fullname,evapo,prec,hflux,radflux,tframe,sal,temp)

% %%------------------------Start of Header----------------------------------
%
% ROUTINE                    make_gif_formation_annual
% AUTHOR                     Aqeel Piracha
% MAIL                       apiracha@btinternet.com
% DATE                       December 19th 2017
% VERSION                    1.0
% PURPOSE                    pcolor plot of all components of MC and creates 
%                            subsequent gif file, devised
%                            to verify MC 
%                            
%
%
% INPUT
% formation1_e               matrix containing formation values for each of
%                            the MC runs. 
% S, T,                      row and column vestor of salinity and
%                            temperature bins
% n_stat                     Number of MC realizations
% formation1                 Formation values when run without any MC
% ca_bar                     Colorbar values [min max]
% colormap_jet_flag          Choice of customize or default cmap (true=1
%                            false = 0
% longsss,longsst            fullname of Temperature Salinit product (SMOS,
%                            OSTIA)
% ocean,fullname             Abbreviation and fullname of basin (SA,South
%                            Atlantic
% %%------------------------END of Header----------------------------------
f = figure;
set (gcf,'Color',[1 1 1 1])
set(f,'units','normalized','outerposition',[0 0 1 1])

if strcmp(ocean,'NA2')
    fullname = 'NA';
end

    for i = 1:n_stat
        tt = formation1_e(i,:,:);
        tt_new (1:75,1:121) = tt (:,1:75,1:121);
        
        p = pcolor(S,T,tt_new); 
%         set (p,'alphadata', (zeros(size(tt_new))+1),'facealpha','flat')
        set(p,'edgecolor','none'); 
        hold on;       
        
        
        [C,h] = contour (S,T,formation1,'k-','LineWidth',.2); 
        clabel(C,h,'FontSize',8);
        
        xlabel([longsss,' SSS [g/kg]'],'fontsize',18)
        ylabel([longsst,' SST [^{\circ}C]'],'fontsize',18)
        title([fullname,' - 2011 MC = ',num2str(i)],'fontsize',18)
        
    if ~(ca_bar(1)==0)
        ca=ca_bar;
    else
        % bx=max(abs(bx1),abs(bx2)); axis with min max the same
        % ca = [round(-bx-bx/2) round(bx+bx/2)];
        ca = [bx1 bx2];
    end
    
    if colormap_jet_flag==true
    colormap(jet)
    else
    cm = anom_cmap_white(ca); colormap(cm);
    end
    cb = colorbar;
    set(get(cb,'ylabel'),'string','Formation [Sv]','fontsize',18)
    trange = -5:0.5:37;
    srange = 20:0.2:40;
    rho_contours(trange,srange); caxis(ca);
    set(gca,'fontsize',18)
    xlabel([longsss,' SSS [g/kg]'],'fontsize',18)
    ylabel([longsst,' SST [^{\circ}C]'],'fontsize',18)

        xlim([27 39]); ylim([0 35]); axis square
        
 
        drawnow;  
        hold off
        
        frame = getframe (f);
im{i} = frame2im(frame);
    end
    
filename = ([fullname,'.gif']);

original_dir = pwd;
mkdir([original_dir,'\gifs\','annual_form_TS/',tframe,'/',sal,'/',temp,'/',hflux,'/',radflux,'/',evapo,'/',prec,'/',ocean(1:2),'/mc',num2str(n_stat)])
cd ([original_dir,'\gifs\','annual_form_TS/',tframe,'/',sal,'/',temp,'/',hflux,'/',radflux,'/',evapo,'/',prec,'/',ocean(1:2),'/mc',num2str(n_stat)])

  
for i = 1:n_stat

    [A,Map] = rgb2ind(im{i},256);
    if i == 1
        imwrite(A,Map,filename,'gif','LoopCount',inf,'DelayTime',1);
    else
        imwrite(A,Map,filename,'gif','WriteMode','append','DelayTime',1);        
    end
end

cd (original_dir)
end













