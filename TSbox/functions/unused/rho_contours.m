% 
% RHO_CONTOURS(T,S,[FS]) can be used to insert density conours into a TS
% diagram. The density is calculated using the Gibbs - Sea Water equation
% of state TEOS10 (McDougall and Barker, 2011).
%
% the plot to which the contorus are to be added needs to exist already,
% the 'hold on' command needs to be active!
%
% INPUT: T - range of temperature (conservative) 1xM
%        S - range of salinity (absoulte) 1xN
%       [FS] - fontsize of contour labelling, optional. default is 15 pt
%
%

function rho_contours(t,s,varargin)

[s_abs, t_cons] = meshgrid(s,t);

% cd D:\routines\smos_box\TSbox\GSW
rho_surf = gsw_rho_CT(s_abs,t_cons,0);
sigma_surf = rho_surf - 1000;

if isempty(varargin)
    [c,h]=contour(s,t,sigma_surf,'k'); clabel(c,h,12:4:30,'labelspacing',288,'fontsize',15);
else
    fs = varargin{:};
    [c,h]=contour(s,t,sigma_surf,'k'); clabel(c,h,12:4:30,'labelspacing',140,'fontsize',fs);
end
% cd D:\routines\smos_box\TSbox\functions