figure
worldmap world
load coast


for j = 1:12
for i = 1:2;  plotm(lat,long);hold on;
%% plotting peaks
load('Fpeak_NA_2012.mat')
Fpeak_m__(1:sizes(1),1:sizes(2)) = Fpeak(:,:,j,i);
Fpeak_m__(find(Fpeak_m__ == 0)) = NaN;
%             pcolorm(longitude,latitude,Fpeak_m__);
p = pcolorm(latitude,longitude,Fpeak_m__); 
clear Fpeak

load('Fpeak_SA_2012.mat')
Fpeak_m__(1:sizes(1),1:sizes(2)) = Fpeak(:,:,j,i);
Fpeak_m__(find(Fpeak_m__ == 0)) = NaN;
%             pcolorm(longitude,latitude,Fpeak_m__);
p = pcolorm(latitude,longitude,Fpeak_m__);
clear Fpeak

load('Fpeak_NP_2012.mat')
Fpeak_m__(1:sizes(1),1:sizes(2)) = Fpeak(:,:,j,i);
Fpeak_m__(find(Fpeak_m__ == 0)) = NaN;
%             pcolorm(longitude,latitude,Fpeak_m__);
p = pcolorm(latitude,longitude,Fpeak_m__);
clear Fpeak

load('Fpeak_SP_2012.mat')
Fpeak_m__(1:sizes(1),1:sizes(2)) = Fpeak(:,:,j,i);
Fpeak_m__(find(Fpeak_m__ == 0)) = NaN;
%             pcolorm(longitude,latitude,Fpeak_m__);
p = pcolorm(latitude,longitude,Fpeak_m__);
clear Fpeak

load('Fpeak_IO_2012.mat')
Fpeak_m__(1:sizes(1),1:sizes(2)) = Fpeak(:,:,j,i);
Fpeak_m__(find(Fpeak_m__ == 0)) = NaN;
%             pcolorm(longitude,latitude,Fpeak_m__);
p = pcolorm(latitude,longitude,Fpeak_m__);
clear Fpeak

load('Fpeak_SO_2012.mat')
Fpeak_m__(1:sizes(1),1:sizes(2)) = Fpeak(:,:,j,i);
Fpeak_m__(find(Fpeak_m__ == 0)) = NaN;
%             pcolorm(longitude,latitude,Fpeak_m__);
p = pcolorm(latitude,longitude,Fpeak_m__);
clear Fpeak

drawnow; pause (0.5); hold off
end
end