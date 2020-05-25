function [SSS_S,SST_S,H_S,W_S] = monte_carlo_sim(n_stat,...
    SSS,SST,H,W,month,SSS_unc,SST_unc,H_unc,W_unc,randnumgen,seed)
% monte_carlo_sim                             performs a monte carlo
%                                                   simulation on the given variables
%============================================================
% 
% USAGE:  
%monte_carlo_sim(n_stat,...
%     SSS,SST,H,W,month)
%                                                   *All variables set
%                                                   through Control_Center
% 
%  Note that monte_carlo_sim has all variables pre set through
%  choices in Control_Center.
%
% DESCRIPTION:
%  **As of 10/01/2020 
% Function performs a monte-carlo simulation on the variables given. It
% returns a 4-D array: 1-dim = lat, 2-dim = lon, 3-dim = month chosen,
% 4-dim num. of statistically random pounts chosen.
%
% INPUT:
%  n_stat  =  Statistically random point for monte carlo                [ number ]
%  [SSS,SST] =  salinity and temperature dataset          [ matrix 3-d ] 
%  [H,W]   =  heat flux and freshwater flux dataset           [ matrix 3-d ]
%  month = month selected          [ num ] (FORMAT: jan##dec##, ## = 12 for 2012 e.t.c.)
% 
% OUTPUT:
% [SSS_error_test,SST_error_test] = salinity and temperature dataset after sim         [ matrix 4-d ] 
% [H_error_test,W_error_test] = heat flux and freshwater flux dataset after sim          [ matrix 4-d ]
% 
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1 (Friday 10th January 2020) *******STARTING FRESH COUNT
% NOTES on VERSION:
% None
%
% REFERENCES:
% None 
%
% The software is currently in development
%
%============================================================
tic
aa = size(SSS,1);
bb = size(SSS,2);
rng(seed,randnumgen)

SSS_S = nan(size(SSS,1),size(SSS,2),n_stat);
SST_S = nan(size(SSS,1),size(SSS,2),n_stat);
H_S = nan(size(SSS,1),size(SSS,2),n_stat);
W_S = nan(size(SSS,1),size(SSS,2),n_stat);


SSS_sigma = SSS_unc;
SST_sigma = SST_unc;

for n = 1:n_stat
    SSS_S(:,:,n) = normrnd(SSS,SSS_sigma);
    SST_S(:,:,n) = normrnd(SST,SST_sigma);
%     H_S(:,:,n) = normrnd(H,H_unc);
%     W_S(:,:,n) = normrnd(W,W_unc);
end


x = toc;
msg1 = msgbox([num2str(n_stat),' simulations took ',num2str(x),' seconds to run.'],'INFO');
pause(4)
close(msg1)

end