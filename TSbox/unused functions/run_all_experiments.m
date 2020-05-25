function choice = run_all_experiments()
choice = 7;

    for n_stat = [1,100]
        for ocean = {'NA2','SA','NP','SP','IO','SO'}
            ocean = ocean{1};
            for sal = {'aqOI','smosbin'}
                sal = sal{1};
                for temp = {'ostia'}
                    temp = temp{1};
                    for hflux = {'nocs'}
                        hflux = hflux{1};
                        for radflux = {'nocs'}
                            radflux = radflux{1};
                            for prec = {'cmorph'}
                                prec = prec{1};
                                for tframe = {'jan13dec13','jan12dec12','jan14dec14'}
                                    tframe = tframe{1};
                                    
                                    fprintf('eval: error wm transformation spatial \n')
                                    ocean1 = 'all';
                                    % call routine #1
                                    [path0]=first_path();
                                    % set paramethers routine 1
            %                         temp = 'ostia';
%                                     prec = 'cmorph';
                                    evapo = 'oaflux';
%                                     hflux = 'nocs';
%                                     [radflux] = 'nocs';
                                    colormap_jet_flag=false; % choose colormap 
                                    wm_transf_spatial_error_v1(sal,temp,prec,ocean1,tframe,n_stat,...
                                        colormap_jet_flag,hflux,evapo,radflux);



                                    month = 1:12;
                                    ca_bar=[-2 2]; % choose colormap limits

                                    test_flag=false; % if true save testing values
                                    fprintf('eval: wm form TS seasonal error \n')

                                    % call routine #6
                                    [sal_Data,temp_Data,edgee,edgeee] = wm_form_TS_seasonal_error_v6_2(sal,temp,prec,tframe,month,ocean,...
                                        n_stat,path0,colormap_jet_flag,ca_bar,test_flag,hflux,evapo,radflux);
                                    fprintf('end: wm form TS seasonal error \n')

                                    if n_stat >= 1
                                            season = 1;

                                        month = 1:12;

                                    load(strcat(path0,'\peaks\','season_peaks_location_',tframe,...
                                        ocean,'.mat'))
                                        for season = 1
                                            thetaS(1)=thetaS1(season);
                                            thetaS(2)=thetaS2(season);
                                            thetaT(1)=thetaT1(season);
                                            thetaT(2)=thetaT2(season);
                                            % assign a peak number for saving the plot
                                            theta = 1;
                                            fprintf('eval: error wm formation maps months \n')
                                            
                                            title_s='error-';
                                            fprintf('wm form maps months 18deg season error \n')

                                            % call routine #6
%                                             wm_form_maps_months_18deg_season_error_v2_1(season,...
%                                                 sal,temp,prec,...
%                                                 ocean,tframe,month,n_stat,thetaS,thetaT,title_s,...
%                                                 colormap_jet_flag,ca_bar,hflux,evapo,radflux,sal_Data,temp_Data,edgee,edgeee)

                                            fprintf('end: wm form maps months 18deg season error \n')

                                            % call routine #6
                                            wm_form_maps_months_error_v3_1(sal, temp, prec, ocean,...
                                                tframe, month, thetaT, thetaS,theta,n_stat,...
                                                colormap_jet_flag,ca_bar,hflux,evapo,radflux,[],sal_Data,temp_Data,edgee,edgeee,season)

                                            fprintf('end: error wm formation maps months \n')
                                        end
                                    end       

                                    sal1 = char(sal,'woa09','argoNRT');
                                    temp1 = char(temp,'woa09','argoNRT');


                                    flag_plot=false;
                                    fprintf('eval: wm transformation rho \n')
                                            % call routine #2.1
                                    [Frho_all_1st]=wm_form_rho_v2_1(sal1,temp1,prec,ocean,tframe,...
                                        flag_plot,hflux,evapo,radflux);

                                    % call routine #2.2
                                     wm_form_rho_error_v2_1(sal1,...
                                        temp1,prec,ocean,tframe,n_stat,...
                                        Frho_all_1st,hflux,evapo,radflux);
                                    fprintf('end: error wm transformation rho \n')

                                    close all
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

function [path0]=first_path()
%%------------------------Start of Header----------------------------------
%
% ROUTINE                    first_path
% AUTHOR                     Luigi Castaldo
% MAIL                       luigi.castaldo@gmail.com
% DATE                       March, 10th 2016
% VERSION                    1.0
% PURPOSE                    set paths
%
% INPUT INSIDE ROUTINE
%
% INPUT
%                                     none
%
% OUTPUT
%
%  path0              initial path
%
%
% AUXILIARY SUBROUTINES
%                                     none
%
% RELYSE:
%
% NOTE: it crate a directory in the folder matlabroot/myfilesaving/ and
% saves a file with path inside, in case the paths are wrong for any reason
% reset the path as follows: delete the folder'myfilesaving' and its
% content, close matlab, open matlab and restart the routine;
%
%%-----------------------------End of Header-------------------------------
%% path settings
path0=pwd;
pathxx=strcat(matlabroot,filesep,'myfilesaving',filesep,'path1st.txt');

flag_exec=false;
if exist(pathxx,'file')
    path1st=strcat(cell2mat(textread(pathxx, '%s', 'whitespace', '')));
    if ~exist(path1st,'dir')
        restore_path()
        flag_exec=true;
    end
end
if ~exist(pathxx,'file')|| flag_exec==true
    mkdir(matlabroot,'myfilesaving')
    fileID = fopen(pathxx,'w');
    fprintf(fileID, '%s\n',path0);
    fclose(fileID);
    path1st=path0;
end
path0=path1st;
cd(path0)
path0_sep=find(path0==filesep);
path_start1 = path0(1:path0_sep(end-1));
folderName1 = fullfile(path_start1,'TSbox');
folderName2 = fullfile(path_start1,'TSdiag');
path1 = genpath(folderName1);
addpath(path1)
if exist(folderName2,'dir')
    cd(folderName2)
else
    fprintf('\ntry to use restore path from the menu and restart matlab\n')
    fprintf('\nin case you do not succeed please check the paths\n')
    fprintf('\n than use the command cd(matlabroot) and delete the folder myfilesaving \n')
    fprintf('\n replace the path of the folder containing the main in the file inside myfilesaving \n')
    fprintf('\n in case it is not working mail:luigi.castaldo@gmail.com \n')
end
end
