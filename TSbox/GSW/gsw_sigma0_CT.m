function sigma0_CT = gsw_sigma0_CT(SA,CT)

% gsw_sigma0_CT                    potential density anomaly with reference
%                                 sea pressure of 0 dbar (48-term equation)
%==========================================================================
% 
% USAGE:  
%  sigma0_CT = gsw_sigma0_CT(SA,CT), or equivalently
%     sigma0 = gsw_sigma0(SA,CT)
% 
%  Note that gsw_sigma0(SA,CT) is identical to gsw_sigma0_CT(SA,CT).  
%  The extra "_CT" emphasises that the input temperature is Conservative 
%  Temperature, but the extra "_CT" part of the function name is not
%  needed. 
%
% DESCRIPTION:
%  Calculates potential density anomaly with reference pressure of 0 dbar,
%  this being this particular potential density minus 1000 kg/m^3.  This
%  function has inputs of Absolute Salinity and Conservative Temperature.
%  This function uses the computationally-efficient 48-term expression for 
%  density in terms of SA, CT and p (McDougall et al., 2013).
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
%
%  SA & CT need to have the same dimensions.
%
% OUTPUT:
%  sigma0_CT  =  potential density anomaly with                  [ kg/m^3 ]
%                respect to a reference pressure of 0 dbar,   
%                that is, this potential density - 1000 kg/m^3.
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
%    See Eqn. (A.30.1) of this TEOS-10 Manual. 
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

if ~(nargin == 2)
   error('gsw_sigma0_CT:  Requires two inputs')
end %if

[ms,ns] = size(SA);
[mt,nt] = size(CT);

if (mt ~= ms | nt ~= ns)
    error('gsw_sigma0_CT: SA and CT must have same dimensions')
end

if ms == 1
    SA = SA.';
    CT = CT.';
    transposed = 1;
else
    transposed = 0;
end

%--------------------------------------------------------------------------
% Start of the calculation
%--------------------------------------------------------------------------

sigma0_CT = gsw_sigma0(SA,CT);

if transposed
    sigma0_CT = sigma0_CT.';
end

% The output, being potential density anomaly, has units of kg/m^3 and is 
% potential density with 1000 kg/m^3 subtracted from it. 

end
