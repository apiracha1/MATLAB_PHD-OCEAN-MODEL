function [textbox1, textbox2, textbox3, textbox4, textbox5,...
    textbox6, textbox7, textbox8, textbox9, textbox0, textbox01] = gui_menu_choices(fig)
% gui_menu_choices                             textboxes showing choices made 
%============================================================
% 
% USAGE:  
% gui_menu_choices()
%                                                   *called from
%                                                   Control_center.m
%                                                   without input arguments
%
% DESCRIPTION:
%  **As of 04/11/2019 
% Function draws textboxes to gui with user selected choices visualised.  
%
% INPUT:
%  fig = figure to draw to          [ figure ]
% 
% OUTPUT:
% textbox1 = text box holding choice for computation to be run      [ textbox ]
% textbox2 = text box holding choice for # of MC simulations to be run      [ textbox ]
% [textbox3, textbox4] = text box holding choice for year and season     [ textbox ]
% [textbox5, textbox6 ] = text box holding choice for SSS and SST dataset names      [ textbox ]
% textbox7  = text box holding choice for basin     [ textbox ]
% [textbox8, textbox9] = text box holding choice for Precip. and Evap. dataset names     [ textbox ]
% [textbox0, textbox01] = text box holding choice for heat flux (turb.) and heat flux (rad.) 
%                                                                        dataset names             [ textbox ]
% 
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1.1 (Monday 4th November 2019) *******STARTING FRESH COUNT
% NOTES on VERSION:
%
% REFERENCES:
% None
% 
% The software is currently in development
%
%============================================================

%% TITLE
textbox = uicontrol(fig,'Style','text','FontSize',14,'Units','normalized');
textbox.Position = [0.3286 0.5541 0.2917 0.0556];
textbox.String = {'User defined parameters'};
%% SELECTED COMPUTATION
textbox = uicontrol(fig,'Style','text','Units','normalized');
textbox.Position = [0.0422 0.4976 0.0875 0.0488];
textbox.String = {'User selected computation:'};
% choice 
textbox1 = uicontrol(fig,'Style','text','ForegroundColor','r','Units','normalized');
textbox1.Position = [0.1599 0.5112 0.0620 0.0332];
textbox1.String = {'Please select an option'};

%% MC simulation number
textbox = uicontrol(fig,'Style','text','Units','normalized');
textbox.Position = [0.3167 0.5161 0.0875 0.0263];
textbox.String = {'User selected MC No.:'};
% choice
textbox2 = uicontrol(fig,'Style','text','ForegroundColor','r','Units','normalized');
textbox2.Position = [0.4594 0.5112 0.0620 0.0332];
textbox2.String = {'Please select an option'};

%% Year and Season 
textbox = uicontrol(fig,'Style','text','Units','normalized');
textbox.Position = [0.0417 0.3532 0.0875 0.0488];
textbox.String = {'User selected Year:','and season'};
textbox = uicontrol(fig,'Style','text','Units','normalized');
textbox.Position = [0.0979 0.2956 0.0875 0.0263];
textbox.String = {'and'};
%choice year
textbox3 = uicontrol(fig,'Style','text','ForegroundColor','r','Units','normalized');
textbox3.Position = [0.1589 0.3424 0.0620 0.0615];
textbox3.String = {'Please select an option'};
%choice Season
textbox4 = uicontrol(fig,'Style','text','ForegroundColor','r','Units','normalized');
textbox4.Position = [0.1568 0.2907 0.0620 0.0332];
textbox4.String = {'Please select an option'};

%% SSS dataset name 
textbox = uicontrol(fig,'Style','text','Units','normalized');
textbox.Position = [0.6401 0.4995 0.0875 0.0439];
textbox.String = {'User selected SSS:','dataset'};
% choice
textbox5 = uicontrol(fig,'Style','text','ForegroundColor','r','Units','normalized');
textbox5.Position = [0.7604 0.5102 0.0620 0.0332];
textbox5.String = {'Please select an option'};

%% SST dataset name 
textbox = uicontrol(fig,'Style','text','Units','normalized');
textbox.Position = [0.3135 0.3561 0.0875 0.0449];
textbox.String = {'User selected SST:','dataset'};
% choice
textbox6 = uicontrol(fig,'Style','text','ForegroundColor','r','Units','normalized');
textbox6.Position = [0.4594 0.3717 0.0620 0.0332];
textbox6.String = {'Please select an option'};

%% Basin name
textbox = uicontrol(fig,'Style','text','Units','normalized');
textbox.Position = [0.3151 0.2205 0.0875 0.0459];
textbox.String = {'User selected Ocean:','basin'};
% choice
textbox7 = uicontrol(fig,'Style','text','ForegroundColor','r','Units','normalized');
textbox7.Position = [0.4589 0.2332 0.0620 0.0332];
textbox7.String = {'Please select an option'};

%% Precipitation dataset name 
textbox = uicontrol(fig,'Style','text','Units','normalized');
textbox.Position = [0.6427 0.3424 0.0875 0.0712];
textbox.String = {'User selected Precipitation:','dataset'};
% choice
textbox8 = uicontrol(fig,'Style','text','ForegroundColor','r','Units','normalized');
textbox8.Position = [0.7599 0.3795 0.0620 0.0332];
textbox8.String = {'Please select an option'};

%% Evaporation dataset name 
textbox = uicontrol(fig,'Style','text','Units','normalized');
textbox.Position = [0.6479 0.2244 0.0797 0.0514];
textbox.String = {'User selected evaporation:','dataset'};
% choice
textbox9 = uicontrol(fig,'Style','text','ForegroundColor','r','Units','normalized');
textbox9.Position = [0.7604 0.2439 0.0620 0.0332];
textbox9.String = {'Please select an option'};

%% Heat flux dataset name 
textbox = uicontrol(fig,'Style','text','Units','normalized');
textbox.Position = [0.8501 0.4995 0.0875 0.0439];
textbox.String = {'User selected L&S heat flux:','dataset'};
textbox = uicontrol(fig,'Style','text','Units','normalized');
textbox.Position = [0.8501 0.3695 0.0875 0.0439];
textbox.String = {'User selected L&S radiation flux:','dataset'};
% turbulant comp. choice
textbox0 = uicontrol(fig,'Style','text','ForegroundColor','r','Units','normalized');
textbox0.Position = [0.9404 0.5102 0.0620 0.0332];
textbox0.String = {'Please select an option'};
% radiative comp. choice
textbox01= uicontrol(fig,'Style','text','ForegroundColor','r','Units','normalized');
textbox01.Position = [0.9404 0.3802 0.0620 0.0332];
textbox01.String = {'Please select an option'};


end