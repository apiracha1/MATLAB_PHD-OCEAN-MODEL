function imp_monte_carlo_hist(var,vare,units,perc_bar,x,y,x_unit,y_unit,var_name,unc,n_stat,fign)
% imp_monte_carlo_hist                             creates a histogram from
%                                                                       the outputs of monte-carlo simulation
%============================================================
% 
% USAGE:  
% imp_monte_carlo_hist(var,vare,units,perc_bar,x,y,x_unit,y_unit,var_name,unc,n_stat,fign)
%                                                   *All variables set
%                                                   through Control_Center
% 
% DESCRIPTION:
% Function calculates all parameters from density flux to formation (both
% TS and rho)
%
% INPUT:
% var = reference dataset [ matrix ] 
% vare = error dataset (after monte-carlo) [ matrix ]
% units = units of variable [ string ]
% perc_bar = percentage width for bar
% [x,y,x_unit,y_unit] = point at which histogram is taken [ numbers and strings ]
% var_name = name of variable [ string ]
% unc = uncertainty in variable [ number ]
% n_stat = statistically random points for Monte-carlo [ number ]
% fign = figure number to begin plotting [ number ]
% 
% OUTPUT:
% NONE
% 
% AUTHOR: 
%  Aqeel Piracha            [ apiracha@btinternet.com ]
%
% VERSION NUMBER: 1 (Monday 10th February 2020) *******STARTING FRESH COUNT
% NOTES on VERSION:
%
% REFERENCES:
%
% The software is currently in development
%
%============================================================
            vare = vare(:);
            mu = nanmean(vare);
            sigma = nanstd(vare);
            kurt = kurtosis(vare);
            skew = skewness(vare);
%% Histogram            (PDF)
            figure(fign)
            clf
            set(gcf,'Color','w')
            subplot(4,1,1:3)
            ca = [min(vare),max(vare)];
            binwidth = abs(ca(1) - ca(2))/100;
            binwidth = binwidth*perc_bar;
            edges = min(vare):binwidth:max(vare);
            histogram(vare,edges,'Normalization','pdf');
            xlim(ca)
            xgrid1 = linspace(min(vare),max(vare),length(edges));
            title({['Histograms from Monte-carlo @ ',num2str(x),' ',num2str(x_unit),' - ',...
                    num2str(y),' ',num2str(y_unit),' ',var_name],...
                    ['Skewness = ',num2str(skew),' - Kurtosis = ',num2str(kurt),...
                    ' - STD = ',num2str(sigma)],...
                    ['# of Monte-Carlo Simulations = ',num2str(n_stat),' & uncertainty: ',unc]},'fontsize',13)
           ylabel('PDF','FontSize',14)
             

%% Overlaying gaussian
            pd = fitdist(vare,'Normal');
            pdfEst = pdf(pd,xgrid1);
            hold on
            plot(xgrid1,pdfEst,'LineWidth',1.5)
%% important points
            xline(mu,'k-','Mean','Linewidth',1.5);
            xline(var,'k-','Truth','Linewidth',1.5);                
            xline(mu+sigma,'k-','+1\sigma','Linewidth',3);
            xline(mu-sigma,'k-','-1\sigma','Linewidth',3);  
            
%%  Number of events per bin
            subplot(4,1,4)
            events_bin = histcounts(vare,length(edges));
            plot(xgrid1,events_bin)
            xlim(ca)
            xlabel(units,'FontSize',14)
            ylabel('# of events','FontSize',14)
            title(['# of events per bin for ',num2str(sum(events_bin(:))), ' samples.'],'FontSize',14)
%% Important points
            xline(mu,'k-','Mean','Linewidth',1.5);
            xline(var,'k-','Truth','Linewidth',1.5);                
            xline(mu+sigma,'k-','+1\sigma','Linewidth',3);
            xline(mu-sigma,'k-','-1\sigma','Linewidth',3);  

end
