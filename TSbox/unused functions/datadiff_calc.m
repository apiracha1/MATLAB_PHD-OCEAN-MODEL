function [all_form_ts,all_rho] = datadiff_calc(sal,monthss,Fmean1)
%creates new variable containing density flux and density information for both datasets
%to compute differense at a later stage
               if strcmp(sal,'smosOA')
                   all_form_ts(:,:,:,monthss,1)=Fmean1;
               else
                   all_form_ts(:,:,:,monthss,2)=Fmean1;
               end
               %for density maps
               all_rho=[];
%                if strcmp(sal,'smosOA')
%                    all_rho(:,:,monthss,1)=orho(:,:,monthss);
%                else
%                    all_rho(:,:,monthss,2)=orho(:,:,monthss);
%                end


end