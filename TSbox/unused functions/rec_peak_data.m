function [Theta_S_pos1, Theta_S_pos2, Theta_T_pos1, Theta_T_pos2] = rec_peak_data (peaks,h,regions,ocean,sal_x_closest_STMW,temp_y_closest_STMW)
%%------------------------Start of Header----------------------------------
%
% ROUTINE                    peaklocs
% AUTHOR                     Aqeel Piracha
% MAIL                       piracha.aqeel@gmail.com
% DATE                       November, 27th 2016
% VERSION                    1.0 Nov 25 2017 ,1.2 26 Nov 2017, 1.3 27 Nov
%                            2017
% PURPOSE                    to automaticaly injest selected peak, region 
%                            or specific T-S range from WM form
%                            to create WM form maps 
%
% INPUT
% h                          figure handle(s) of WM form in T-S space
% peaks                      Formation value (Sv) of each peak identified
% region                     Formation value (Sv) of region identified,
%                            from which T-S range is ascertained
% OUTPUTS
% Theta_S_pos1,              min salinity value of region, peak, or choice
% Theta_S_pos2,              max salinity value of region, peak, or choice
% Theta_T_pos1,              max temperature value of region, peak, or choice
% Theta_T_pos2               min temperature value of region, peak, or choice
%%-----------------------------End of Header-------------------------------

x = dbstack;

all_TS_WM = findobj(h,'type','Surface');
Form_Data = get (all_TS_WM,'CData');
sal_Data = get (all_TS_WM,'XData');
temp_Data = get (all_TS_WM,'YData');


% if h == 1
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
    
%     [rowsOfMaxes, colsOfMaxes] = find(Form_Data == peaks(1));
% 
%     temp = temp_Data(rowsOfMaxes);
%     sal = sal_Data(colsOfMaxes);
% 
%     Theta_S_pos1 = sal - (0.3);
%     Theta_S_pos2 = sal + (0.3);
%     Theta_T_pos1 = temp + 0.6;
%     Theta_T_pos2 = temp - 0.6;
% 
%     rectangle('Position',[ Theta_S_pos1 Theta_T_pos2...
%         Theta_S_pos2-Theta_S_pos1 Theta_T_pos1-Theta_T_pos2],...
%         'linewidth',1.5,'edgecolor','g')
                    

    if x(end-1).name(1) == 'r'
        FROM = 'STMW';

        fprintf(['CREATING MAPS = ',FROM,'\n'])

        if strcmp(ocean,'NA2')
            Theta_S_pos1 = NASTMW_S - (0.3);
            Theta_S_pos2 = NASTMW_S + (0.3);
            Theta_T_pos1 = NASTMW_T + 0.6;
            Theta_T_pos2 = NASTMW_T - 0.6;
        elseif strcmp(ocean,'NP')
            Theta_S_pos1 = NPSTMW_S - (0.3);
            Theta_S_pos2 = NPSTMW_S + (0.3);
            Theta_T_pos1 = NPSTMW_T + 0.6;
            Theta_T_pos2 = NPSTMW_T - 0.6;
        elseif strcmp(ocean,'SA')
            Theta_S_pos1 = SASTMW_S - (0.3);
            Theta_S_pos2 = SASTMW_S + (0.3);
            Theta_T_pos1 = SASTMW_T + 0.6;
            Theta_T_pos2 = SASTMW_T - 0.6;
        elseif strcmp(ocean,'SP')
            Theta_S_pos1 = SPSTMW_S - (0.3);
            Theta_S_pos2 = SPSTMW_S + (0.3);
            Theta_T_pos1 = SPSTMW_T + 0.6;
            Theta_T_pos2 = SPSTMW_T - 0.6;
       elseif strcmp(ocean,'IO')
            Theta_S_pos1 = IOSTMW_S - (0.3);
            Theta_S_pos2 = IOSTMW_S + (0.3);
            Theta_T_pos1 = IOSTMW_T + 0.6;
            Theta_T_pos2 = IOSTMW_T - 0.6;
       elseif strcmp(ocean,'SO')
            Theta_S_pos1 = SOSTMW_S - (0.3);
            Theta_S_pos2 = SOSTMW_S + (0.3);
            Theta_T_pos1 = SOSTMW_T + 0.6;
            Theta_T_pos2 = SOSTMW_T - 0.6;
       end     

        rectangle('Position',[ Theta_S_pos1 Theta_T_pos2...
            Theta_S_pos2-Theta_S_pos1 Theta_T_pos1-Theta_T_pos2],...
            'linewidth',1.5,'edgecolor','b')
