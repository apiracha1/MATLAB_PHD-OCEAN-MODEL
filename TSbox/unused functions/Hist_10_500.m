function Hist_10_500(lat,long)
%%------------------------Start of Header----------------------------------

% ROUTINE                    Hist_10_500
% AUTHOR                     Aqeel Piracha
% MAIL                       piracha.aqeel@gmail.com
% DATE                       january, 9th 2018
% VERSION                    1.0 
% PURPOSE                    plots the statistics of 10, 20, 50, 100 & 500 MC
%                            against the true satellite value 
%
% INPUT

% lat, long                   latitude and longitude of the pixel which the
%                             variable has been taken from IN CHARACTER 
%                             FORM.

%%-----------------------------End of Header-------------------------------

%% loading relevent files (prsumed to be saved in current directory)
cd (['C:\Users\Administrator\Documents\routines\smos_box\TSdiag\',lat,'_',long])
load(['true _',lat,'_',long,'.mat'])

form_true = form; clear form;


h = figure;
set (h,'units','normalized','outerposition',[0 0 1 1])

%% starting the loop to work out stats for each of the MC realizations
for n = [10 20 50 100 500]
% for n = 500
   
    all = load([num2str(n),'.mat']);
    load([num2str(n),'.mat']);
    cd C:\Users\Administrator\Documents\Figures\Histograms
    mkdir (['./option4_',lat,'_',long,'/',num2str(n)])
    cd (['./option4_',lat,'_',long,'/',num2str(n)])
       
    [~] = hist_sss_sst_n_pix(sss1,'sss',s1,n,lat,long,all.sss1);
    fname = (['SSS_for_',num2str(n),'_monte-carlo_@_lat=',lat,'_&_lon=',long]);
    print ('-dpng', fname,'-r300')
    pause (0.5)

    [~] = hist_sss_sst_n_pix(sst1,'sst',t1,n,lat,long,all.sst1);
    fname = (['SST_for_',num2str(n),'_monte-carlo_@_lat=',lat,'_&_lon=',long]);
    print ('-dpng', fname,'-r300')    
    pause(0.5)
    
    [~] = hist_sss_sst_n_pix(ssd,'ssd',d,n,lat,long,all.ssd);
    fname = (['SSD_for_',num2str(n),'_monte-carlo_@_lat=',lat,'_&_lon=',long]);
    print ('-dpng', fname,'-r300')    
%     pause(0.5)

    [~] = hist_sss_sst_n_pix(ssf,'ssf',f,n,lat,long,all.ssf);
    fname = (['SSF_for_',num2str(n),'_monte-carlo_@_lat=',lat,'_&_lon=',long]);
    print ('-dpng', fname,'-r300')
    pause(0.5)
 
    [~] = hist_sss_sst_n_pix(form,'formation',form_true,n,lat,long,all.form);
    fname = (['formation_for_',num2str(n),'_monte-carlo_@_lat=',lat,'_&_lon=',long]);
    print ('-dpng', fname,'-r300')
    
    [~] = hist_sss_sst_n_pix(form1,'formation',form_true,n,lat,long,all.form);
    fname = (['formation_for_',num2str(n),'_monte-carlo_@_lat=',lat,'_&_lon=',long]);
    print ('-dpng', fname,'-r300')
    
cd (['C:\Users\Administrator\Documents\routines\smos_box\TSdiag\',lat,'_',long])
     pause (0.5)
end
%% plotting profiles of stats from ses of MC nd true sat
plot_mean_sat (s1,'sss1',lat,long,sss1,'sss',s1,n,lat,long,all.sss1)
plot_mean_sat (t1,'sst1',lat,long,sst1,'sst',t1,n,lat,long,all.sst1)
plot_mean_sat (d,'ssd',lat,long,ssd,'ssd',d,n,lat,long,all.ssd)
plot_mean_sat (f,'ssf',lat,long,ssf,'ssf',f,n,lat,long,all.ssf)
plot_mean_sat (form_true,'form',lat,long,form,'formation',form_true,n,lat,long,all.form)
% close all
end