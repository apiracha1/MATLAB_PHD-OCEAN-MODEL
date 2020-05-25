function make_gif_reg_transf(Fmean_e,ocean,tframe,sal,temp,hflux,radflux,evapo,prec,n_stat,longsss,longsst)

Fmean = permute(Fmean_e,[2,3,1]);


h = figure (2);
%     xlim([-180 180])
%     ylim([-79.5 79.5])

set (gcf,'Color',[1 1 1 1])
set(h,'units','normalized','outerposition',[0 0 1 1])

cb = colorbar('southoutside');
set(gca,'fontsize',14)
set(gca,'xtick',-150:50:150,'xticklabel',{'150W','100W','50W','0','50E','100E','150E'})
ca = [-1e-5 1e-5];
cm = anom_cmap(ca);
colormap(cm);caxis(ca);
set(get(cb,'ylabel'),'string','density flux [kgs^{-1}m^{-2}]','fontsize',15)
hold on;

set(gcf,'color',[1 1 1])
set(gcf, 'InvertHardCopy', 'off');
grid on; 
set(gca,'layer','top')

load coast
[latitude, longitude, ~] = colTSreg_v2(ocean);

if strcmp(ocean,'NP') || strcmp(ocean,'SO') || strcmp(ocean,'SP')
    long(long<0) = long(long<0) + 360;
    long(long>359.5 | long < 0.5) = nan;
elseif strcmp(ocean,'SA')
    Fmean = [Fmean(:,31:end,:) Fmean(:,1:30,:)];
elseif strcmp(ocean,'NA2')
    Fmean = [Fmean(:,16:end,:) Fmean(:,1:15,:)];
elseif strcmp(ocean,'all')
    Fmean = [Fmean(:,181:end,:) Fmean(:,1:180,:)];
    longitude = -179.5:179.5;
end

load coast

for i = 1:n_stat;
    
if strcmp (ocean,'SO')
    worldmap ([-90 latitude(end)],[longitude(1) longitude(end)])
else
    worldmap ([latitude(1) latitude(end)],[longitude(1) longitude(end)])
end
    
plotm(lat,long)
land = shaperead('landareas.shp','UseGeoCoords',true);
geoshow(land,'FaceColor',[0.8 0.8 0.8]) 
hold on
p = pcolorm(latitude',longitude,Fmean(:,:,i)*1e6); set(p,'edgecolor','none')
contourm(latitude',longitude,Fmean(:,:,i)*1e6,'k-');

title({[longsss,' SSS and ',longsst,' SST'],['Global density flux for n = ',num2str(i)]},'fontsize',10)




set(p,'edgecolor','none');
drawnow

hold off
frame = getframe (h);
im{i} = frame2im(frame);
end

filename = (['global_transf.gif']);


original_dir = pwd;
mkdir([original_dir,'\gifs\','annual_reg_transf/',tframe,'/',sal,'/',temp,'/',hflux,'/',radflux,'/',evapo,'/',prec,'/',ocean(1:2),'/mc',num2str(n_stat)])
cd ([original_dir,'\gifs\','annual_reg_transf/',tframe,'/',sal,'/',temp,'/',hflux,'/',radflux,'/',evapo,'/',prec,'/',ocean(1:2),'/mc',num2str(n_stat)])

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
