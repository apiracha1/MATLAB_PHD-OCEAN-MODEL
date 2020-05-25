function draw_form_TS(formation_error_mean,season,fullname,tframe,S,T,longsss,longsst,h,std,...
    sal,months)
% grawing formation in TS space
                p = pcolor(S,T,formation_error_mean); set(p,...
                    'edgecolor','none');
                hold on
                ca = [-2 2];  
                cm = anom_cmap_nowhite(ca); set(h,'colormap',cm); 
                set(gcf,'color','w')
                trange = -5:0.5:37;
                srange = 20:0.2:40;
                rho_contours(trange,srange);  ca = [-2.5 2.5];  caxis(ca)
                set(gca,'fontsize',18)
                xlabel([longsss,' SSS [g/kg]'],'fontsize',18)
                ylabel([longsst,' SST [^{\circ}C]'],'fontsize',18)
                xlim([27 39]); ylim([0 35]); axis square
    %-----Correcting title regardless of datatypes-----------------------------            
                if isa(season,'cell')
                    season = season{1};
                end
                if ~std==1
                   if strcmp(sal,'smosOA')
                        h = subplot (2,4,5);
                        title({['Month = ',num2str(months),' - SMOS OA - 20',tframe(end-1:end)],...
                    'MEAN'})
                    else
                        h = subplot (2,4,1);
                        title({['Month = ',num2str(months),' - SMOS BINNED - 20',tframe(end-1:end)],...
                    'MEAN'})
                   end
                elseif std == 1 
                    ylabel([])
                    title('STD')
                end
    %-----Continuing plotting--------------------------------------------------
                c = colorbar;
                set(get(c,'ylabel'),'string','Formation [Sv]','fontsize',18)
                hold on
                
end
                