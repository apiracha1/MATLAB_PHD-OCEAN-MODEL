function [Geo_formation_all_MC_locs] = peaklocs (fignum,choice,ocean,...
    Form_Data,all_TS_WM,oSSS,oSST,oxx,oyy,n_stat,times,...
    Geo_formation_all_MC_locs,Fscatt_unchanged,num,original,sal_name,temp_name,...
    year,prec,month)
%%------------------------Start of Header----------------------------------
%
% ROUTINE                    peaklocs
% AUTHOR                     Aqeel Piracha
% MAIL                       piracha.aqeel@gmail.com
% DATE                       November, 27th 2016
% VERSION                    1.0 Nov 25 2017 ,1.2 26 Nov 2017, 1.3 27 Nov
%                            2017,1. 4 mar 2018 finds boundaries of the edges detected around formation reagions and accosiated temp and sal
%                            values limits to the two most prominant
%                            regions. v1.1 abilty to transition throigh all
%                            function without user input (for certain
%                            choices)
% PURPOSE                    to automaticaly identify all peaks in WM form
%                            from WM form graphs in T-S space 
%
% INPUT
% fignum                     figure number(s) of WM form in T-S space
% 
% OUTPUTS
% peaks                      Formation value (Sv) of each peak identified
% h                          Figure handle of figures where function was
%                            applied
%%-----------------------------End of Header-------------------------------


x = dbstack;

NASTMW_S = 36.5;
NPSTMW_S = 34.85;
SASTMW_S = 35.7;
SPSTMW_S = 35.5;
IOSTMW_S = 35.51;
SOSTMW_S = 35;

NASTMW_T = 18;
NPSTMW_T = 16.5;
SASTMW_T = 15;
SPSTMW_T = 17;
IOSTMW_T = 16.54;
SOSTMW_T = 9.5;


sal_x = [];
temp_y = [];

peaks = [];
regions = [];


h = figure (fignum);
% set(h,'units','normalized','outerposition',[0 0 1 1])

Form_Data(isnan(Form_Data)) = 0;

maxform = max(Form_Data(:)); 
minform = min(Form_Data(Form_Data>(maxform/3.5)));
thresh = maxform/minform;
if choice ~= 5
           
    if strcmp(ocean,'TP') && fignum == 21 && choice == 5
        minform = min(Form_Data(Form_Data>(maxform/3.5)));
    elseif strcmp(ocean,'SP') && choice == 5
        minform = min(Form_Data(Form_Data>(maxform/3.5)));
    elseif  strcmp(ocean,'SA') && choice == 5
         
    else
        minform = min(Form_Data(Form_Data>(maxform/3.5)));
    end

    
end

if choice == 5
    Form_Data(isnan(Form_Data)) = 0;
    Form_Data(Form_Data<(maxform/thresh)) = -999999;
    FormData = imadjust(Form_Data);
    [~, threshold] = edge(FormData,'sobel');
    bws = edge(FormData,'sobel',1.5*threshold);
else
    Form_Data(isnan(Form_Data)) = 0;
    Form_Data(Form_Data<(maxform/thresh)) = -999999;
    FormData = imadjust(Form_Data);    
    [~, threshold] = edge(FormData,'sobel');
    bws = edge(FormData,'sobel',.3*threshold);
end

sal_Data = get (all_TS_WM,'XData');
temp_Data = get (all_TS_WM,'YData');

   
%%    

%%
%finds boundaries of the edges detected above and accosiated temp and sal
%values limits to the two most prominant regions

se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);

bwsdil = imdilate(bws,[se90 se0]);
bwfill = imfill(bwsdil,'holes');
bwnoboard = imclearborder(bwfill,4);

sed = strel ('diamond',1);

if choice == 5
    bwfinal = imerode(bwfill,sed); % added bwfill instead NA2 choice 5
else
    bwfinal = imerode(bwnoboard,sed);
end  


bwfinal = imerode(bwfinal,sed);

[rowsOfMaxes, colsOfMaxes] = find(bwfinal == 1);

sal = sal_Data(colsOfMaxes);
temp = temp_Data(rowsOfMaxes);
% plot (sal,temp,'k.')
hold on

regions = bwconncomp(bwfinal);
if isempty(regions)
    msgbox('NO PEAKS DETECTED','ERROR','error')
    [Theta_S_pos1, Theta_S_pos2, Theta_T_pos1, Theta_T_pos2] = rec_peak_data (peaks,...
        h,regions,ocean,sal_x_closest_STMW,temp_y_closest_STMW);
end

regions_that_are_important = regions.PixelIdxList;
maxx = [];

for i = 1:length(regions_that_are_important)
    len = length(regions_that_are_important{i});
    maxx = [maxx len];
end

[i] = find (maxx == max(maxx));

for n = 1:length(regions.PixelIdxList)

    a = regions.PixelIdxList{1,n};
%     a = regions.PixelIdxList{1,i};

    if length(a)<13
        continue
    end

    Region_val = Form_Data(a);
    peak_region = max(Region_val);
    peaks = [peaks peak_region];

    [rowsOfMaxes, colsOfMaxes] = find(Form_Data == peak_region);
%     [k,l] = find(Form_Data == max(Form_Data(:)));

    sal = sal_Data(colsOfMaxes);
    temp = temp_Data(rowsOfMaxes);

%     sal_x = [sal_x sal];
%     temp_y = [temp_y temp];
    
%     sal = sal_Data(l);
%     temp = temp_Data(k);

    
    plot(sal,temp,'k.')
    if temp < 16 && sal < 36.3 
        continue
    end

    Theta_S_pos1 = sal - (0.25);
    Theta_S_pos2 = sal + (0.25);

    Theta_T_pos1 = temp + 1;
    Theta_T_pos2 = temp - 1;

     r = rectangle('Position',...
         [Theta_S_pos1,Theta_T_pos2,...
         Theta_S_pos2-Theta_S_pos1,Theta_T_pos1-Theta_T_pos2],...
         'linewidth',1.5);

    Geo_formation_all_MC_locs = wm_form_maps_months_18deg_JFM_NEW (Theta_S_pos1,...
        Theta_S_pos2,Theta_T_pos1,Theta_T_pos2,Fscatt_unchanged,oSSS,...
        oSST,oxx,oyy,times,Geo_formation_all_MC_locs,num,original,...
        n_stat,ocean,sal_name,temp_name,...
        year,prec,month);                    
    
    break
end
end


