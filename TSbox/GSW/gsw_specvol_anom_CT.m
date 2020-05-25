function specvol_anom_CT = gsw_specvol_anom_CT(SA,CT,p)

% gsw_specvol_anom_CT            specific volume anomaly (48-term equation)
%==========================================================================
% 
% USAGE:  
%  specvol_anom_CT = gsw_specvol_anom_CT(SA,CT,p), or equivalently
%     specvol_anom = gsw_specvol_anom(SA,CT,p)
% 
%  Note that gsw_specvol_anom(SA,CT,p) is identical to 
%  gsw_specvol_anom_CT(SA,CT,p).  The extra "_CT" emphasises that the input
%  temperature is Conservative Temperature, but the extra "_CT" part of the
%  function name is not needed. 
%
% DESCRIPTION:
%  Calculates specific volume anomaly from Absolute Salinity, Conservative 
%  Temperature and pressure. It uses the computationally-efficient 48-term 
%  expression for density as a function of SA, CT and p (McDougall et al.,
%  2013). The reference value of Absolute Salinity is SSO and the reference
%  value of Conservative Temperature is equal to 0 degress C. 
%
%  Note that the 48-term equation has been fitted in a restricted range of 
%  parameter space, and is most accurate inside the "oceanographic funnel" 
%  described in McDougall et al. (2013).  The GSW library function 
%  "gsw_infunnel(SA,CT,p)" is avaialble to be used if one wants to test if 
%  some of one's data lies outside this "funnel".  
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
%  specvol_anom_CT  =  specific volume anomaly                   [ m^3/kg ]
%
% AUTHOR: 
%  Paul Barker and Trevor McDougall                    [ help@teos-10.org ]
%
% VERSION NUMBER: 3.02 (16th November, 2012)
%
% REFERENCES:
%  IOC, SCOR and IAPSO, 2010: The international thermodynamic equation of 
%   seawater - 2010: Calculation and use of thermodynamic properties.  
%   Intergovernmental Oceanographic Commission, Manuals and Guides No. 56,
%   UNESCO (English), 196 pp.  Available from http://www.TEOS-10.org
%    See Eqn. (3.7.3) of this TEOS-10 Manual. 
%
%  McDougall T.J., P.M. Barker, R. Feistel and D.R. Jackett, 2013:  A 
%   computationally efficient 48-term expression for the density of 
%   seawater in terms of Conservative Temperature, and related properties
%   of seawater.  To be submitted to J. Atm. Ocean. Technol., xx, yyy-zzz.
%
% The software is available from http://www.TEOS-10.org
%
%==========================================================================

%--------------------------------------------------------------------------
% Check variables and resize if necessary
%--------------------------------------------------------------------------

if ~(nargin == 3)
   error('gsw_specvol_anom_CT: Requires three inputs')
end %if

[ms,ns] = size(SA);
[mt,nt] = size(CT);
[mp,np] = size(p);

if (mt ~= ms | nt ~= ns)
    error('gsw_specvol_anom_CT: SA and CT must have same dimensions')
end

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
    error('gsw_specvol_anom_CT: Inputs array dimensions arguments do not agree')
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

specvol_anom_CT = gsw_specvol_anom(SA,CT,p);

if transposed
    specvol_anom_CT = specvol_anom_CT.';
end

end
