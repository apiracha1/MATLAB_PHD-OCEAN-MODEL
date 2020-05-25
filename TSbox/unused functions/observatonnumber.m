 
function observatonnumber (tind,ocean,t)
   f = figure (1)
    worldmap world
    load coast
    plotm(lat,long)
    hold on
    [lat, lon, ~] = colTSreg_v2(ocean);
    [i,j] = ind2sub([length(lat),length(lon)],tind);

    plotm(lat(i),lon(j),'kx')
    title(['NO of observations = ',num2str(length(tind)),' Bin = ',num2str(t)])
    drawnow
end

    frame = getframe (f);
    im{i} = frame2im(frame);

    
filename = ([fullname,'.gif']);

original_dir = pwd;
mkdir([original_dir,'\gifs\','annual_frm_TS/',tframe,'/',sal,'/',temp,'/',hflux,'/',radflux,'/',evapo,'/',prec,'/',ocean(1:2),'/mc',num2str(n_stat)])
cd ([original_dir,'\gifs\','annual_frm_TS/',tframe,'/',sal,'/',temp,'/',hflux,'/',radflux,'/',evapo,'/',prec,'/',ocean(1:2),'/mc',num2str(n_stat)])

  
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

