%
% [GX GY] = GRAD(XX,YY,FIELD)
% calculates the gradients of inputfiled FIELD in X and Y direction
% input: XX,YY - are the 2D longtiude and latitude fields converted into [m]
%        FIELD - 2D input field of which the gradient should be calculated
%


function [gx, gy] = grad(xx,yy,field)

gx = nan(size(field)); 

for y = 1:size(field,1)
    gx(y,:) = gradient(squeeze(field(y,:)),squeeze(xx(y,:)));
end

[~,gy] = gradient(field,xx,yy);
    