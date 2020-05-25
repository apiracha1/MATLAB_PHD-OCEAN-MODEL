function plot_mean_sat (trueval1,product,lat,long,~,charvartype,truevar,~,~,~,all)
%%------------------------Start of Header----------------------------------
% To be called from Hist_10_500(lat,long)
% ROUTINE                    plot_mean_sat
% AUTHOR                     Aqeel Piracha
% MAIL                       piracha.aqeel@gmail.com
% DATE                       january, 9th 2018
% VERSION                    1.0 
% PURPOSE                    plots the means of 10, 20, 50, 100 & 500 MC
%                            against the true satellite value to see 
%                            convergence.
%
% INPUT
% vartype                     variable array with values of each MC
%                             realization
% charvartype/product         a character identifier corresponding to the
%                             name of the variable name of vartype
% truevar/l                   the true value of the respective variable
%                             (vartype) as measured by the satellite
%
% lat, long                   latitude and longitude of the pixel which the
%                             variable has been taken from IN CHARACTER 
%                             FORM.
%%-----------------------------End of Header-------------------------------

%% empty arrays to be filled, representing mean, mode and median of each MC
all_mean = [];
all_mode = [];
all_median = [];

%% starting the loop to work out stats for each of the MC realizations
for n = [10 20 50 100 500]
% for n = 500
   
    load([num2str(n),'.mat'],product);
    
    if strcmp (product,'sss1')
        sss = mean (sss1);    
        all_mean = [all_mean sss];
        
        sssm = hist_sss_sst_n_pix(sss1,charvartype,truevar,n,lat,long,all);
        all_mode = [all_mode sssm];
        
        sssme = median (sss1);    
        all_median = [all_median sssme];
        
    elseif strcmp (product,'sst1')
        sst = mean (sst1);
        all_mean = [all_mean sst];
        
        sstm = hist_sss_sst_n_pix(sst1,charvartype,truevar,n,lat,long,all);    
        all_mode = [all_mode sstm];
        
        sstme = median (sst1);    
        all_median = [all_median sstme];
        
    elseif strcmp (product,'ssf')
        ssf1 = mean (ssf);
        all_mean = [all_mean ssf1];
        
        ssf1m = hist_sss_sst_n_pix(ssf,charvartype,truevar,n,lat,long,all);    
        all_mode = [all_mode ssf1m];
        
        ssf1me = median (ssf);    
        all_median = [all_median ssf1me];
        
    elseif strcmp (product,'ssd')
        ssd1 = mean (ssd);
        all_mean = [all_mean ssd1];
        
        ssd1m = hist_sss_sst_n_pix(ssd,charvartype,truevar,n,lat,long,all);    
        all_mode = [all_mode ssd1m];
        
        ssd1me = median (ssd);    
        all_median = [all_median ssd1me];
        
    elseif strcmp (product,'form')
        

        ssform = nanmean (form);
        all_mean = [all_mean ssform];
        
        ssformm = hist_sss_sst_n_pix(form,charvartype,truevar,n,lat,long,all);    
        all_mode = [all_mode ssformm];
        
        ssformme = nanmedian (form);    
        all_median = [all_median ssformme];
    end
    
end

%% plotting profile of each MC case with annotation of eacha MC number
clf

hold on
plot (1:5, all_mean,'r-')
plot (1:5, all_mode,'m-')
plot (1:5, all_median,'g-')



text (1,all_mean(1),'MC = 10')
text (1,all_mode(1),'MC = 10')
text (1,all_median(1),'MC = 10')


text (2,all_mean(2),'MC = 20')
text (2,all_mode(2),'MC = 20')
text (2,all_median(2),'MC = 20')

text (3,all_mean(3),'MC = 50')
text (3,all_mode(3),'MC = 50')
text (3,all_median(3),'MC = 50')

text (4,all_mean(4),'MC = 100')
text (4,all_mode(4),'MC = 100')
text (4,all_median(4),'MC = 100')

text (5,all_mean(5),'MC = 500')
text (5,all_mode(5),'MC = 500')
text (5,all_median(5),'MC = 500')

%% plotting true sat value as well as formatting figure
hold on
plot (1:5,(ones (size(1:5)) * trueval1),'k-')
xlabel ('No. of Runs')
    if strcmp (product,'sss1')
        ylabel ('SSS (PSU)')
    elseif strcmp (product,'sst1')
        ylabel ('SST (\circC)')
    elseif strcmp (product,'ssf')
        ylabel ('SS\sigma_f (Sv)')
    elseif strcmp (product,'ssd')
        ylabel ('SS\sigma (kgm^-^3)')       
    elseif strcmp (product,'form')
        ylabel ('Formation (Sv)')
    end
title(['Mean values from MC against satellite measurement',' @ lat =','1S',' & long = 112W'])
legend ('mean','mode','median','Satellite value')

%% setting y limits to be within a unit of the true sat value
ylim ([trueval1-1 trueval1+1])
load([num2str(n),'.mat'],product);

%% creating a folder and saving figure
cd C:\Users\Administrator\Documents\Figures\Histograms
mkdir (['./option4_',lat,'_',long,'/mean_truesat_',lat,'_',long])
cd (['./option4_',lat,'_',long,'/mean_truesat_',lat,'_',long])

    fname = ([product ,'10_20_50_100_500_monte-carlo_vs_true_sat_@_lat=',lat,'_&_lon=',long]);
    print ('-dpng', fname,'-r300')
    
%% changing to correct directory 
cd (['C:\Users\Administrator\Documents\routines\smos_box\TSdiag\',lat,'_',long])
pause    
plot_stat_500 (truevar,product,lat,long,charvartype,truevar,all)

end
