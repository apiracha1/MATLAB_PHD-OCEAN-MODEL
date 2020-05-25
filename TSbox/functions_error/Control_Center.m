function Control_Center
% Control_Center                             A gui for interfacing with the
%                                                               smos watermasses toolbox
%============================================================
% 
% USAGE:  
% Control_Center
%                                                   *Just call the function
%                                                   from the matlab command
%                                                   line 
%
% DESCRIPTION:
%  **As of 10/10/2019 
% Function is a gui for interfacing with the rest of the smos user toolbox
% for water mass computation. Just call the function from the command line
% and select from the dropdown menus and user functions
%
% INPUT:
%  None
% 
% OUTPUT:
%  None
% 
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1.1 (Monday 17th October 2019) *******STARTING FRESH COUNT
% NOTES on VERSION:
%                                   heat flux choice
%
% REFERENCES:
% For calculation of density flux           [ Speer and Tzipermann 1992 ]   
%
% The software is currently in development
%
%============================================================
%-----Set Path-------------------------------------------------------------
[path0] = first_path();
%-----Create Figure & set full-screen--------------------------------------
fig = figure (1);
set(fig,'units','normalized','outerposition',[0 0 1 1])
% set(gcf,'Position',[2882,12,958,984])
clf
%-----Chosen Parameter (filled with choices)-------------------------------
[parameter_evaporation, parameters_MC, parameters_datasets_SSS, parameters_datasets_SST,...
    parameters_computation, parameters_year, parameters_ocean, parameter_precipitation,...
    parameters_season, parameter_heatfluxls, parameter_radfluxls] = gui_menu_parameters();
                                                                                                                % empty parameter fields to 
%                                                                                                                 be filled by choice
%-----Introductory Text----------------------------------------------------
[textbox1, textbox2, textbox3, textbox4, textbox5,...
    textbox6, textbox7, textbox8, textbox9, textbox0, textbox01] = gui_menu_choices(fig);
%-----Create text and inputs for selection of parameters-------------------
gui_menu_selection(fig,parameter_evaporation, parameters_MC, parameters_datasets_SSS, parameters_datasets_SST,...
    parameters_computation, parameters_year, parameters_ocean, parameter_precipitation,...
    parameters_season, parameter_heatfluxls, parameter_radfluxls,textbox1, textbox2, textbox3, textbox4, textbox5,...
    textbox6, textbox7, textbox8, textbox9, textbox0, textbox01);
end
%--------------------------------------------------------------------------
%--------------------END CODE----------------------------------------------
%--------------------------------------------------------------------------
