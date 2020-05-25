function save_figures_TS_flux()

figure (26)
title ('Mean-Equatorial Pacific- 2013')
print -r300 -dpng SMOSOI_SSS_OSTIA_SST_SSdens_flux_T_S_Trans_2013_n_20_MEAN_TP.png
close

figure (25)
title ('STD-Equatorial Pacific- 2013')
print -r300 -dpng SMOSOI_SSS_OSTIA_SST_SSdens_flux_T_S_Trans_2013_n_20_STD_EP.png
close

main_climsat_error_v12
end