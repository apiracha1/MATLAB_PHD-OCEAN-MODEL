function  modee = hist_sss_sst_n_pix(vartype1,charvartype,truevar,MC,lat,long,~)
%%------------------------Start of Header----------------------------------
% To be called from Hist_10_500(lat,long)
% ROUTINE                    hist_sss_sst_n_pix
% AUTHOR                     Aqeel Piracha
% MAIL                       piracha.aqeel@gmail.com
% DATE                       january, 9th 2018
% VERSION                    1.0 
% PURPOSE                    to plot histogram of a single pixel from
%                            ssflux global maps, representing each of the 
%                            MC realizations with their mean, median and
%                            mode compared to the value as measured by the 
%                            satellite
%
% INPUT
% vartype                     variable array with values of each MC
%                             realization
% charvartype                 a character identifier corresponding to the
%                             name of the variable name of vartype
% truevar                     the true value of the respective variable
%                             (vartype) as measured by the satellite
% MC                          number of montecarlo realizations applied to
%                             variable
% lat, long                   latitude and longitude of the pixel which the
%                             variable has been taken from IN CHARACTER 
%                             FORM.
% 
% OUTPUTS
% mode                        the most common value of the variable closest
%                             to the satellite value
%%-----------------------------End of Header-------------------------------
%% formatting variable array
vartype1 = vartype1';

% ps = fitdist(vartype,'normal');
% 
% m = '\mu = ';
% std = '\sigma = ';
% fit = 'Distribution: ';
% true = 'From satellite = ';
% diff = 'absolute difference = ';


%% extracting barhights from histogram
clf



% truevar = truevar ./ max (vartype);
% % vartype = vartype ./ abs(min(vartype));
% vartype = vartype ./ max (vartype);




h = histfit (vartype1,100,'normal');
Y = get (h,'Ydata');
measur = Y{1,1};
max_measur = max (measur(:));

ylim ([0 max_measur])
% xlim ([truevar-1 truevar+1])

% measur = Y{2,1};
% max_measur = max (measur(:));


%% overlaying lines of mean and median of mc
hold on
plot (zeros(size(0:max_measur+(max_measur*0.9)))+truevar,0:max_measur+((max_measur*0.9)),'k-')
text (truevar,max_measur-0.8,'Satellite','rotation',90)

plot (zeros(size(0:max_measur+(max_measur*0.9)))+nanmean(vartype1),0:max_measur+((max_measur*0.9)),'r-')
text (nanmean(vartype1),max_measur-0.8,'mean','rotation',90)

plot (zeros(size(0:max_measur+(max_measur*0.9)))+nanmedian(vartype1),0:max_measur+((max_measur*0.9)),'g-')
text (nanmedian(vartype1),max_measur-0.8,'median','rotation',90)

%% finding mode of MC, most common value closest to satellite value
X = get (h,'xdata');
idx1 = X{1,1};
[~, index] = min (abs(idx1(1,:) - truevar));
idx = find (measur(1,:)== max_measur);

[~, index] = min(abs (idx - index));

idxx = idx1(1,:);
modee = idxx(idx(index));


plot (zeros(size(0:max_measur+(max_measur)))+modee,0:max_measur+((max_measur)),'m-')
text (modee,max_measur-0.8,'mode','rotation',90)



%% title changes and labelling for each product
if strcmp(charvartype,'sss')
    xlabel ('SSS (PSU)')
    title (['SSS for ',num2str(MC),' monte-carlo @ lat = ',lat,' & long = ',long,' - JAN 2011'])
elseif strcmp(charvartype,'sst')
    xlabel ('SST (\circC)')
    title (['SST for ',num2str(MC),' monte-carlo @ lat = ',lat,' & long = ',long,' - JAN 2011'])
elseif strcmp (charvartype,'ssf')
    xlabel ('SS\sigma_f (Sv)')
    title (['SS\sigma_f for ',num2str(MC),' monte-carlo @ lat = ',lat,' & long = ',long,' - JAN 2011'])
elseif strcmp (charvartype,'ssd')
    xlabel ('SS\sigma (kgm^-^3)')
    title (['SS\sigma for ',num2str(MC),' monte-carlo @ lat = ',lat,' & long = ',long,' - JAN 2011'])
elseif strcmp (charvartype,'formation') 
        xlabel ('Formation (Sv)')
        title (['Formation (Sv) for ',num2str(MC),' monte-carlo @ lat = ',lat,' & long = ',long,' - JAN 2011'])
end

ylabel ('No. of measurements')

legend ('bar','gaussian fit','Satellite','mean', 'median','mode')



end
