function [data,lat,lon] = loading_datasets(dataset_name,variable_name,comp_name,tframe,...
    desired_resolution,desired_temporal_resolution,variable_num_nc)           
% loading_datasets                             loads user chosen dataset from source *.nc in any resolution 
%                                                                     chosen by user 
%============================================================
% 
% USAGE:  
% loading_datasets(dataset_name,variable_name,comp_name,tframe,...
%     desired_resolution,temporal_resolution,variable_num_nc) 
%                                                   *All variables set
%                                                   through Control_Center
%                                                   and chosen function
%
% DESCRIPTION:
%  **As of 7/11/2019 
% Function loads user chosen dataset and variables from source *.nc file
% and computes a linear spatial and temporal interpolation to desired
% resolution
% 
% INPUT:
% dataset_name = Name of the dataset in question            [ string ]
% variable_name = Name of the variable desired             [ string ]
% comp_name = heat flux component desired (LEAVE EMPTY IF variable_name NOT
%                                       HEATFLUX                [ string ]
% tframe = The time frame for the dataset (YEAR)        [ string ]
% desired_resolution = Resolution desired by user for outputted dataset     [ number (deg) ] 
% desired_temporal_resolution = temporal resolution desired by user     [ number ] 
%                                                   (1 for year, 12 for
%                                                   month, 365 for day e.t.c )
% variable_num_nc = the number of the variable desired as output from ncinfo  [ number ] 
% 
% OUTPUT:
% data = the resultant dataset in the linearly interpolated to the desired
%                                                           spatial and temporal resolution   [ 3-D matrix ]
%
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1.1 (Thursday 7th November 2019) *******STARTING FRESH COUNT
% NOTES on VERSION:
% None
%
% REFERENCES:
% None
% 
% The software is currently in development
%
%============================================================
%     first_path();
cd /home/ap/PHD-BEC/ESA/smos_box/TSdiag/
    data_all = nan(360/desired_resolution,180/desired_resolution,...
                     desired_temporal_resolution);
    File = dir(fullfile(['./data/',variable_name,'/',dataset_name,'/',tframe,'/',num2str(1),'/'],'*.nc'));
    msg1 = waitbar(0,['Loading ',dataset_name,'...']);
    pause(0.3)
    if ~isempty(File)             
            for i = 1:desired_temporal_resolution
               File = dir(fullfile(['./data/',variable_name,'/',dataset_name,'/',tframe,'/',num2str(i),'/'],'*.nc')); 
               for n = 1:length(File)
                   waitbar(n/length(File),msg1,[num2str(n),...
                        ' data files processed for ',dataset_name,' out of ',num2str(length(File))])         % Progress bar
                   dataset_info = ncinfo(['./data/',variable_name,'/',dataset_name,'/',tframe,'/',num2str(i),'/',...
                        File(n).name]);
                    if length(dataset_info.Variables(variable_num_nc).Size) > 1 
                        dataset = ncread(['./data/',variable_name,'/',dataset_name,'/',tframe,'/',num2str(i),'/',...
                            File(n).name],...
                            dataset_info.Variables(variable_num_nc).Name);


                        for j = 1:size(dataset,3)
                            data_indiv = regridding_dataset(dataset(:,:,j),desired_resolution,'linear');
                            data_time_newspace.time{j} = data_indiv;
                        end
                        
                        data_all_orig = nan(size(data_indiv,1),size(data_indiv,2),...
                            size(dataset,3));
                        clear SST_indiv 
                        for k = 1:size(dataset,3)
                            data_all_orig(1:size(data_all_orig,1),1:size(data_all_orig,2),...
                                k) = data_time_newspace.time{k};
                        end
                        clear SST_time_newspace                    
                        data_file.file{n} = nanmean(data_all_orig,3);
                    end
               end
             waitbar(i/desired_temporal_resolution,msg1,['Regridding ',dataset_name])        
              pause(0.3)
              data_files= nan(360/desired_resolution,180/desired_resolution,...
                 length(data_file.file));
                for t = 1:length(File)
                    data_files(1:size(data_indiv,1),1:size(data_indiv,2),...
                     t) = data_file.file{t};
                end
                data_monthly.monthnum{i} = nanmean(data_files,3);
                data_all(1:size(data_all,1),1:size(data_all,2),i) = data_monthly.monthnum{i};
            end
            clear data_month
            data = data_all;
            
    else
        if ~strcmp(variable_name,'Heat_flux')
           File = dir(fullfile(['./data/',variable_name,'/',dataset_name,'/',tframe,'/'],'*.nc')); 
           for n = 1:length(File)
           dataset_info = ncinfo(['./data/',variable_name,'/',dataset_name,'/',tframe,'/',...
                    File(n).name]);
           waitbar(n/length(File),msg1,[num2str(n),...
                        ' data files processed for ',dataset_name,' out of ',num2str(length(File))])   
            if length(dataset_info.Variables(variable_num_nc).Size) >= 2
                    dataset = ncread(['./data/',variable_name,'/',dataset_name,'/',tframe,'/',...
                    File(n).name],...
                        dataset_info.Variables(variable_num_nc).Name);


            end
            data_file.file{n} = dataset;
           end
           msg2 = msgbox(['Regridding ',dataset_name,'...'],'INFO');
            data_files= nan(size(dataset,1),size(dataset,2),size(dataset,3),...
            length(data_file.file));
            for t = 1:length(File)
               data_files(1:size(dataset,1),1:size(dataset,2),1:size(dataset,3),...
                    t) = data_file.file{t};
            end
            if size(data_files,3)==1
                data_files = permute(data_files,[1 2 4 3]);
            end
            dataset = nanmean(data_files,4);
            data_all = regridding_dataset_w_time(dataset,desired_resolution,...
                'linear',desired_temporal_resolution);
            if strcmp(dataset_name,'oaflux')
                data = data_all([size(data_all,1)/2+1:end 1:size(data_all,1)/2],:,:);
            else
                data = data_all;
            end            
           close(msg2)
        else
               File = dir(fullfile(['./data/',variable_name,'/',dataset_name,'/',comp_name,'/',...
                   tframe,'/'],'*.nc')); 
               dataset_info = ncinfo(['./data/',variable_name,'/',dataset_name,'/',comp_name,'/',...
                   tframe,'/',...
                        File.name]);
                if length(dataset_info.Variables(variable_num_nc).Size) > 2
                        dataset = ncread(['./data/',variable_name,'/',dataset_name,'/',comp_name,'/',...
                   tframe,'/',...
                        File.name],...
                            dataset_info.Variables(variable_num_nc).Name);

                end
                data_all = regridding_dataset_w_time(dataset,desired_resolution,...
                    'linear',desired_temporal_resolution);
                data = data_all;
        end
    end
    [lat, lon] = cdtgrid(desired_resolution);
    close(msg1)
end

