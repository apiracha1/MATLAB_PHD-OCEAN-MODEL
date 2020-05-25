function h = sub_plot_sort(time_frame,months,years,sal,season,fullname,tframe,monthss,fign)
% sub_plot_sort                             Sorts subplots location
%                                                               depending on years and months.
%============================================================
% 
% USAGE:  
% sub_plot_sort(time_frame,months,years,sal,season,fullname,tframe,monthss,fign)
%                                                   *All variables set
%                                                   through calling
%                                                   function
% 
%
% DESCRIPTION:
%  **As of 13/10/2019 
% Sorts subplots location depending on years and months.
%
% INPUT:
%  time_frame = user selected year(s)      [ number ]
%  months  = user selected month(s)     [ number ]
%  years = number of years      [ number ]
%  sal = name of salinity dataset       [ string ]
%  season  = number of season       [ nunmber ]
%  fullname = full name of ocean basin  [ string ]
%  tframe  = time frame number      [ number ]
%  monthss  = month number      [ number ]
% 
% OUTPUT:
%  h = subsequent figure handle    [ handle ]
% 
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1 (Sunday 13th October 2019) *****STARTING FRESH COUNT
%
% REFERENCES:
% None
%
% The software is currently in development
%
%============================================================
                if length(time_frame) > 1 && length(months) == 1
                    figure (fign)
                    subplot (2,length(time_frame),years)
                elseif length(time_frame) == 1 && length(months) == 1
                    
                   if strcmp(sal,'smosOA')
                       figure (fign)
                       h = subplot (2,2,3);
                   else
                        figure(fign)
                        h = subplot (2,2,1);
                   end
                elseif length(months) > 1 && length(time_frame) > 1
                    figure (fign+2)
                    if years > 1
                        monthss = monthss + (length(months)*(years-1));
                    end
                    subplot (length(time_frame),length(months),monthss)
                elseif length(months) > 1 && length(time_frame) == 1
                    figure (fign)
                   if strcmp(sal,'smosOA')
                    subplot (length(months)/3,length(months)/4,monthss)       
                         title([fullname,' - ',season,'  - SMOS OA - 20',tframe(end-1:end),...
                    ' - MEAN'])
                   else
                    subplot (length(months)/3,length(months)/4,monthss)   
                    title([fullname,' - ',season,' - SMOS BINNED - 20',tframe(end-1:end),...
                    ' - MEAN'])
                   end
                end

end