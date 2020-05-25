function monte_carlo_hist(var,var_name,error_var,~,lat,lon,mon,x,y,ocean,fign,units,...
    randnumgen,seed,n_stat,unc,fign_map,difference,width,point_width,T,S)
% monte_carlo_hist                              creates annotated histograms of uncertainty components from Monte-carlo
%                                                                                  SSS - [ PSU ]
%                                                                                  SST - [ K ]
%                                                                       Heat fluxes - [ W/m^2 ]
%                                                                  Freshw. fluxes - [ mm/day ]
%============================================================
%
% USAGE:
% monte_carlo_hist(var,var_name,error_var,sigma,lat,lon,mon,x,y,ocean,fign,units)
%                                                   *All variables set
%                                                   through Control_Center
%
% DESCRIPTION:
%  **As of 10/01/2020
% Function plots pdf of uncertainty components and annotates -1 and +1sigma
% as well as plotting the number of events per bin.
%
% INPUT:
%  var = the original data without monte-carlo [ matrix 3-d ]
% var_name = name of variable in question [ string ]
%  error_var = data with monte-carlo applied [ matrix 4-d ]
% sigma = uncertainty in variable [ num ]
% [lat,lon] = lat and lon of basin [ matrices ]
% mon = month in question [ num ]
%  [x,y] = lat lon of point being analysed [ numbers ]
% ocean = name of ocean in question [ string ]
% fign = figure number [ num ]
% units = units for axis label [ string ]
%
% OUTPUT:
%  None
%
% AUTHOR:
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1 (Friday 10th January 2020) *******STARTING FRESH COUNT
% NOTES on VERSION:
%                                   None
%
% REFERENCES:
% None
%
% The software is currently in development
%
%============================================================
if unc ~= 0
    if size(error_var,4) >1
        [~,~,~,dd] = size(error_var);
    else
        [~,~,dd] = size(error_var);
    end
[indx,indy] = basin_bounds(ocean,lat,lon);
for i = x
    for j = y
        for k = 1
            figure(fign)
            clf
            set(gcf,'Color','w')
            subplot(4,1,1:3)
            SSS_rnd = zeros(dd,1);
                if size(error_var,4) >1
                    SSS_rnd(1:dd,1) = error_var(i,j,k,1:dd);
                else
                    SSS_rnd(1:dd,1) = error_var(i,j,1:dd);
                end
            if isnan(var(i,j,k))
                pause(0.5); 
                continue 
            else
                ca = [min(SSS_rnd),max(SSS_rnd)];
                edges = min(SSS_rnd):width:max(SSS_rnd);
                histogram(SSS_rnd,edges,'Normalization','pdf');
                xlim(ca)
                if size(error_var,2) ~= 101
                title({['Histograms from Monte-carlo @ ',num2str(lat(indy(j))),'N & ',...
                    num2str(lon(indx(i))),'E for ',var_name],...
                    ['Skewness = ',num2str(skewness(SSS_rnd)),' - Kurtosis = ',num2str(kurtosis(SSS_rnd)),...
                    ' - STD = ',num2str(nanstd(SSS_rnd))],...
                    ['random number generator = ',randnumgen,' & seed = ',num2str(seed)],...
                    ['# of Monte-Carlo Simulations = ',num2str(n_stat),' & uncertainty = ',num2str(unc)]})
                else
                 title({['Histograms from Monte-carlo @ ',num2str(T(x)),' [\circC] & ',...
                    num2str(S(y)),' [PSU] for ',var_name],...
                    ['Skewness = ',num2str(skewness(SSS_rnd)),' - Kurtosis = ',num2str(kurtosis(SSS_rnd)),...
                    ' - STD = ',num2str(nanstd(SSS_rnd))],...
                    ['random number generator = ',randnumgen,' & seed = ',num2str(seed)],...
                    ['# of Monte-Carlo Simulations = ',num2str(n_stat),' & uncertainty = ',num2str(unc)]})
                end
                xgrid1 = linspace(min(SSS_rnd),max(SSS_rnd),length(edges));
                    mu = nanmean(SSS_rnd);
                pd = makedist('Normal','mu',mu,'sigma',nanstd(SSS_rnd));
                pdfEst = pdf(pd,xgrid1);
                hold on
                    plot(xgrid1,pdfEst,'LineWidth',1.5)

               if size(var,3) >1
                    xline(var(i,j,mon),'k-','Truth','Linewidth',1.5);                
                    xline(mu+nanstd(var(i,j,mon)),'k-','+1\sigma','Linewidth',3);
                    xline(mu-nanstd(var(i,j,mon)),'k-','-1\sigma','Linewidth',3);                
               else
                    xline(var(i,j),'k-','Truth','Linewidth',1.5);
                    xline(mu+nanstd(SSS_rnd),'k-','+1\sigma','Linewidth',3);
                    xline(mu-nanstd(SSS_rnd),'k-','-1\sigma','Linewidth',3);
               end
                xline(mu,'k-','Mean','Linewidth',1.5);

                


