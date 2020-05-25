function [Geo_formation_all_MC_locs]=get_fig_cursor_info(fignumTS,...
    fignum,choice,ocean,Form_Data,all_TS_WM,oSSS,oSST,oxx,oyy,n_stat,...
    times,Geo_formation_all_MC_locs,Fscatt_unchanged,num,original,...
    sal,temp,tframe,prec,month,evap,time_frame,years,monthss,season,months,f,...
    ocean_num,S,T)

%% -----AUTHOR: AQEEL PIRACHA----------------------------------------------
%-------Contact: apiracha@btinternet.com-----------------------------------
%-----ADAPTED FROM WORK DONE BY: LUIGI CASTALSO----------------------------
%
%-----wm_form_TS_error----------------------------------------------------
%-----Compute water-mass formation in temperatire salinity space-----------
%
%-----Syntax---------------------------------------------------------------
%-----get_fig_cursor_info(fignumTS,...
%    fignum,choice,ocean,Form_Data,all_TS_WM,oSSS,oSST,oxx,oyy,n_stat,...
%   times,Geo_formation_all_MC_locs,Fscatt_unchanged,num,original,...
%   sal,temp,tframe,prec,month,evap,time_frame,years,monthss,season,...
%   months,f---------------------------------------------------------------
%
%-----Description----------------------------------------------------------
%-----For the primary purpose of allowing user to select a certain point--- 
%-----in TS space formation to convert to geographical co-ordinates--------
%
%-----Input arguments------------------------------------------------------
%---User does not have to deal with function directly, called by-----------
%---control_centre and all variables defined therein-----------------------

%% ------------------------------------------------------------------------
%--------------------START CODE--------------------------------------------
%--------------------------------------------------------------------------
%-----Helpfull annotation-------------------------------------------------
% % f = figure(3);
% f = fignum;
% b = uicontrol(f,'Style','text');
% b.Position = [1669,920,168,27];
% b.String = {'Please Select Peak Formation Point Visible In The Plot'};
% a = annotation('arrow',[0.913541666666666,0.880208333333333],...
%     [0.906281156530405,0.857627118644064]);
% dcm_obj = datacursormode(f);
% set(dcm_obj,'DisplayStyle','datatip','SnapToDataVertex','off','Enable','on')
% % Now, click on the line to place datatip before executing 
% % the next line of code.
% % dcmObject = datacursormode;
% pause % press Enter to acquire
% datacursormode off
% cursor = getCursorInfo(dcm_obj);
% x = cursor.Position(1);
% y = cursor.Position(2);
% %-----Converting points selected to salinity and temperature ranges--------
% Theta_S_pos1 = x - .25; 
% Theta_S_pos2 = x + .25; 
% Theta_T_pos1 = y + 1;
% Theta_T_pos2 = y - 1;
% %-----Drawing a rectangle on TS diagram showing range selection------------
% rectangle('Position',[Theta_S_pos1,Theta_T_pos2,...
%     Theta_S_pos2-Theta_S_pos1,...
%     Theta_T_pos1-Theta_T_pos2],'linewidth',1.5);
% b.delete;
% delete(a);

stripes = con_comp(Form_Data,S,T);

%-----Going to Compute geographic location of water-mass formation---------
Geo_formation_all_MC_locs = wm_form_maps_months_18deg_JFM_NEW (stripes,...
    Fscatt_unchanged,oSSS,oSST,...
    oxx,oyy,times,Geo_formation_all_MC_locs,num,3,n_stat,ocean,...
    sal,temp,tframe,prec,month,evap,time_frame,years,monthss,season,...
    months,ocean_num,S,T);
%--------------------------------------------------------------------------
%--------------------END CODE----------------------------------------------
%--------------------------------------------------------------------------

    