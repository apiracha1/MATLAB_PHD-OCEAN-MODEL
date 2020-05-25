%
%
% maxspace_4by4(s1,s2,s3,s4)
% maximizes the panel of a 2by2 (in contradiction to the name! Sorry) subplot. 
% The input parameters are the handles to the individual subplots.
% Needs to be called for every subplot individually, the other three inputs
% have to be zero in the call in order to determine the correct position.
%

function maxspace_4by4(s1,s2,s3,s4)

if s1 ~= 0
    set(s1,'position',[0.1400 0.5000 0.39 0.408])
    set(s1,'xticklabel',[])
elseif s2 ~= 0
    set(s2,'position',[0.4500 0.5000 0.39 0.408])
    set(s2,'xticklabel',[]); set(s2,'yticklabel',[])
elseif s3 ~= 0
     set(s3,'position',[0.1400 0.0850 0.39 0.408])
elseif s4 ~=0
     set(s4,'position',[0.4500 0.0850 0.39 0.408])
     set(s4,'yticklabel',[])
end