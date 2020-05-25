function internal_energy = gsw_internal_energy(SA,CT,p)

% gsw_internal_energy                   specific interal energy of seawater
%                                                        (48-term equation)
%==========================================================================
%
% USAGE:
%  internal_energy = gsw_internal_energy(SA,CT,p)
%
% DESCRIPTION:
%  Calculates specific internal energy of seawater using the 
%  computationally-efficient 48-term expression for density in terms of SA,
%  CT and p (McDougall et al., 2013).
%
%  Note that the 48-term equation has been fitted in a restricted range of 
%  parameter space, and is most accurate inside the "oceanographic funnel" 
%  described in McDougall et al. (2013).  The GSW library function 
%  "gsw_infunnel(SA,CT,p)" is avaialble to be used if one wants to test if 
%  some of one's data lies outside this "funnel".  
%
% INPUT:
%  SA  =  Absolute Salinity                                        [ g/kg ]
%  CT  =  Conservative Temperature                                [ deg C ]
%  p   =  sea pressure                                             [ dbar ]
%         ( i.e. absolute pressure - 10.1325 dbar ) 
%
%  SA & CT need to have the same dimensions.
%  p may have dimensions 1x1 or Mx1 or 1xN or MxN, where SA & CT are MxN.
%
% OUTPUT:
%  internal_energy  =  specific internal energy                    [ J/kg ]
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
%   UNESCO (English), 196 pp.  Available from http://www.TEOS-10.org
%
%  McDougall T.J., P.M. Barker, R. Feistel and D.R. Jackett, 2013:  A 
%   computationally efficient 48-term expression for the density of 
%   seawater in terms of Conservative Temperature, and related properties
%   of seawater.  To be submitted to J. Atm. Ocean. Technol., xx, yyy-zzz.
%
%  The software is available from http://www.TEOS-10.org
%
%==========================================================================

%--------------------------------------------------------------------------
% Check variables and resize if necessary
%--------------------------------------------------------------------------

if ~(nargin == 3)
    error('gsw_internal_energy: requires three inputs')
end

[ms,ns] = size(SA);
[mt,nt] = size(CT); 
[mp,np] = size(p);

if (mt ~= ms | nt ~= ns)
    error('gsw_internal_energy: SA and CT must have same dimensions')
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
    error('gsw_internal_energy: Inputs array dimensions arguments do not agree')
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

% This line ensures that SA is non-negative.
SA(SA < 0) = 0;

P0 = 101325;               %  Pressure (in Pa) of one standard atmosphere
db2Pa = 1e4;               %  dbar to Pa conversion factor 

enthalpy = gsw_enthalpy(SA,CT,p);
internal_energy = enthalpy - (P0 + db2Pa*p).*gsw_specvol(SA,CT,p);

%--------------------------------------------------------------------------
% This function calculates enthalpy using the computationally-efficient
% 48-term expression for density in terms of SA, CT and p. If one wanted to
% compute enthalpy from SA, CT, and p with the full TEOS-10 Gibbs function,  
% the following line of code will enable this.
%
%    internal_energy = gsw_internal_energy_CT_exact(SA,CT,p);
%
%-----------------This is the end of the alternative code------------------

if transposed
    internal_energy = internal_energy.';
end

end
