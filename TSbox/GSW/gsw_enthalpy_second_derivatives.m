function [h_SA_SA, h_SA_CT, h_CT_CT] = gsw_enthalpy_second_derivatives(SA,CT,p)

% gsw_enthalpy_second_derivatives            second derivatives of enthalpy
% =========================================================================
%
% USAGE:
%  [h_SA_SA, h_SA_CT, h_CT_CT] = gsw_enthalpy_second_derivatives(SA,CT,p)
%
% DESCRIPTION:
%  Calculates the following three second-order derivatives of specific
%  enthalpy (h),
%   (1) h_SA_SA, second-order derivative with respect to Absolute Salinity 
%       at constant CT & p.
%   (2) h_SA_CT, second-order derivative with respect to SA & CT at 
%       constant p. 
%   (3) h_CT_CT, second-order derivative with respect to CT at constant SA 
%       and p. 
%
% INPUT:
%  SA  =  Absolute Salinity                                        [ g/kg ]
%  CT  =  Conservative Temperature (ITS-90)                       [ deg C ]
%  p   =  sea pressure                                             [ dbar ]
%         ( i.e. absolute pressure - 10.1325 dbar )
%
%  SA & CT need to have the same dimensions.
%  p may have dimensions 1x1 or Mx1 or 1xN or MxN, where SA & CT are MxN.
%
% OUTPUT:
%  h_SA_SA  =  The second derivative of specific enthalpy with respect to 
%              Absolute Salinity at constant CT & p.    [ J/(kg (g/kg)^2) ]
%  h_SA_CT  =  The second derivative of specific enthalpy with respect to 
%              SA and CT at constant p.                  [ J/(kg K(g/kg)) ]
%  h_CT_CT  =  The second derivative of specific enthalpy with respect to 
%              CT at constant SA and p.                      [ J/(kg K^2) ]
%
% AUTHOR:   
%  Trevor McDougall and Paul Barker.                   [ help@teos-10.org ]
%
% VERSION NUMBER: 3.02 (15th November, 2012)
%
% REFERENCES:
%  IOC, SCOR and IAPSO, 2010: The international thermodynamic equation of 
%   seawater - 2010: Calculation and use of thermodynamic properties.  
%   Intergovernmental Oceanographic Commission, Manuals and Guides No. 56,
%   UNESCO (English), 196 pp.  Available from http://www.TEOS-10.org.  
%   
%  McDougall T.J., P.M. Barker, R. Feistel and D.R. Jackett, 2013:  A 
%   computationally efficient 48-term expression for the density of 
%   seawater in terms of Conservative Temperature, and related properties
%   of seawater.  To be submitted to J. Atm. Ocean. Technol., xx, yyy-zzz.
%
%  This software is available from http://www.TEOS-10.org
%
%==========================================================================

%--------------------------------------------------------------------------
% Check variables and resize if necessary
%--------------------------------------------------------------------------

if ~(nargin == 3)
   error('gsw_enthalpy_second_derivatives:  Requires three inputs')
end %if

if ~(nargout == 3)
   error('gsw_enthalpy_second_derivatives:  Requires three outputs')
end %if

[ms,ns] = size(SA);
[mt,nt] = size(CT);
[mp,np] = size(p);

if (ms ~= mt | ns ~= nt )
   error('gsw_enthalpy_second_derivatives: SA and CT do not have the same dimensions')
end %if

if (mp == 1) & (np == 1)              % p scalar - fill to size of SA
    p = p*ones(size(SA));
elseif (ns == np) & (mp == 1)         % p is row vector,
    p = p(ones(1,ms), :);              % copy down each column.
elseif (ms == mp) & (np == 1)         % p is column vector,
    p = p(:,ones(1,ns));               % copy across each row.
elseif (ns == mp) & (np == 1)          % p is a transposed row vector,
    p = p.';                              % transposed then
    p = p(ones(1,ms), :);                % copy down each column.
elseif (ms == mp) & (ns == np)
    % ok
else
    error('gsw_enthalpy_second_derivatives: The dimensions of p do not agree')
end %if

if ms == 1
    SA = SA.';
    CT = CT.';
    p = p.';
    transposed = 1;
else
    transposed = 0;
end

%--------------------------------------------------------------------------
% Start of the calculation
%--------------------------------------------------------------------------

cp0 = 3991.86795711963;             % from Eqn. 3.3.3 of IOC et al. (2010).
n0 = 0; 
n1 = 1; 
n2 = 2;
pr0 = zeros(size(SA)); 

pt0 = gsw_pt_from_CT(SA,CT);
rec_abs_pt0 = 1./(273.15 + pt0);
t = gsw_pt_from_t(SA,pt0,pr0,p);
temp_ratio = (273.15 + t).*rec_abs_pt0;

rec_gTT_pt0 = 1./gsw_gibbs(n0,n2,n0,SA,pt0,pr0);
rec_gTT_t = 1./gsw_gibbs(n0,n2,n0,SA,t,p);
gST_pt0 = gsw_gibbs(n1,n1,n0,SA,pt0,pr0);
gST_t = gsw_gibbs(n1,n1,n0,SA,t,p);
gS_pt0 = gsw_gibbs(n1,n0,n0,SA,pt0,pr0);

% h_CT_CT is naturally well-behaved as SA approaches zero. 
h_CT_CT = cp0.*cp0.* ...
    (temp_ratio.*rec_gTT_pt0 - rec_gTT_t).*(rec_abs_pt0.*rec_abs_pt0);

part = (temp_ratio.*gST_pt0.*rec_gTT_pt0 - gST_t.*rec_gTT_t).*rec_abs_pt0;
factor = gS_pt0./cp0;

% h_SA_SA has a singularity at SA = 0, and blows up as SA approaches zero.  
h_SA_SA = gsw_gibbs(n2,n0,n0,SA,t,p) ...
    - temp_ratio.*gsw_gibbs(n2,n0,n0,SA,pt0,pr0)  ...
    + temp_ratio.*gST_pt0.*gST_pt0.*rec_gTT_pt0  ...
    - gST_t.*gST_t.*rec_gTT_t  ...
    - 2.0.*gS_pt0.*part + (factor.*factor).*h_CT_CT;

% h_SA_CT should not blow up as SA approaches zero.  The following lines
% of code ensure that the h_SA_CT output of this function does not blow
% up in this limit.  That is, when SA < 1e-100 g/kg, we force the h_SA_CT 
% output to be the same as if SA = 1e-100 g/kg.  
if any(SA < 1e-100)
    SA(SA < 1e-100) = 1e-100;
    rec_gTT_pt0 = 1./gsw_gibbs(n0,n2,n0,SA,pt0,pr0);
    rec_gTT_t = 1./gsw_gibbs(n0,n2,n0,SA,t,p);
    gST_pt0 = gsw_gibbs(n1,n1,n0,SA,pt0,pr0);
    gST_t = gsw_gibbs(n1,n1,n0,SA,t,p);
    gS_pt0 = gsw_gibbs(n1,n0,n0,SA,pt0,pr0);
    part = (temp_ratio.*gST_pt0.*rec_gTT_pt0 - gST_t.*rec_gTT_t).*rec_abs_pt0;
    factor = gS_pt0./cp0;
end

h_SA_CT  = cp0.*part - factor.*h_CT_CT;

if transposed
    h_SA_SA = h_SA_SA.';
    h_SA_CT = h_SA_CT.';
    h_CT_CT = h_CT_CT.';
end

end
