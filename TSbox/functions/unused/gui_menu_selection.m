function [h, y, v, x, w, u, s, a, e, f, t] = gui_menu_selection(fig,parameter_evaporation,...
    parameters_MC, parameters_datasets_SSS, parameters_datasets_SST,...
    parameters_computation, parameters_year, parameters_ocean, parameter_precipitation,...
    parameters_season, parameter_heatfluxls, parameter_radfluxls,textbox1, textbox2, textbox3,...
    textbox4, textbox5,...
    textbox6, textbox7, textbox8, textbox9, textbox0, textbox01)
% gui_menu_selection                             various button groups and dropdown menus making 
%                                                                                         bulk of gui
%============================================================
% 
% USAGE:  
% gui_menu_selection()
%                                                   *called from
%                                                   Control_center.m
%                                                   without input arguments
%
% DESCRIPTION:
%  **As of 04/11/2019 
% Function creates dropdown menus, editable windows and radio buttons so
% the user can select their choices.
%
% INPUT:
%  fig = figure to draw to          [ figure ]
% parameter_evaporation = to hold evaporation dataset choice        [ vector ]
% parameters_MC = to hold number of MC simulations choosen          [ vector ]
% [parameters_datasets_SSS, parameters_datasets_SST] = to hold SSS and SST
%                                                                                                   datasets choice name    [ vector ]  
% parameters_computation = to hold the function to be run       [ vector ]
% parameters_year = to hold the year chosen for the computation to be run       [ array ]
% parameters_ocean = to hold the basin name over which the computation will
%                                                                                           be run          [ vector ]
% parameter_precipitation = to hold the name of the precipitation dataset
%                                                                   chosen           [ vector ]
% parameters_season = to hold the season over which the computation will be run       [ array ]
% parameter_heatfluxls = to hold the name of the heat flux (turbulant comp.) product chosen    
%                                                                                                                 [ vector ]
% parameter_radfluxls = to hold the name of the heat flux product (radiative comp.) product chosen.
%                                                                                                     [ vector ]
% % textbox1 = text box holding choice for computation to be run      [ textbox ]
% textbox2 = text box holding choice for # of MC simulations to be run      [ textbox ]
% [textbox3, textbox4] = text box holding choice for year and season     [ textbox ]
% [textbox5, textbox6 ] = text box holding choice for SSS and SST dataset names      [ textbox ]
% textbox7  = text box holding choice for basin     [ textbox ]
% [textbox8, textbox9] = text box holding choice for Precip. and Evap. dataset names     [ textbox ]
% [textbox0, textbox01] = text box holding choice for heat flux (turb.) and heat flux (rad.) 
%                                                                        dataset names             [ textbox ]
% 
% OUTPUT:
% [c, d] = SSS/SST dataset choice selection (group of radio buttons)         [ button group ]
% i = basin dataset choice selection (group of radio buttons)         [ button group ]
% [j, k] = Precip./Evap. dataset choice selection (group of radio buttons)         [ button group ]
% [m, n] = Heat flux (turb.)/(rad.) dataset choice selection (group of radio buttons)   [ button group ]
% a = editable field for MC simulation # input      [ editable textbox ] 
% e = drop down menu for computation selection      [ popup menu ]
% f = drop down menu for year selection         [ popup menu ]
% t = drop down menu for season selection       [ popup menu ]
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
%% COMPUTATION CHOICE 
% message
g = uicontrol(fig,'Style','text','Units','normalized');
g.Position = [0.1609,...
    0.9220,...
    0.0875,...
    0.0566];
g.String = {'Please chose the computation you would like to run'};
% popup menu
e = uicontrol(fig,'Style','popupmenu','Units','normalized');
e.Position = [0.1646,...
    0.8888,...
    0.0771,...
    0.0195];
e.String = {'please choose a computation',...
    'wm_denseflux_geo_error',...
    'wm_transf_TS_error',...
    'wm_transf_rho_error',...
    'wm_form_TS_error',...
    'wm_form_rho_error',...
    'frontiers_paper_figures'};

%% MC SIMULATION #.
% input
a = uicontrol(fig,'Style','edit','Units','normalized');
b = uicontrol(fig,'Style','text','Units','normalized');
a.Position = [0.4281,...
    0.8907,...
    0.0646,...
    0.0195];
b.Position = [0.4163,...
    0.9292,...
    0.0896,...
    0.0552];
% message
b.String = {'Enter the number of random vaiables (and press enter)'};
a.String = {};

%% YEAR 
% message
z = uicontrol(fig,'Style','text','Units','normalized');
z.Position = [0.6859,...
    0.9600,...
    0.0875,...
    0.0263];
z.String = {'Please choose a year'};
% popup menu selection
f = uicontrol(fig,'Style','popupmenu','Units','normalized');
f.Position = [0.6870,...
    0.9220,...
    0.0875,...
    0.0263];
