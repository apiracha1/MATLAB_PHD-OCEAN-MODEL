function draw_rectangle_std(Theta_S_pos1, Theta_T_pos1, Theta_S_pos2, Theta_T_pos2, fignum)
% %%------------------------Start of Header--------------------------------
%
% ROUTINE                    conv_to_cmap
% AUTHOR                     Aqeel Piracha
% MAIL                       apiracha@btinternet.com
% DATE                       November 15th 2017
% VERSION                    1.0
% PURPOSE                    Draws rectangle on STD of watermass formation
%                            in TS space corresponding to peak higlighted 
%                            in the mean watermass
%                            formation in TS space.
%
%
% INPUT
% fignum      -   figure number 
% Theta_S_pos1 - salinity position of upper left corner of defined
%                rectangle surrounding area of peak water formation
% Theta_S_pos2 - salinity position of lower right corner of defined
%                rectangle surrounding area of peak water formation
% Theta_T_pos1 - temperature position of upper left corner of defined
%                rectangle surrounding area of peak water formation
% Theta_T_pos2 - temperature position of lower right corner of defined
%                rectangle surrounding area of peak water formation
% %%------------------------End of Header----------------------------------

figure (fignum)
            rectangle('Position',[ Theta_S_pos1 Theta_T_pos2   Theta_S_pos2-Theta_S_pos1 Theta_T_pos1-Theta_T_pos2],'linewidth',1.5)

end
 