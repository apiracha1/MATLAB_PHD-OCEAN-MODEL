function form_geo_regions(ocean,S,T,months,seasons,n_stat,lat,lon,stripes_both,sal,month,tframe)
% form_geo_regions_plot                             Plots geo form and highlights corresponding connected 
%                                                                   components with pre-defined parameters   
%============================================================
% 
% USAGE:  
% form_geo_regions_plot(ocean,S,T,months,seasons,n_stat) 
%                                                   *All variables set
%                                                   through Control_Center
% 
%  Note that form_geo_regions_plot has all variables pre set through
%  choices in Control_Center.
%
% DESCRIPTION:
%  **As of 10/10/2019 
% Function plots geo location of formation and highlights on TS graph
% corresponding connected components
%
% INPUT:
%  ocean = ocean name           [ string ] 
%  [S, T] = salinity and temperature sampling points    [ PSU ]  [ degC ]
%  months = current month number       [ number ] ***MAKE FUNCTION MONTH_FROM_NUM
%  seasons = name of seasons             [ string ]  ****NEED TO UPDATE/CHECK IF NEEDED
%  n_stat  =  Statistically random point for monte carlo                [ number ]
% 
% OUTPUT:
% None
% 
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1 (Friday 11th October 2019) *****STARTING FRESH COUNT
%
% REFERENCES:
% None
%
% The software is currently in development
%
%============================================================

%   sorting, so largest con comp (and form. info) comes first 
[~,I] = sort(cellfun(@length,stripes_both.form_mOA),'descend');
ordered_stripes.stripesOA = stripes_both.stripesOA(I);
ordered_stripes.form_mOA = stripes_both.form_mOA(I);
ordered_stripes.form_sOA = stripes_both.form_sOA(I);
ordered_stripes.form_MCOA = stripes_both.form_MCOA(I);

    for k = 1:2   % Over this many con. comps
        nanmaskOA = uncertainty_for_stripes(n_stat,35,ordered_stripes.form_MCOA{1,k});      % uncertainty in geo extent of form.   [ % ]
        [row,col] = ind2sub([75 81],ordered_stripes.stripesOA{1,k});
        t = boundary(S(col)',T(row)');
        figure(12)
%         subplot(1,2,1)
        bounds = plot(S(col(t)),T(row(t)),'k-','LineWidth',3);
        form_geo_regions_plot(ocean,1,1,1,ordered_stripes.form_mOA{1,k},0,100,lat,lon,sal,month,tframe,n_stat,k)        % plotting geo form. (mean)
        uncertainty_extent_plot(1,1,1,nanmaskOA,ocean,n_stat,lat,lon,sal,tframe,month,k)     % plotting uncertainty geo
%% Making GiF        
%         frame = getframe (f);   
%         im{k} = frame2im(frame);
        pause(0.5)
        boundaries_past = [bounds];
        delete(boundaries_past)
    end
% filename = [ocean,'-',num2str(months),'-',seasons{1},'.gif'];
%     for k = 1
%         cd /run/media/ap/Drive/Documents/LatexDocuments/PHD-BEC/Figures/.gif/
%         [A,Map] = rgb2ind(im{k},256);
%         if k == 1
%             imwrite(A,Map,filename,'gif','LoopCount',...
%                 inf,'DelayTime',3);
%         else
%             imwrite(A,Map,filename,'gif','WriteMode',...
%                 'append','DelayTime',3);        
%         end
%     end
% figure(6);
% clf
end
% =======================END==================================