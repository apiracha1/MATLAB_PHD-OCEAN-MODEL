function [Frho_true,Frho_e,...
    gFrho_true,gFrho_e] = transf_form_rho_space(F,sigma,rho,n_stat,dS,F_e,rho_e,dxx,dyy)
%=======================================================================================================================
%
% USAGE:
% transf_form_rho_space(F,sigma,rho,n_stat,dS,F_e,rho_e,dxx,dyy)
%
% DESCRIPTION:
% Trans(formation) calculation density space    [ Sv ]
%
% INPUT:
%  (F,F_e)          = density flux (ref,MC)            [ kg/m^2s ]
%  sigma            = denity classes                   [ kg/m^3 ] 
%  (rho,rho_e)      = density data (ref,MC)            [ kg/m^3 ]
%  n_stat           = # of Monte Carlo simulations     [ number ]
%  dS               = density bin width                [ kg/m^3 ]
%  (dxx,dyy)        = distance (latitude,longitude     [ m ]
% 
% OUTPUT:
% (Frho,gFrho)_true = ref. trans(formation) in density             [ Sv = 1e6 m^3s^-1 ] 
% (Frho,gFrho)_e = MC trans(formation) in density space            [ Sv = 1e6 m^3s^-1 ]            
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
    lat_len = size(rho,2);
    lon_len = size(rho,1);

    num_classes = round(length(sigma(1):dS:sigma(end)));
    bin_edges = linspace(sigma(1),sigma(end),num_classes);

    [rho_discretized,e] = discretize(rho,bin_edges);

    Frho_true = nan(1,num_classes);
    Frho_e = nan(1,num_classes,n_stat);
    gFrho_e = nan(1,num_classes,n_stat);
%% Reference
    f = waitbar(0,'Please wait...');        
    tic
% transformation
    for sigma_n = 1:num_classes
        bin_ind = find(rho_discretized == sigma_n);
        [row,col] = ind2sub([lon_len,lat_len],bin_ind);
        F_c = F(row,col); 
        xx_c = dxx(row,col);
        yy_c = dyy(row,col);
        F_area = F_c.*xx_c.*yy_c;
        F_area(isnan(F_area)) = 0;
        F_rho_t = ((sum(F_area,'all')/length(row)/dS)*1e-6);
        Frho_true(1,sigma_n) = F_rho_t;
    end
% formation
    gF_rho_t = gradient(Frho_true,dS);
    gFrho_true = gF_rho_t*0.1;
    
%% Monte-carlo
% transformation
    for n = 1:n_stat
        waitbar(n/n_stat,f,['MC = ',num2str(n),'/',num2str(n_stat),...
            ' - \rho = ',num2str(sigma_n),'/',num2str(num_classes)])         
        var_discretized_e = discretize(rho_e(:,:,n),bin_edges);
        F_en = F_e(:,:,n);
            for sigma_n = 1:num_classes
                bin_ind = find(var_discretized_e == sigma_n);
                [row,col] = ind2sub([lon_len,lat_len],bin_ind);
                F_ce = F_en(row,col); 
                xx_ce = dxx(row,col);
                yy_ce = dyy(row,col);
                F_areae = F_ce.*xx_ce.*yy_ce;
                F_areae(isnan(F_areae)) = 0;
                F_rho_e = ((sum(F_areae,'all')/length(row)/dS)*1e-6);
                Frho_e(1,sigma_n,n) = F_rho_e;
            end
% formation
        gF_rho_e = gradient(Frho_e(:,:,n),dS);
        gFrho_e(1,:,n) = gF_rho_e*0.1;
    end
    x = toc;
    msg1 = msgbox(['Time taken = ',num2str(x),' seconds.'],...
        'INFO');
    close(f)
    pause(2)
    close(msg1)
end

        
        
       