f.String = {'Please choose a year',...
    'jan12dec12',...
    'jan13dec13',...
    'jan14dec14',...
    'jan15dec15',...
    'jan16dec16'};

%% SEASON
% message
m = uicontrol(fig,'Style','text','Units','normalized');
m.Position = [0.6849,...
    0.8839,...
    0.0875,...
    0.0263];
m.String = {'and a month/season'};
% popup menu selection
t = uicontrol(fig,'Style','popupmenu','Units','normalized');
t.Position = [0.6880,...
    0.8507,...
    0.0875,...
    0.0263];
t.String = {'Please choose a month/season',...
    'Jan',...
    'Feb',...
    'Mar',...
    'Apr',...
    'May',...
    'Jun',...
    'Jul',...
    'Aug',...
    'Sep',...
    'Oct',...
    'Nov',...
    'Dec',...
    'JFM',...
    'AMJ',...
    'JAS',...
    'OND',...
    'all',...
    'Each season'};

%% SSS DATASET
% message 
c = uicontrol(fig,'Style','text','Units','normalized');
c.Position = [0.014844562899787,...
    0.792360430950049,...
    0.0875,...
    0.036970257985219];
c.String = {'Please choose an SSS dataset from the list'};

% choices
h = uicontrol(fig,'Style','popupmenu','Units','normalized');
h.Position = [0.019845912039839,...
    0.743798222638039,...
    0.0771,...
    0.0195];
h.String = {'Please choose a SSS dataset',...
    'smosOA'};

%% SST DATASET
% message (button group title)
d = uicontrol(fig,'Style','text','Units','normalized');
d.Position = [0.164844562899787,...
    0.792360430950055,...
    0.0875,...
    0.036970257985219];
d.String = {'Please choose an SST dataset from the list'};
% choices
y = uicontrol(fig,'Style','popupmenu','Units','normalized');
y.Position = [0.167762578706505,...
    0.743798222638039,...
    0.0771,...
    0.0195];
y.String = {'Please choose a SST dataset',...
    'ostia'};

%% PRECIPITATION DATASET
% message (button group title)
j = uicontrol(fig,'Style','text','Units','normalized');
j.Position = [0.30556950959488,...
    0.792360430950054,...
    0.103279104477613,...
    0.036970257985219];
j.String = {'Please choose a Precipitation dataset from the list'};
% choices
x = uicontrol(fig,'Style','popupmenu','Units','normalized');
x.Position = [0.318177912750567,...
    0.743798222638038,...
    0.0771,...
    0.0195];
x.String = {'Please choose a Precipitation dataset',...
    'cmorph',...
    'trmm'};
              
%% EVAPORATION DATASET
%  message (button group title)
k = uicontrol(fig,'Style','text','Units','normalized');
k.Position = [0.469429673063249,...
    0.792360430950055,...
    0.103279104477613,...
    0.036970257985219];
k.String = {'Please choose an Evaporation dataset from the list'};
% choices
w = uicontrol(fig,'Style','popupmenu','Units','normalized');
w.Position = [0.482153792281481,...
    0.743798222638039,...
    0.0771,...
    0.0195];
w.String = {'Please choose a Evaporation dataset',...
    'oaflux'};
              
%% BASIN 
%  message (button group title)
i = uicontrol(fig,'Style','text','Units','normalized');
i.Position = [0.560025799573549,...
    0.672318677296598,...
    0.103279104477613,...
    0.036970257985219];
i.String = {'Please choose an Ocean Basin from the list'};
% choices
v = uicontrol(fig,'Style','popupmenu','Units','normalized');
v.Position = [0.574894330661011,...
    0.621668786312354,...
    0.0771,...
    0.0195];
v.String = {'Please choose a Basin',...
    'NA',...
    'NP',...
    'SA',...
    'SP',...
    'EP',...
    'IO',...
    'SO'};

%% HEAT FLUX DATASET (TURBULANT)
%  message (button group title)
m = uicontrol(fig,'Style','text','Units','normalized');
m.Position = [0.734888095238084,...
    0.792360430950054,...
    0.103279104477613,...
    0.036970257985219];
m.String = {'Please choose a turbulant Heat flux dataset from the list'};
% choices
u = uicontrol(fig,'Style','popupmenu','Units','normalized');
u.Position = [0.747612214456316,...
    0.743798222638038,...
    0.0771,...
    0.0195];
u.String = {'Please choose a feat flux dataset',...
    'nocs'};

%% HEAT FLUX DATASET (RADIATIVE)
%  message (button group title)
n = uicontrol(fig,'Style','text','Units','normalized');
n.Position = [0.73435504619757,...
    0.669187153288231,...
    0.103279104477613,...
    0.036970257985219];
