function plot_stat_500 (trueval,product,lat,long,charvartype,truevar,all)
%%------------------------Start of Header----------------------------------
% To be called from Hist_10_500(lat,long)
% ROUTINE                    plot_mean_sat
% AUTHOR                     Aqeel Piracha
% MAIL                       piracha.aqeel@gmail.com
% DATE                       january, 9th 2018
% VERSION                    1.0 
% PURPOSE                    plots each value of 500 MC
%                            against the true satellite value.
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

cd (['C:\Users\Administrator\Documents\routines\smos_box\TSdiag\',lat,'_',long])
clf

%% plotting with the case of each variable each value + overlayed lines of 
% mean, median, mode of the 500 MC
n =  500;
   
    load([num2str(n),'.mat'],product);
    
    if strcmp (product,'sss1')
        sss = mean (sss1);    
       
        sssm = hist_sss_sst_n_pix(sss1,charvartype,truevar,n,lat,long,all);

        sssme = median (sss1);    
        
        close all
        
        hold on
        
        plot (1:500,sss1,'b-')
        plot (0:500,ones(size (0:500))*sss,'r-')
        plot (0:500,ones(size (0:500))*sssm,'m-')
        plot (0:500,ones(size (0:500))*sssme,'g-')

        
    elseif strcmp (product,'sst1')
        sst = mean (sst1);
        
        sstm = hist_sss_sst_n_pix(sst1,charvartype,truevar,n,lat,long,all);    
        
        sstme = median (sst1);    
        
        clf
        hold on
        
        plot (1:500,sst1,'b-')
        plot (0:500,ones(size (0:500))*sst,'r-')
        plot (0:500,ones(size (0:500))*sstm,'m-')
        plot (0:500,ones(size (0:500))*sstme,'g-')

    elseif strcmp (product,'ssf')
        ssf1 = mean (ssf);
        
        ssf1m = hist_sss_sst_n_pix(ssf,charvartype,truevar,n,lat,long,all);    
          
        ssf1me = median (ssf);    
        clf
        hold on
        
        plot (1:500,ssf,'b-')
        plot (0:500,ones(size (0:500))*ssf1,'r-')
        plot (0:500,ones(size (0:500))*ssf1m,'m-')
        plot (0:500,ones(size (0:500))*ssf1me,'g-')
        
        stdd = std(ssf);
        gtext (['STD = ',num2str(stdd)])
        
    elseif strcmp (product,'ssd')
        ssd1 = mean (ssd);
        
        ssd1m = hist_sss_sst_n_pix(ssd,charvartype,truevar,n,lat,long,all);    
        
        ssd1me = median (ssd);    
        clf
        hold on
        
        plot (1:500,ssd,'b-')
        plot (0:500,ones(size (0:500))*ssd1,'r-')
        plot (0:500,ones(size (0:500))*ssd1m,'m-')
        plot (0:500,ones(size (0:500))*ssd1me,'g-')
        
        
    elseif strcmp (product,'form')
        
%         truevar = truevar ./ max (form);
% %         form = form ./ abs(min(form));
%         form = form ./ max(form);
        
        ssform = nanmean (form);
        
        ssformm = hist_sss_sst_n_pix(form,charvartype,truevar,n,lat,long,all);    
     
        ssformme = nanmedian (form);    
        clf
        hold on
        
        plot (1:500,form,'b-')
        plot (0:500,ones(size (0:500))*ssform,'r-')
        plot (0:500,ones(size (0:500))*ssformm,'m-')
        plot (0:500,ones(size (0:500))*ssformme,'g-')
   
    end

    
    
    
%% overlaying true sat & formatting figure    
hold on
plot (0:500,(ones (size(0:500)) * truevar),'k-')
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
        ylim ([trueval-1 trueval+1])
        ylabel ('Formation (Sv)')
    end
    ylim ([truevar-1 truevar+1])
title(['Mean values from MC 500 against satellite measurement',' @ lat =',lat,' & long = ',long])
legend ('MC=500','mean','mode','median','Satellite value')

%% saving figure 
cd C:\Users\Administrator\Documents\Figures\Histograms
cd (['./option4_',lat,'_',long,'/mean_truesat_',lat,'_',long])

    fname = ([product ,'500_monte-carlo_vs_true_sat_@_lat=',lat,'_&_lon=',long]);
    print ('-dpng', fname,'-r300')
    
cd (['C:\Users\Administrator\Documents\routines\smos_box\TSdiag\',lat,'_',long])
    
end
