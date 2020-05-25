function [sal_Data,temp_Data,edgee,edgeee,thetaT1, thetaT2,thetaS1, thetaS2] = choices_peaks (flag_peack,~,title_xx,tframe,ocean,n_stat,path0,hx4,selection,prec,evapo,radflux,hflux,longsst,longsss,season)  

figure(hx4)

flag_peack=true;
x = dbstack;

thetaS1=[];
thetaS2=[];
thetaT1=[];
thetaT2=[];


if x(end-1).name(1) == 'r'
    [peaks,h,regions,sal_Data,temp_Data,edgee,edgeee] = peaklocs (hx4,selection,ocean,season,prec,evapo,radflux,hflux,longsst,longsss,n_stat,tframe);

%                       if ~isempty(edgee)
%                           return 
%                       else
%                           [peaks,h,regions,sal_Data,temp_Data,edgee,edgeee] = peaklocs (hx4,selection,ocean,season,prec,evapo,radflux,hflux,longsst,longsss,n_stat);
%                       end

                      if isempty(edgee)
                          [Theta_S_pos1, Theta_S_pos2, Theta_T_pos1,...
                              Theta_T_pos2] = rec_peak_data (peaks,h,regions,ocean,[],[]);

                          thetaS1=min(Theta_S_pos1,Theta_S_pos2);
                          thetaS2=max(Theta_S_pos1,Theta_S_pos2);
                          thetaT1=min(Theta_T_pos1,Theta_T_pos2);
                          thetaT2=max(Theta_T_pos1,Theta_T_pos2);
                          thetaS = [thetaS1 thetaS2];
                          thetaT = [thetaT1 thetaT2];


                            if selection == 6
                                file_name1=strcat('annual_peaks_location_',tframe,ocean,'.mat');
                                save(strcat(path0,'\peaks\',file_name1),...
                                  'thetaT1','thetaT2','thetaS1','thetaS2')
                                fprintf(strcat('saved file:', file_name1,'\n' )) 
                            end
                      end
else
    if n_stat >= 1
                     PromptString1 = ('automate peak finding or manually find peaks?');
    list1 = {'automate',...
        'manually pick'};
    choice = listdlg('PromptString',...
    PromptString1,'ListString',...
    list1,'SelectionMode','single');
        
        if isempty(choice)
             choices_peaks (flag_peack,[],title_xx,tframe,ocean,n_stat,path0,hx4,selection,prec,evapo,radflux,hflux,longsst,longsss,season)  
        elseif choice == 2
                 if flag_peack==true
                     if flag_peack==true
                         sal_Data = [];
                         temp_Data = [];
                         edgee = [];
                         edgeee = [];
                         title_yy=strcat('Peak-',title_xx);
                         mo='year';
                         season=1;
                         [Theta_S_pos1,Theta_T_pos1,Theta_S_pos2,...
                             Theta_T_pos2]=peak_eval_formation...
                             (hx4,mo,season);
                         rectangle('Position',...
                             [Theta_S_pos1, Theta_T_pos2, Theta_S_pos2-Theta_S_pos1,...
                             Theta_T_pos1-Theta_T_pos2],...
                             'linewidth',1.5)
                         % extract correct value to save
                         thetaS1=min(Theta_S_pos1,Theta_S_pos2);
                         thetaS2=max(Theta_S_pos1,Theta_S_pos2);
                         thetaT1=min(Theta_T_pos1,Theta_T_pos2);
                         thetaT2=max(Theta_T_pos1,Theta_T_pos2);

                         thetaS = [thetaS1 thetaS2];
                         thetaT = [thetaT1 thetaT2];
                         
                        if selection == 6
                          file_name1=strcat('annual_peaks_location_',tframe,ocean,'.mat');
                          save(strcat(path0,'\peaks\',file_name1),...
                              'thetaT1','thetaT2','thetaS1','thetaS2')
                          fprintf(strcat('saved file:', file_name1,'\n' )) 
                        end
                         %% save exchange file
                     end
                  end

%                   case 'automate'
        %           if flag_peack==true
        %               if flag_peack==true
            
        elseif choice == 1
    
                      [peaks,h,regions,sal_Data,temp_Data,edgee,edgeee] = peaklocs (hx4,selection,ocean,[]);

                      if ~isempty(edgee)
                          return 
                      else
                          [peaks,h,regions,sal_Data,temp_Data,edgee,edgeee] = peaklocs (hx4,selection,ocean,[]);
                      end

                      if isempty(edgee)
                          [Theta_S_pos1, Theta_S_pos2, Theta_T_pos1,...
                              Theta_T_pos2] = rec_peak_data (peaks,h,regions,ocean,[],[]);

                          thetaS1=min(Theta_S_pos1,Theta_S_pos2);
                          thetaS2=max(Theta_S_pos1,Theta_S_pos2);
                          thetaT1=min(Theta_T_pos1,Theta_T_pos2);
                          thetaT2=max(Theta_T_pos1,Theta_T_pos2);
                          thetaS = [thetaS1 thetaS2];
                          thetaT = [thetaT1 thetaT2];


                            if selection == 6
                                file_name1=strcat('annual_peaks_location_',tframe,ocean,'.mat');
                                save(strcat(path0,'\peaks\',file_name1),...
                                  'thetaT1','thetaT2','thetaS1','thetaS2')
                                fprintf(strcat('saved file:', file_name1,'\n' )) 
                            end
                      end
        end
        end
    end
end


function [Theta_S_pos1,Theta_T_pos1,Theta_S_pos2,Theta_T_pos2]=...
    peak_eval_formation...
    (hx4,mo,season)
%%------------------------Start of Header----------------------------------
%
% ROUTINE                    peak_eval_formation
% AUTHOR                     Luigi Castaldo
% DATE                       April, 14th 2016
% VERSION                    1.0
% PURPOSE                   -Extract peaks in formation by mouse selection
%
% INPUT INSIDE ROUTINE
%                                     none
% INPUT
%
% hx4               -     figure designator
% mo                -     season name [text]
% season            -     index of season [integer]
%
% OUTPUT
%  Theta_S_pos1     -   Salinity peak [1st value]'
%  Theta_T_pos1     -   Temperature peak [1st value]'
%  Theta_S_pos2     -   Salinity peak [2nd value]'
%  Theta_T_pos2     -   Temperature peak [2nd value]'
%
%
% AUXILIARY SUBROUTINES
%
%                           get_fig_cursor_info
%                           mydialogbox
%
% RELYSES:  1.0 April, 14th 2016
%
% COMMENTS: none
%
% NOTES:
%
%%-----------------------------End of Header-------------------------------
text_dialog_b='MOVE the Mouse on the TOP LEFT Corner and press ENTER';
mydialogbox(text_dialog_b);
[Theta_S_pos1,Theta_T_pos1]=get_fig_cursor_info(hx4);
text_dialog_b='MOVE the Mouse on the DOWN RIGHT Corner and press ENTER';
mydialogbox(text_dialog_b);
[Theta_S_pos2,Theta_T_pos2]=get_fig_cursor_info(hx4);

    function mydialogbox(text_dialog_b)
        %%------------------------Start of Header--------------------------
        %
        % ROUTINE                    mydialogbox
        % AUTHOR                     Luigi Castaldo
        % DATE                       April, 14th 2016
        % VERSION                    1.0
        % PURPOSE                   - show text for advice
        %
        % INPUT INSIDE ROUTINE
        %                                     none
        % INPUT
        %
        % text_dialog_b     -   text in dialog box
        %
        %
        % AUXILIARY SUBROUTINES
        %
        %                                     none
        %
        % RELYSES:  1.0 April, 14th 2016
        %
        % COMMENTS: none
        %
        % NOTES:
        %
        %%-----------------------------End of Header-----------------------
        d = dialog('Position',[300 300 250 150],'Name','My Dialog');
        uicontrol('Parent',d,...
            'Style','text',...
            'Position',[20 80 210 40],...
            'String',text_dialog_b);
        uicontrol('Parent',d,...
            'Position',[85 20 70 25],...
            'String','Close',...
            'Callback','delete(gcf)');
    end


    fprintf(strcat('position of max window S1-'...
        ,strtrim(mo(season,:)),'=',num2str(Theta_S_pos1),'\n',...
        'position of max window T1-'...
        ,strtrim(mo(season,:)),'=',num2str(Theta_T_pos1),'\n',...
        'position of max window S2-'...
        ,strtrim(mo(season,:)),'=',num2str(Theta_S_pos2),'\n',...
        'position of max window T2-'...
        ,strtrim(mo(season,:)),'=',num2str(Theta_T_pos2),'\n'))

    draw_rectangle_std(Theta_S_pos1, Theta_T_pos1, Theta_S_pos2, Theta_T_pos2, hx4)
%     draw_rectangle_std(Theta_S_pos1, Theta_T_pos1, Theta_S_pos2, Theta_T_pos2, 21)


end
