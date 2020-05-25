function make_gif_seas_form(formation1_e,seasx,n_stat,S,T,uu,vv,tframe,sal,temp,hflux,radflux,evapo,prec,ocean,ca_bar,longsss,longsst,fullname)


    NASTMW_S = 36.5;
    NPSTMW_S = 34.85;
    SASTMW_S = 35.7;
    SPSTMW_S = 35.5;
    IOSTMW_S = 35.51;
    SOSTMW_S = 35;

    NASTMW_T = 18;
    NPSTMW_T = 16.5;
    SASTMW_T = 15;
    SPSTMW_T = 17;
    IOSTMW_T = 16.54;
    SOSTMW_T = 9.5;
    h = figure;
    set (gcf,'Color',[1 1 1 1])
    set(h,'units','normalized','outerposition',[0 0 1 1])

    for i = 1:seasx
        for j = 1:n_stat
            formation_xx1(1:uu,1:vv,1:4)=formation1_e(:,:,:,j);
            
            p = pcolor(S,T,formation_xx1(:,:,i));
            set(p,'edgecolor','none'); shading flat
            
            hold on
            cb = colorbar;
            
            ca=ca_bar;
            cm = anom_cmap_nowhite(ca); colormap(cm);
            
            pos = [0.85 0.2 0.03 0.6];
            set(cb,'position',pos); set(gca,'fontsize',14)
            set(get(cb,'ylabel'),'string','Formation [Sv]','fontsize',14)
            trange = -5:0.5:37;
            srange = 20:0.2:40;
            rho_contours(trange,srange); caxis(ca);
            set(gca,'fontsize',18)
            xlabel([longsss,' SSS [g/kg]'],'fontsize',18)
            ylabel([longsst,' SST [^{\circ}C]'],'fontsize',18)
            title({[fullname,' - ','Year = 20',tframe(end-1:end)],['season = ', num2str(i), ' MC = ', num2str(j)]},'fontsize',18)
            xlim([27 39]); ylim([0 35]); axis square
            set(gca,'xtick',27:3:39)
            
            drawnow; 
%             pause(0.5)
            hold off

            if strcmp(ocean,'NA2')
                Theta_S_pos1 = NASTMW_S - (0.3);
                Theta_S_pos2 = NASTMW_S + (0.3);
                Theta_T_pos1 = NASTMW_T + 0.6;
                Theta_T_pos2 = NASTMW_T - 0.6;
            elseif strcmp(ocean,'NP')
                Theta_S_pos1 = NPSTMW_S - (0.3);
                Theta_S_pos2 = NPSTMW_S + (0.3);
                Theta_T_pos1 = NPSTMW_T + 0.6;
                Theta_T_pos2 = NPSTMW_T - 0.6;
            elseif strcmp(ocean,'SA')
                Theta_S_pos1 = SASTMW_S - (0.3);
                Theta_S_pos2 = SASTMW_S + (0.3);
                Theta_T_pos1 = SASTMW_T + 0.6;
                Theta_T_pos2 = SASTMW_T - 0.6;
            elseif strcmp(ocean,'SP')
                Theta_S_pos1 = SPSTMW_S - (0.3);
                Theta_S_pos2 = SPSTMW_S + (0.3);
                Theta_T_pos1 = SPSTMW_T + 0.6;
                Theta_T_pos2 = SPSTMW_T - 0.6;
           elseif strcmp(ocean,'IO')
                Theta_S_pos1 = IOSTMW_S - (0.3);
                Theta_S_pos2 = IOSTMW_S + (0.3);
                Theta_T_pos1 = IOSTMW_T + 0.6;
                Theta_T_pos2 = IOSTMW_T - 0.6;
           elseif strcmp(ocean,'SO')
                Theta_S_pos1 = SOSTMW_S - (0.3);
                Theta_S_pos2 = SOSTMW_S + (0.3);
                Theta_T_pos1 = SOSTMW_T + 0.6;
                Theta_T_pos2 = SOSTMW_T - 0.6;
           end     

            rectangle('Position',[ Theta_S_pos1 Theta_T_pos2...
                Theta_S_pos2-Theta_S_pos1 Theta_T_pos1-Theta_T_pos2],...
                'linewidth',1.5,'edgecolor','b')
            
            frame = getframe (h);
            im{j,i} = frame2im(frame);
        end
    end
    filename = (['seas_form.gif']);


    original_dir = pwd;
    mkdir([original_dir,'\gifs\','seas_form_TS/',tframe,'/',sal,'/',temp,'/',hflux,'/',radflux,'/',evapo,'/',prec,'/',ocean(1:2),'/mc',num2str(n_stat)])
    cd ([original_dir,'\gifs\','seas_form_TS/',tframe,'/',sal,'/',temp,'/',hflux,'/',radflux,'/',evapo,'/',prec,'/',ocean(1:2),'/mc',num2str(n_stat)])
    
    
    for j = 1:seasx
        for i = 1:n_stat
        [A,Map] = rgb2ind(im{i,j},256);
            if j == 1 && i == 1
                imwrite(A,Map,filename,'gif','LoopCount',inf,'DelayTime',1);
            else
                imwrite(A,Map,filename,'gif','WriteMode','append','DelayTime',1);        
            end
        end
    end

    cd (original_dir) 
end