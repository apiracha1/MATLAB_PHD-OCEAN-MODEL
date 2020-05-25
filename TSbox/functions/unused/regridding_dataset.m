function dataset_new_res = regridding_dataset(dataset,desired_res,method)
% regridding_dataset                             Regrids given dataset to desired resolution         
%============================================================
% 
% USAGE:  
% regridding_dataset(dataset,desired_res,method)
% 
% DESCRIPTION:
%  **As of 10/10/2019 
% Function uses set method to interpolate dataset to desired resolution
%
% INPUT:
% dataset = dataset user wants regridding        [ 2-D matrix ]
% desired_res = desired resolution for the new dataset      [ number ] 
% method = method of interpolation desired      [ string ]
% 
% OUTPUT:
%  dataset_new_res  =  new dataset with in desired resolution [ 2-D matrix ]
%
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1.1 (Monday 4th November 2019) *******STARTING FRESH COUNT
% NOTES on VERSION:
% None
%
% REFERENCES: 
% None
% 
% The software is currently in development
%
%============================================================
[x_dim,y_dim] = size(dataset);
points_desired_x = 360/desired_res;
points_desired_y = 180/desired_res;
inc_x = x_dim/points_desired_x;
inc_y = y_dim/points_desired_y;
%original dataset 
V=dataset;
[x,y]=ndgrid(1:x_dim,1:y_dim);
%make interpolant from original data
F = griddedInterpolant(x,y,V);
%desired resolution
[xi,yi]=ndgrid(1:inc_x:x_dim,1:inc_y:y_dim);
dataset_new_res = F(xi,yi);
end