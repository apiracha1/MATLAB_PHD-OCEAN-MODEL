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