

salinity_ARGO_2012 = nan(360,180,12);
temperature_ARGO_2012 = nan(360,180,12);
original_dir = pwd;

for i = 1:12
    

    cd (original_dir)
    if i < 10
        temp = ncread(['BOA_Argo_2012_0',num2str(i),'.nc'],'temp');
        salt = ncread(['BOA_Argo_2012_0',num2str(i),'.nc'],'salt');
    else
        temp = ncread(['BOA_Argo_2012_',num2str(i),'.nc'],'temp');
        salt = ncread(['BOA_Argo_2012_',num2str(i),'.nc'],'salt');
    end
    
    temp = temp(:,:,1);
    salt = salt(:,:,1);
    
    salinity_ARGO = nan(360,180);
    temperature_ARGO = nan(360,180);
    
    [OY,OX] = meshgrid(-79.5:79.5,0.5:359.5);
    [NY,NX] = meshgrid(-89.5:89.5,0.5:359.5);
    
    salinity_ARGO = single(interp2(OY,OX,salt,NY,NX,'bilinear')); 
    temperature_ARGO = single(interp2(OY,OX,temp,NY,NX,'bilinear'));
    
    cd ../2012_monthly_mat_files
    save(['salinity_ARGO_',num2str(i)],'salinity_ARGO');
    save(['temperature_ARGO_',num2str(i)],'temperature_ARGO');
    
    salinity_ARGO_2012 (:,:,i) = salinity_ARGO;
    temperature_ARGO_2012 (:,:,i) = temperature_ARGO;
    
    pcolorm(lat,lon',temperature_ARGO)
    colormap ('jet')
    caxis([-2 37])
    
    drawnow
    
end

cd ../2012_monthly_mat_files
save('temperature_ARGO_2012','temperature_ARGO_2012');
save('salinity_ARGO_2012','salinity_ARGO_2012');