%                  
                ylabel('PDF')
                hold off
                subplot(4,1,4)
                events_bin = histcounts(SSS_rnd,length(edges));
                plot(xgrid1,events_bin)
                title(['# of events per bin for ',num2str(sum(events_bin(:))), ' simulations.'])
               if size(var,3) >1
                    xline(var(i,j,mon),'k-','Truth','Linewidth',1.5);                
                    xline(var(i,j,mon)+nanstd(var(i,j,mon)),'k-','+1\sigma','Linewidth',3);
                    xline(var(i,j,mon)-nanstd(var(i,j,mon)),'k-','-1\sigma','Linewidth',3);
               else
                    xline(var(i,j),'k-','Truth','Linewidth',1.5);
                    xline(mu+nanstd(SSS_rnd),'k-','+1\sigma','Linewidth',3);
                    xline(mu-nanstd(SSS_rnd),'k-','-1\sigma','Linewidth',3);
               end
                xline(mu,'k-','Mean','Linewidth',1.5);
                xlim(ca)
                xlabel(units)
                ylabel('# of events')
                figure(fign_map)
               if size(error_var,2) ~= 101
                plotm(lat(indy(j)),lon(indx(i)),'g.','MarkerSize',20);
                else
                plot(36,27.5,'g.','MarkerSize',20);
                end
            end
            figure(fign+1)
            clf
            set(gcf,'Color','w')
            SSS_prime = difference(:);
            SSS_prime(isnan(SSS_prime)) = [];
            ca = [min(SSS_prime),max(SSS_prime)];
            edges = min(SSS_prime):point_width:max(SSS_prime);
            subplot(4,1,1:3)
            histogram(SSS_prime,edges,'Normalization','pdf');
            xlim(ca)
            mu = nanmean(SSS_prime);
            xgrid1 = linspace(min(SSS_prime),max(SSS_prime),length(edges));
            pd = makedist('Normal','mu',mu,'sigma',nanstd(SSS_prime));
            pdfEst = pdf(pd,xgrid1);
            hold on
            if ~strcmp(units,'[Kgm^{-2}s^{-1}]')
                plot(xgrid1,pdfEst,'LineWidth',1.5)
            end
            xline(0,'k-','Truth','Linewidth',1.5);
            xline(nanmean(SSS_prime),'k-','Mean','Linewidth',1.5);
            xline(mu+nanstd(SSS_prime),'k-','+1\sigma','Linewidth',3);
            xline(mu-nanstd(SSS_prime),'k-','-1\sigma','Linewidth',3);
             
           ylabel('PDF')
            hold off
            subplot(4,1,4)
            events_bin = histcounts(SSS_prime,length(edges));
            plot(xgrid1,events_bin)
            title(['# of grid points per bin for ',num2str(sum(events_bin(:))), ' gridpoints in total.'])
            xline(0,'k-','Truth','Linewidth',1.5);
            xline(nanmean(SSS_prime),'k-','Mean','Linewidth',1.5);
            xline(mu+nanstd(SSS_prime),'k-','+1\sigma','Linewidth',3);
            xline(mu-nanstd(SSS_prime),'k-','-1\sigma','Linewidth',3);
            xlim(ca)
            xlabel(units)
            ylabel('# of points')
            subplot(4,1,1:3)
            title({['\DeltaReference-Mean for ',num2str(sum(events_bin)),' points with ',...
                    'Skewness = ',num2str(skewness(SSS_prime)),' - Kurtosis = ',num2str(kurtosis(SSS_prime)),...
                    ' - STD = ',num2str(nanstd(SSS_prime))],...
                    ['random number generator = ',randnumgen,' & seed = ',num2str(seed)],...
                    ['# of Monte-Carlo Simulations = ',num2str(n_stat),' & ^{\Delta',var_name,'}/_{\surdN} = ',...
                    num2str(unc/sqrt(n_stat))]})
%             pause(0.5)
%             delete(j)
         end
    end
end
else
end

end