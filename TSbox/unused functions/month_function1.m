function Fpeak_m = month_function1(month,oSST,oSSS,F,S,T,oxx,oyy,~,dT,dS,thetaS,thetaT,formation1,n_stat,sal_Data,temp_Data,edgee,edgeee)


%%------------------------Start of Header----------------------------------
%
% ROUTINE                    month_function1
% AUTHOR                     Aqeel Piracha
% MAIL                       piracha.aqeel@gmail.com
% DATE                       march 2018
% VERSION                    1.0 given the boundaries of the edge detection finds all temp and salinity
%                            values and there corresponding geo location within the poly gon (boudary
%                            of formation reagion). 
%                            1.1, 4 Apr 2018 finds geolocation for form values within
%                            polygon. however, if bounding rectangle is
%                            chosen finds the geo location of form values
%                            within the bounding box instead
%                            
% PURPOSE                    to convert to geograhical space all points 
%                            which lie in polygon or bounding rectangle - 
%                            Depending on user defined choice.
%%-----------------------------End of Header-------------------------------




ndays = [31 28 31 30 31 30 31 31 30 31 30 31];

mx=0;
Fpeak_m=zeros(length(month),size(oSSS,1),size(oSSS,2));
for m = month%1:size(F,3)
%     Fscatt = nan(length(T),length(S));
%     mSSS = squeeze(oSSS(:,:,m)); mSST = squeeze(oSST(:,:,m));mF = squeeze(F(:,:,m));
%     for t = 2:length(T)
%         tind = find(mSST>T(t-1) & mSST<T(t));
%         tmSSS = mSSS(tind); tmF = mF(tind);
%         txx = oxx(tind); tyy = oyy(tind);
%         if ~isempty(tind)
%             for s = 2:length(S)
%                 sind = find(tmSSS>S(s-1) & tmSSS<S(s));
%                 if ~isempty(sind)
%                     stmF = tmF(sind).*txx(sind).*tyy(sind);
% %                     stmF=nanmean(stmF);
%                    Fscatt(t,s) = nansum(stmF).*ndays(m).*86400; %original
% %                   Fscatt(t,s) = nanmean(stmF)*ndays(m)*86400; %modified
%                     %Fscatt(t,s,m) = length(sind);
%                 end
%             end
%         end
%     end
%     
%     Fscatt = Fscatt/(ndays(m)*86400); %monthly average
%     Fscatt = Fscatt/dT/dS; %devide by bin sizes
%     
%     Fscatt = Fscatt*1e-6; % sverdrup
%     % end
%     % close(h)
%     %% 5. water mass formation
%     
%     % a) smoothing
% % if n_stat == 1
%      Fscatt_smooth = boxfilter(Fscatt); 
% % elseif n_stat > 1
% %           Fscatt_smooth = Fscatt; % without smoothing
% % 
% % end
% % windowwidth = 3;
% % kernel = ones(windowwidth,1)/windowwidth;
% % Fscatt_smooth = filter(kernel,1,Fscatt);
%     % b) T/S gradient of transformation
%     [ss, tt] = meshgrid(S,T);
%     [gsFscatt, gtFscatt] = grad(ss,tt,Fscatt_smooth);
%     gFscatt = complex(dS*gsFscatt,dT*gtFscatt);
%     
%     % c) T/S gradient of rho
%     tsrho = gsw_rho_CT(ss,tt,0);
%     [gsrho, gtrho] = grad(ss,tt,tsrho);
%     grho = complex(gsrho,gtrho);
%     
%     % d) formation
%     formation1 = -1*(real(gFscatt).*real(grho)+imag(gFscatt).*imag(grho))...
%         ./abs(grho);
%     
   
    
    %% location of peaks
    Fpeak = zeros(size(oSSS,1),size(oSSS,2)); Fpeak(isnan(squeeze(oSSS(:,:,m)))) = nan;
if isempty(edgee) 
    for j = 1:size(oSST,1)
        for i = 1:size(oSST,2)
            % find geographical points which have SST and SSS values within
            % the peak range
            if oSSS(j,i,m) > thetaS(1) && oSSS(j,i,m) < thetaS(2)
                if oSST(j,i,m) > thetaT(1) && oSST(j,i,m) < thetaT(2)
                    % assign the formation value to the geographical point
                    % NOTE: accounting for the grid cell araeas would have to
                    % happen here
                    for t = 2:length(T)
                        if oSST(j,i,m) > T(t-1) && oSST(j,i,m) < T(t)
                            for s = 2:length(S)
                                if oSSS(j,i,m) > S(s-1) && oSSS(j,i,m) < S(s)
                                    if formation1(t,s) > 0.1
                                        Fpeak(j,i) = formation1(t,s);
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
else
%given the boundaries of the edge detection finds all temp and salinity
%values and there corresponding geo location within the poly gon (boudary
%of formation reagion) 
    for j = 1:size(oSST,1)
        for i = 1:size(oSST,2)
             if inpolygon(oSSS(j,i,m),oSST(j,i,m),sal_Data(edgee),temp_Data(edgeee))
%                             assign the formation value to the geographical point
%                             NOTE: accounting for the grid cell araeas would have to

                for t = 2:length(T)
                    if oSST(j,i,m) > T(t-1) && oSST(j,i,m) < T(t)
                        for s = 2:length(S)
                            if oSSS(j,i,m) > S(s-1) && oSSS(j,i,m) < S(s)
                                if formation1(t,s) > 0.1
                                    Fpeak(j,i) = formation1(t,s);
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
    %% 4. Water mass formation maps
    % save monthly results
    mx=mx+1;Fpeak_m(mx,1:j,1:i)=Fpeak(1:j,1:i);
    
end
end
