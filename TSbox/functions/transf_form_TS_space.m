function [Fscatt_true,Fscatt_e,...
            gFscatt_true,gFscatt_e] = transf_form_TS_space(F,S,T,SSS,SST,n_stat,dS,dT,F_e,SSS_e,SST_e,dxx,dyy)
%=======================================================================================================================
%
% USAGE:
% transf_form_TS_space(F,S,T,SSS,SST,n_stat,dS,dT,F_e,SSS_e,SST_e,dxx,dyy)
%
% DESCRIPTION:
% Trans(formation) calculation temperature-salinity space    [ Sv ]
%
% INPUT:
%  (F,F_e)          = density flux (ref,MC)            [ kg/m^2s ]
%  S                = salinity classes                 [ PSU ] 
%  (SSS,SSS_e)      = salinity data (ref,MC)           [ PSU ]
%  T                = temperature classes              [ degC ] 
%  (SST,SST_e)      = temperature data (ref,MC)        [ degC ]
%  n_stat           = # of Monte Carlo simulations     [ number ]
%  dS               = salinity bin width               [ PSU ]
%  dT               = temperature bin width            [ degC ]
%  (dxx,dyy)        = distance (latitude,longitude     [ m ]
% 
% OUTPUT:
% (Fscatt,gFscatt)_true = ref. trans(formation) 
%               temperature-salinity space             [ Sv = 1e6 m^3s^-1 ] 
% (Fscatt,gFscatt)_e = MC trans(formation) in 
%               temperature-salinity space             [ Sv = 1e6 m^3s^-1 ]            
% AUTHOR:
%  Aqeel Piracha                                 [ apiracha@btinternet.com ]
%
% VERSION 
% 1           = First made                       [ Thursday 10th October 2019 ] 
% 2           = neatened                         [ Sunday 26th April 2020 ]
%
% REFERENCES:
% Speer and Tzipermann, 1992
%
% The software is currently in development
%
%=======================================================================================================================
    
    lat_len = size(SSS,2);
    lon_len = size(SSS,1);

    num_classes_S = round(length(S(1):dS:S(end)));
    num_classes_T = round(length(T(1):dT:T(end)));

    bin_edges_S = linspace(S(1),S(end),num_classes_S);
    bin_edges_T = linspace(T(1),T(end),num_classes_T);


    [SST_discretized,e_T] = discretize(SST,bin_edges_T);
    [SSS_discretized,e_S] = discretize(SSS,bin_edges_S);


    Fscatt_true = nan(num_classes_T,num_classes_S);
    Fscatt_e = nan(num_classes_T,num_classes_S,n_stat);
    gFscatt_e = nan(num_classes_T,num_classes_S,n_stat);


%% Reference

    f = waitbar(0,'Please wait...');        
    tic
% transformation
    for Tn = 1:num_classes_T
        bin_ind_T = find(SST_discretized == Tn);        
        bin_ind_S = SSS_discretized(bin_ind_T);
        for Sn = 1:num_classes_S
            S_class = bin_ind_S == Sn;
            S_class_ind = find(S_class == 1);
            [row,col] = ind2sub([lon_len,lat_len],S_class_ind);
            F_c = F(row,col); 
            xx_c = dxx(row,col);
            yy_c = dyy(row,col);
            F_area = F_c.*xx_c.*yy_c;
            F_area(isnan(F_area)) = 0;
            F_scatt_t = ((sum(F_area,'all')/length(row)/dS/dT)*1e-6);
            Fscatt_true(Tn,Sn) = F_scatt_t;
        end
    end
% formation
    [ss,tt] = meshgrid(S,T); % gradients TS
    [gsFscatt,gtFscatt] = grad(ss,tt,Fscatt_true);
    gFscatt = complex(dS*gsFscatt,dT*gtFscatt);
    tsrho = gsw_rho_CT(ss,tt,0); % rho
    [gsrho,gtrho] = grad(ss,tt,tsrho);
    grho = complex(gsrho,gtrho);
    gFscatt_true = -1*(real(gFscatt).*real(grho)+...
        imag(gFscatt).*imag(grho))./abs(grho);

%% Monte-Carlo (Perturbed Variables)
% transformation
    for n = 1:n_stat
        SST_discretized_e = discretize(SST_e(:,:,n),bin_edges_T);
        SSS_discretized_e = discretize(SSS_e(:,:,n),bin_edges_S);
        for Tn = 1:num_classes_T
            waitbar(n/n_stat,f,['MC = ',num2str(n),'/',num2str(n_stat),...
                ' - T = ',num2str(Tn),'/',num2str(num_classes_T),...
                ' - S = ',num2str(Sn),'/',num2str(num_classes_S)])         
            bin_ind_Te = find(SST_discretized_e == Tn);        
            bin_ind_Se = SSS_discretized_e(bin_ind_Te);
            for Sn = 1:num_classes_S
                S_classe = bin_ind_Se == Sn;
                S_class_inde = find(S_classe == 1);
                [row,col] = ind2sub([lon_len,lat_len],S_class_inde);
                F_c = F_e(row,col,n); 
                xx_c = dxx(row,col);
                yy_c = dyy(row,col);
                F_area = F_c.*xx_c.*yy_c;
                F_area(isnan(F_area)) = 0;
                F_scatt_e = ((sum(F_area,'all')/length(row)/dS/dT)*1e-6);
                Fscatt_e(Tn,Sn,n) = F_scatt_e;
            end
        end
% formation    
        [gsFscatt,gtFscatt] = grad(ss,tt,Fscatt_e(:,:,n));
        gFscatt = complex(dS*gsFscatt,dT*gtFscatt);
        gFscatt_e(:,:,n) = -1*(real(gFscatt).*real(grho)+...
            imag(gFscatt).*imag(grho))./abs(grho);
    end
    x = toc;
    msg1 = msgbox(['Time taken = ',num2str(x),' seconds.'],...
        'INFO');
    close(f)
    pause(2)
    close(msg1)
end


                