function longsss = dataset_titles_sal(sal)
% dataset_titles_sal                                            Returns proper name for dataset signifier
%============================================================
% 
% USAGE:  
% dataset_titles_sal(sal)
%                                                   *All variables set
%                                                   through Control_Center
% 
%  Note that dataset_titles_temp has all variables pre set through
%  choices in Control_Center.
%
% DESCRIPTION:
%  **As of 1/11/2019 
% Function converts the dataset signifier choosen by user to the propername
% of the dataset.
% 
% INPUT:
% sal = salinity dataset signifier      [ string ]
% 
% OUTPUT:
% longsss = proper name of dataset      [ string ]
%
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1 (Monday 11th November 2019) ******STARTING FRESH COUNT
%
% REFERENCES:
% No References
%
% The software is currently in development
%
%============================================================

    if strcmp(sal,'aqOI')
                    longsss = 'Aquarius OI';
                elseif strcmp(sal,'smosbin')
                    longsss = 'SMOS BINNED';
    elseif strcmp(sal,'smosOA')
        longsss = 'SMOS OA';
                elseif strcmp(sal,'argoNRT')
                    longsss = 'Argo ISAS';
                elseif strcmp(sal,'woa09')
                    longsss = 'WOA 09';
    end


end