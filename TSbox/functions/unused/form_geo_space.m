
function Fpeak = form_geo_space(formation_error,oSSS,oSST,n_stat,stripes,S,T,dS,dT,oxx,oyy,...
    str_num,latitude,longitude)

[row,col] = ind2sub([75 81], stripes{1,str_num});
Fpeak = nan(size(oSSS,1),size(oSSS,2),size(oSST,3),n_stat); 

f = waitbar(0,'Please wait for geographical conversion...');  % Message box to wait while computation is ongoing
for n_statrec = 1:n_stat
                    waitbar(n_statrec/n_stat,f,[num2str(n_statrec),...
                        ' Realisations computed out of ', num2str(n_stat)])         % Progress bar
    for m = 1:size(oSST,3)
        for j = 1:size(oSST,1)
            for i = 1:size(oSST,2)
                for t = 1:length(row)
                    if oSSS(j,i,m) > S(col(t)) - dS && oSST(j,i,m) < S(col(t)) + dS
                        if oSST(j,i,m) > T(row(t)) - dT && oSST(j,i,m) < T(row(t)) + dT
                            for t = 2:length(T)
                                if oSST(j,i,m) > T(t-1) && oSST(j,i,m) < T(t)
                                    for s = 2:length(S)
                                        if oSSS(j,i,m) > S(s-1) && oSSS(j,i,m) < S(s)
                                        Fpeak(j,i,m,n_statrec) = formation_error(t,...
                                            s,m,n_statrec)./(oxx(j,i).*oyy(j,i));
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
end