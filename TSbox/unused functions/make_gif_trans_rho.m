function make_gif_trans_rho(Frho_all_stat,Frho_all_1st,sigma0,n_stat,fullname,e1,ocean,Frho_all_mean,sal,temp,tframe,evapo,prec,hflux,radflux)

% %%------------------------Start of Header----------------------------------
%
% ROUTINE                    make_gif
% AUTHOR                     Aqeel Piracha
% MAIL                       apiracha@btinternet.com
% DATE                       December 17th 2017
% VERSION                    1.0
% PURPOSE                    plot of all components of MC dens flux vs dense 
%                            and creates 
%                            subsequent gif file, devised
%                            to verify MC 
%                            
%
%
% INPUT
% Frho_all_stat              matrix containing dense flux values for each of
%                            the MC runs. 
% sigma0                     row vector of density values (bins) 
% n_stat                     Number of MC realizations
% Frho_all_1st               dense flux values when run without any MC
% e1                         Error bar values
% ocean,fullname             Abbreviation and fullname of basin (SA,South
%                            Atlantic
% Frho_all_mean              mean denseflux of all MC realizations
% %%------------------------END of Header----------------------------------


mblu = [0 0.4 1];
dred = [0.8 0 0];
ora = [1 0.5 0];


h = figure;
set (gcf,'Color',[1 1 1 1])
set(h,'units','normalized','outerposition',[0 0 1 1])
x1 = sigma0-1000;
y1 = Frho_all_mean(1,:);

for i = 1:n_stat
    tt = Frho_all_stat(i,1,:);
    plot(sigma0-1000,tt(1,:),'color','m','linewidth',2); 

    hold on;

    
    plot(sigma0-1000,Frho_all_1st(1,:),'color',mblu,'linewidth',1.5);
    plot(sigma0-1000,Frho_all_1st(2,:),'color',ora,'linewidth',1.5);
    plot(sigma0-1000,Frho_all_1st(3,:),'color',dred,'linewidth',1.5);
    plot(sigma0-1000,Frho_all_mean(1,:),'color','k','linewidth',1.5);
%     (errorbar(x1,y1,e1,'color',mblu,'linewidth',0.5));
    
    plot(20:30,zeros(size(20:30)),'k-');
    xlabel('SS\sigma0 [kgm^{-3}] ','fontsize',16)
    ylabel('density flux [10^6 m^3/s]','fontsize',16)
    if strcmp(tframe, 'jan11dec11')
        title([fullname,' - 2011'],'fontsize',18)
    elseif strcmp(tframe, 'jan12dec12')
        title([fullname,' - 2012'],'fontsize',18)
    elseif strcmp(tframe, 'jan13dec13')
        title([fullname,' - 2013'],'fontsize',18)
    elseif strcmp(tframe, 'jan14dec14')
        title([fullname,' - 2014'],'fontsize',18)    
    end

    xlim ([20 28])
    if strcmp(sal(1,:),'aqOI   ')
        legend (['Aquarius/OSTIA for n = ',num2str(i)],'Aquarius/OSTIA','WOA09','Argo','Mean of 50 MC','Location','southeast')
    else
        legend (['SMOS/OSTIA for n = ',num2str(i)],'SMOS/OSTIA','WOA09','Argo','Mean of 50 MC','Location','southeast')
    end

   
%     if strcmp(ocean,'TP') || strcmp(ocean,'NP')
%         ylim([sign(min(Frho_all_1st(:))).*(abs(min(Frho_all_1st(:))))-10-max(e1) max(Frho_all_1st(:))+max(e1)+10]); 
%         xlim([20 28])
%     else
%         ayy = round(max(max(abs(Frho_all_1st(:)- abs(max(Frho_all_1st(:)...
%             +max(e1(:))))))*.5)/10);
%         ylim([min(Frho_all_1st(:)-max(e1))-ayy max(Frho_all_1st(:)...
%             +max(e1))+ayy]); xlim([20 28])
%     end
%     
    hold off;
    drawnow; 
%     pause (1);  

    frame = getframe (h);
    im{i} = frame2im(frame);

end


filename = (['North Atlantic.gif']);

original_dir = pwd;

mkdir([original_dir,'\gifs\','annual_trans_rho/',tframe,'/',sal(1,1:end-3),'/',temp(1,1:end-3),'/',hflux,'/',radflux,'/',evapo,'/',prec,'/',ocean(1:2),'/mc',num2str(n_stat)])
cd ([original_dir,'\gifs\','annual_trans_rho/',tframe,'/',sal(1,1:end-3),'/',temp(1,1:end-3),'/',hflux,'/',radflux,'/',evapo,'/',prec,'/',ocean(1:2),'/mc',num2str(n_stat)])
    


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