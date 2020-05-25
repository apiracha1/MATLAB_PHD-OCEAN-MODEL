function Fpeak_m = form_dens_geo(orho,~,sigma0,F,oxx,oyy,ds,ndays,rho1,rho2)

% m = 1;
mx = 0;
month = 1:12;
sss = 1;
% North atlantic (18deg) peak dens (worthington (1959)
% sigma1 = 1026;
% sigma2 = 1026;
% for m = month
            
gFrho_all = nan(3,length(sigma0));
Fpeak_m=zeros(length(month),size(orho,1),size(orho,2));
        % integrate F over bins of sigma0
for m = 1:size(F,3)
            Frho = nan(length(sigma0),size(F,3));
            mrho = squeeze(orho(:,:,m));mF = squeeze(F(:,:,m));
            for t = 2:length(sigma0)
                tind = find(mrho>sigma0(t-1) & mrho<sigma0(t));
                tmF = mF(tind);
                txx = oxx(tind); tyy = oyy(tind);
                if ~isempty(tind)
                    stmF = tmF.*txx.*tyy;
                    Frho(t,m) = nansum(stmF)*ndays(m)*86400;
                end
            end
     
%         Frho = nansum(Frho,2); % sum over time

%% defining a single month
%         Frho = Frho(:,1);
%         Frho = nansum(Frho,2);
%%        
        
        Frho = Frho/(365*86400); %annual average        
% Frho = Frho/(ndays(m)*86400); %annual average
        Frho = Frho/ds; %normalize by density bin size
        Frho = Frho*1e-6; % convert to sverdrup

               
        %% 5. formation: derivative by density
    %smooth before
% if n_stat == 1  
    Frho_smooth = Frho(:,m);
        Frho_smooth1 = Frho(:,m);
    for s = 2:length(Frho)-1
        Frho_smooth(s) = nanmean(Frho_smooth1(s-1:s+1));
    end
% elseif n_stat > 1
%      Frho_smooth = Frho;
% end
    % gradient
    gF = gradient(Frho_smooth,ds);
    gFrho_all(sss,:) = gF*0.1;

    

Fpeak = zeros(size(orho,1),size(orho,2)); Fpeak(isnan(squeeze(orho(:,:,m)))) = nan;

for j = 1:size(orho,1)
        for i = 1:size(orho,2)
            % find geographical points which have SST and SSS values within
            % the peak range
            if orho(j,i,m) > rho1 && orho(j,i,m) < rho2
                    % assign the formation value to the geographical point
                    % NOTE: accounting for the grid cell araeas would have to
                    % happen here
                    
                            for s = 2:length(sigma0)
                                if orho(j,i,m) > sigma0(s-1) && orho(j,i,m) < sigma0(s)
                                    Fpeak(j,i) = gFrho_all(1,s);
                                end
                            end
             end
        end
end
        
  

    %% 4. Water mass formation maps
    % save monthly results
     Fpeak_m(m,1:j,1:i)=Fpeak(1:j,1:i);
end