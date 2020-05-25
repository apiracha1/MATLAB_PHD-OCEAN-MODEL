function form_rho_plot(gFrho_all,sigma,ocean,tframe,sal,month)
% form_rho_plot                             plots formation versus density          [ Sv ]
%============================================================
% 
% USAGE:  
% form_rho_plot(gFrho_all,sigma,ocean,tframe,sal,month)
%                                                   *All variables set
%                                                   through Control_Center
% 
%  Note that form_rho_plot has all variables pre set through
%  choices in Control_Center.
%
% DESCRIPTION:
%  **As of 19/11/2019 
% Function creates full plot with axis titles and correct limits of
% water mass formation and density
%
% INPUT:
%  gFrho_all = formation in density space across all monte-carlo simulations      [ 3-D matrix ]
% sigma = density bins      [ vector ]
% ocean = name of basin     [ string ]
% tframe = selected year           [ string ] (FORMAT: jan##dec##, ## = 12 for 2012 e.t.c.)
% sal = salinity dataset name   [ string ]
% month = month chosen   [ number ]
% 
% OUTPUT:
% None
% 
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1 (Tuesday 19th November 2019) *******STARTING FRESH COUNT
% NOTES on VERSION:
% None
%
% REFERENCES:
%
% The software is currently in development
%
%============================================================
gFrho_all = permute(gFrho_all,[2 3 1]);
figure(9)
plot(sigma,nanmean(gFrho_all,3),'k-') 
errorbar(sigma,nanmean(gFrho_all,3),nanstd(gFrho_all,3))
title([sal,' month = ',num2str(month),...
        ' - 20',tframe(end-1:end),' - ',ocean])
xlabel('Density [kgm^-^3]')
ylabel('Formation [Sv]')
end