%     else
%     
%         choice = questdlg('Would you like to compare with the closest peak as found using the satellite data?', ...
%         'Menu', 'Yes','No','Yes');

%         switch choice
%             case 'Yes'
%                 Theta_S_pos1 = sal_x_closest_STMW - (0.3);
%                 Theta_S_pos2 = sal_x_closest_STMW + (0.3);
%                 Theta_T_pos1 = temp_y_closest_STMW + 0.6;
%                 Theta_T_pos2 = temp_y_closest_STMW - 0.6;
% 
%                 rectangle('Position',[ Theta_S_pos1 Theta_T_pos2...
%                     Theta_S_pos2-Theta_S_pos1 Theta_T_pos1-Theta_T_pos2],...
%                         'linewidth',1.5,'edgecolor','g')
%             case 'No'
%                 exit
%         end

    else


        choice = questdlg('would you like to map a specific T-S RANGE or PEAK visible on the plot?', ...
            'Menu', 'T-S RANGE','PEAK','PEAK');
        if isempty(choice)
                                    [Theta_S_pos1, Theta_S_pos2, Theta_T_pos1, Theta_T_pos2] = rec_peak_data (peaks,h,regions);
        else

             switch choice
    %*****************************
                 case 'T-S RANGE'
                        prompt = {'Enter thetaT min value:',...
                        'Enter thetaT max value:'...
                        'Enter thetaS min value:',...
                        'Enter thetaS max value:'};
                        dlg_title = 'Input';
                        num_lines = 1;
                        defaultans = {'29','30.5','34.8','36.4'};
                        answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
                        if isempty (answer)
                            [Theta_S_pos1, Theta_S_pos2, Theta_T_pos1, Theta_T_pos2] = rec_peak_data (peaks,h,regions);
                        else    
                            Theta_T_pos2 = str2double(answer(1));
                            Theta_T_pos1 = str2double(answer(2));
                        Theta_S_pos1 = str2double(answer(3));
                        Theta_S_pos2 = str2double(answer(4));

                        rectangle('Position',[ Theta_S_pos1 Theta_T_pos2...
                            Theta_S_pos2-Theta_S_pos1 Theta_T_pos1-Theta_T_pos2],...
                               'linewidth',1.5,'edgecolor','g')
                        end
    %*****************************
                 case 'PEAK'
                     prompt = {'Enter PEAK selection: '};
                     dlg_title = 'Input';
                     num_lines = 1;
                     defaultans = {'1','hsv'};
                     input1 = inputdlg(prompt,dlg_title,num_lines,defaultans);
    %                  n=1;
                     n = str2double(input1{1});
                     if isempty (input1)
                         msgbox('NO IDETIFIABLE RANGE','Error','error')
                         [Theta_S_pos1, Theta_S_pos2, Theta_T_pos1, Theta_T_pos2] = rec_peak_data (peaks,h,regions);
                     else

                            fprintf(strcat('peak #:'...
                            , num2str(n),'\n\n'))

                            [rowsOfMaxes, colsOfMaxes] = find(Form_Data == peaks(n));

                            temp = temp_Data(rowsOfMaxes);
                            sal = sal_Data(colsOfMaxes);

                            Theta_S_pos1 = sal - (0.3);
                            Theta_S_pos2 = sal + (0.3);
                            Theta_T_pos1 = temp + 0.6;
                            Theta_T_pos2 = temp - 0.6;

                            rectangle('Position',[ Theta_S_pos1 Theta_T_pos2...
                                Theta_S_pos2-Theta_S_pos1 Theta_T_pos1-Theta_T_pos2],...
                                'linewidth',1.5,'edgecolor','g')
                     end

    % *****************************    
             end


        end
    end
end
