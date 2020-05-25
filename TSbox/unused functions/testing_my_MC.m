




%% for temperature (lat,lon,m,n_stat) 
for i = 1:1000
for mm = 1:12
SST123(:,:,mm,i) = SST(:,:,mm) + rand(180,360,1) .* 0.42;
end
end

% pcolor pot of global temperature for all MC overlayed satellite contour of
% global dens.
for i = 1:1000
    hold off; 
    pcolor (SST123 (:,:,1,i)); 
    shading flat; 
    colorbar
    hold on; 
 
    [C,h] = contour(SST(:,:,1),'k-','LineWidth',1); 
    clabel(C,h,'FontSize',8);
    drawnow
    pause (0.7)
end

% plot of 1000 MC global temperature values at 10deg S vs its mean and the satellite 
m_SST123 = mean (SST123,4);
for i = 1:1000
    hold off
    plot (1:360,SST123 (100,:,1,i))
    hold on
    plot (1:360,SST(100,:,1));  ylim ([23 31]);plot (1:360,m_SST123(100,:,1))
    drawnow
    pause(0.7)
end

%% for Salinity (lat,lon,m,n_stat)
for i = 1:1000
for mm = 1:12
SSS123(:,:,mm,i) = SSS(:,:,mm) + randn(180,360,1) .* 0.47;
end
end

% pcolor pot of global salinity for all MC overlayed satellite contour of
% global dens.
for i = 1:1000
    hold off; 
    pcolor (SSS123 (:,:,1,i)); 
    shading flat; 
    colorbar
    hold on; 
    caxis ([20 40])
    [C,h] = contour(SSS(:,:,1),'k-','LineWidth',1); 
    clabel(C,h,'FontSize',8);
    drawnow
    pause (0.7)
end

% plot of 1000 MC global salinity values at 10deg S vs its mean and the satellite 
m_SSS123 = mean (SSS123,4);
for i = 1:1000
hold off
plot (1:360,SSS123 (100,:,1,i))
hold on
plot (1:360,SSS(100,:,1)); ylim ([29 37]); plot (1:360,m_SSS123(100,:,1))
drawnow
pause(0.7)
end

%% for density (lat,lon,m,n_stat)  
for i = 1:1000
for mm = 1:12
rho123(:,:,mm,i) = rho(:,:,mm); 
% + randn(180,360,1) .* 0.47;
end
end

% pcolor pot of global density for all MC overlayed satellite contour of
% global dens.
for i = 1:1000
    hold off; 
    pcolor (rho123 (:,:,1,i)); 
    shading flat; 
    colorbar
    hold on; 
    [C,h] = contour(rho(:,:,1),'k-','LineWidth',1); 
    clabel(C,h,'FontSize',8);
    drawnow
    pause (0.7)
end

% plot of 1000 MC global dens values at 10deg S vs its mean and the satellite 
m_rho123 = mean (rho123,4);
for i = 1:1000
hold off
plot (1:360,rho123 (100,:,1,i))
hold on
plot (1:360,rho(100,:,1)); ylim ([1020 1024.5]); plot (1:360,m_rho123(100,:,1))
drawnow
pause(0.7)
end
%% for flux dens space
for i = 1:1000
Frho_all1(1,:,i)=Frho_all(1,:)+randn(1,81).*0.47;
end
m_Frho_all1 = mean(Frho_all1,3);

% plot of equatorial pacific trans vs dens in TS space vs satellite (myMC)
m_Frho_all1 = mean(Frho_all1,3);
for i = 1:1000
hold off
plot (1:81,Frho_all1(1,:,i))
hold on
plot (1:81,Frho_all(1,:));ylim ([-35 0]); plot(1:81,m_Frho_all1)
drawnow
pause(0.7)
end
%% for formation dens space
for i = 1:1000
gFrho_all1(1,:,i)=gFrho_all(1,:)+randn(1,81).*0.47;
end

% plot of equatorial pacific form vs dens in TS space vs satellite (myMC)
m_gFrho_all1 = mean(gFrho_all1,3);
for i = 1:1000
hold off
plot (1:81,gFrho_all1(1,:,i))
hold on
plot (1:81,gFrho_all(1,:));ylim ([-6 8]); plot(1:81,m_gFrho_all1)
drawnow
pause(0.7)
end