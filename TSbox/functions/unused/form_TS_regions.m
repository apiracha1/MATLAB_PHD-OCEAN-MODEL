function form_TS_regions(formation_error,formation_error_unchanged,S,T,oSSS,oSST,n_stat,dS,dT,...
                 oxx,oyy,ocean,num,sal,tframe,lat,lon,month)

formation_error1 = permute(formation_error,[2 3 1]);
formation_error1 = nanmean(formation_error1,3);
stripes = con_comp(formation_error1,S,T);

wm_form_geo_error (formation_error,formation_error_unchanged,oSSS,oSST,n_stat,stripes,...
    S,T,dS,dT,...
                 oxx,oyy,ocean,num,sal,tframe,lat,lon,month)
end