n.String = {'Please choose a radiative Heat flux dataset from the list'};
% choices
s = uicontrol(fig,'Style','popupmenu','Units','normalized');
s.Position = [0.747079165415805,...
    0.62271262764847,...
    0.0771,...
    0.0195];
s.String = {'Please choose a Heat flux dataset',...
    'nocs'};
              
%% RUN!!!!!!!!!!!!!!!!!!!!!!!!
run = uicontrol(fig,'style','pushbutton','BackgroundColor',...
    [0.20,0.60,0.20],'String','RUN','FontSize',18,'Units','normalized');
run.Position = [0.8278 0.1644 0.0959 0.0593];

%% CALLBACKS
h.Callback = @bselection;
y.Callback = @cselection;
x.Callback = @iselection;
w.Callback = @kselection;
v.Callback = @hselection;
u.Callback = @mselection;
s.Callback = @nselection;
a.Callback = @selection;
e.Callback = @dselection;
f.Callback = @eselection;
t.Callback = @sselection;
run.Callback = @plotButtonPushed;

%% Functions for selection operation
% computation selection
    function dselection(src,event)
        parameters_computation = [];
        val = e.Value;
        str = e.String;
        set(textbox1,'visible','on','string',str{val})
        parameters_computation = [parameters_computation str{val}];
    end
% # MC simulation selection
    function n_stat = selection(src,event)
        val = a.Value;
        n_stat = a.String;
        parameters_MC = [];
        if ~isempty(n_stat{1})
            n_stat = n_stat{1};
            set(textbox2,'visible','on','string',n_stat)
            parameters_MC = [parameters_MC n_stat];
        end
        if isempty(n_stat)
            a.String = {'please state a number'};
            pause (1)
            Control_Center
        end
    end
%% DATASET SELECTION
% SSS dataset selection
    function bselection(src,event)
        parameters_datasets_SSS = [];
        val = h.Value;
        str = h.String;
        set(textbox5,'visible','on','string',str{val})
        parameters_datasets_SSS = [parameters_datasets_SSS str{val}];
    end
% SST dataset selection
    function cselection(src,event)
        parameters_datasets_SST = [];
        val = y.Value;
        str = y.String;
        set(textbox6,'visible','on','string',str{val})
        parameters_datasets_SST = [parameters_datasets_SST str{val}];
    end
% precipitation dataset selection
    function iselection(src,event)
        parameter_precipitation = [];
        val = x.Value;
        str = x.String;
        set(textbox8,'visible','on','string',str{val})
        parameter_precipitation = [parameter_precipitation str{val}];
    end
%  evaporation dataset selection
    function kselection(src,event)
        parameter_evaporation = [];
        val = w.Value;
        str = w.String;
        set(textbox9,'visible','on','string',str{val})
        parameter_evaporation = [parameter_evaporation str{val}];
    end
% heat flux dataset selection
    function mselection(src,event)
        parameter_heatfluxls = [];
        val = u.Value;
        str = u.String;
        set(textbox0,'visible','on','string',str{val})
        parameter_heatfluxls = [parameter_heatfluxls str{val}];
    end

    function nselection(src,event)
        parameter_radfluxls = [];
        val = s.Value;
        str = s.String;
        set(textbox01,'visible','on','string',str{val})
        parameter_radfluxls = [parameter_radfluxls str{val}];
    end
%% VARIABLE SELECTION
%-----Calback for Ocean selection------------------------------------------
    function hselection(src,event)
        parameters_ocean = [];
        val = v.Value;
        str = v.String;
        set(textbox7,'visible','on','string',str{val})
        parameters_ocean = [parameters_ocean str{val}];
    end
%-----Callback for year selection------------------------------------------
    function eselection(src,event)
        parameters_year = {};
        val = f.Value;
        str = f.String;
        set(textbox3,'visible','on','string',str{val})
        parameters_year = [parameters_year str{val}];
    end
%-----Callback for month selection-----------------------------------------
    function sselection(src,event)
        parameters_season = [];
        val = t.Value;
        str = t.String;
        set(textbox4,'visible','on','string',str{val})
        parameters_season = [parameters_season str{val}];
    end

%% RUN!!!!!!!!!!!!!!!!!!!!!!!!!
    function plotButtonPushed(src,event)
       if strcmp(parameters_year,'all')
           parameters_year = {};
           for year_names = 2:length(f.String)-1
               parameters_year = [parameters_year f.String{year_names}];
           end
       end
       
%% Executing        
         gui_menu_execution(parameter_evaporation, parameters_MC, parameters_datasets_SSS,...
            parameters_datasets_SST,...
            parameters_computation, parameters_year, parameters_ocean, parameter_precipitation,...
            parameters_season, parameter_heatfluxls, parameter_radfluxls)
    end
end