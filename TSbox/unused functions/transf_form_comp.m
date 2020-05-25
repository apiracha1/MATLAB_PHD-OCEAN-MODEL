function [Fscatt,formation1,formation_error,formation_error_unchanged] = transf_form_comp(T,S,F,oSSS,oSST,month,...
    oxx,oyy,ndays,dS,dT,n,formation_error,formation_error_unchanged)
    %to compute transformation and formation
                    Fscatt = nan(length(T),length(S));
                    formation1 = nan(length(T),length(S),size(F,3));
                    for m = 1:month
                    mSSS = squeeze(oSSS(:,:,m)); mSST = squeeze(oSST(:,:,m));
                    mF = squeeze(F(:,:,m));
                        for t = 2:length(T) % SST bins
                            tind = find(mSST>T(t-1) & mSST<T(t));
                            tmSSS = mSSS(tind); tmF = mF(tind);
                            txx = oxx(tind); tyy = oyy(tind);
                            if ~isempty(tind)
                                for s = 2:length(S) % SSS bins
                                    sind = find(tmSSS>S(s-1) & tmSSS<S(s));
                                    if ~isempty(sind)
                                        stmF = tmF(sind).*txx(sind).*tyy(sind);
                                        Fscatt(t,s) = nansum(stmF)*...
                                            ndays(m)*86400;
                                    end
                                end
                            end
                        end    
    %% -----Computing water-mass formation-------------------------------------
    %-----Smoothing------------------------------------------------------------
                    Fscatt_smooth = boxfilter(Fscatt);
    %-----T/S gradient of transformation---------------------------------------
                    [ss tt] = meshgrid(S,T);
                    [gsFscatt gtFscatt] = grad(ss,tt,Fscatt_smooth);
                    gFscatt = complex(dS*gsFscatt,dT*gtFscatt);
    %-----T/S gradient of rho--------------------------------------------------
                    tsrho = gsw_rho_CT(ss,tt,0);
                    [gsrho gtrho] = grad(ss,tt,tsrho);
                    grho = complex(gsrho,gtrho);
    %-----Actual computation of formation--------------------------------------
                    formation1(:,:,m) = -1*(real(gFscatt).*real(grho)+...
                        imag(gFscatt).*imag(grho))./abs(grho);
                    end
                        %% -----Formatting results (correcting units)------------------------------                
                    formation1_unchanged = formation1;
                    formation1 = nansum(formation1,3); %---sum over time-------
                    formation1 = formation1/...
                        (86400*(ndays(month(1)))); %---------------annual average------
                    formation1 = formation1/0.1/0.5; %-----devide by binsizes--
                    formation1 = formation1*1e-6; %--------convert to sverdrup-
    %-----Creating new matrix of water-mass formation at every MC--------------
                    formation_error (n,:,:) = formation1; 
                    formation_error_unchanged (:,:,:,n) = formation1_unchanged;
end