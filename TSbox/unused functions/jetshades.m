%
% CM = JETSHADES(C,GY)
% create a colormap with four colours going with increasing intensity for
% each colour segment
% C can be any number between 1 and 0, the smaller C, the darker first
% shade of the color. With C=1, the first shade for every clor is always
% white, whit C=0, all shades will be identical.
% GY can be either 'yellow' or 'green' and determines whether the 3rd color
% is yellow or green
%

function [cm] = jetshades(c,gy)

cm =nan(44,3);
% blue
cm(1:11,1) = c:-c/10:0; cm(1:11,2) =  c:-c/10:0; cm(1:11,3) = ones(11,1);
% cyan
cm(12:22,1) = c:-c/10:0; cm(12:22,2) = ones(11,1); cm(12:22,3) = ones(11,1);
% yellow or green
if strcmp(gy,'yellow')
    cm(23:33,1) = ones(11,1); cm(23:33,2) = ones(11,1); cm(23:33,3) = c:-c/10:0;
elseif strcmp(gy,'green')
    cm(23:33,1) = c:-c/10:0; cm(23:33,2) = c:-(c-0.5)/10:0.5; cm(23:33,3) = c:-(c-0.4)/10:0.4;
end
% red
cm(34:44,1) = ones(11,1); cm(34:44,2) = c:-c/10:0; cm(34:44,3) = c:-c/10:0;

