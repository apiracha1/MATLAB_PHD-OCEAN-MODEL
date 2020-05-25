function lon = correct_lon_err(sal,ocean,lon)
%pacific ocean lon to distance tends to be unrealistically enlarged. This
%function corrects this error
 if ~strcmp(sal,'argoNRT') && ~strcmp(sal,'smosOA')
                    if strcmp(ocean,'NP') || strcmp(ocean,'EP') ||...
                            strcmp(ocean,'SP') || strcmp(ocean,'TP') ||...
                            strcmp(ocean,'SO')
                        lon(lon<0)=lon(lon<0)+360;
                    end
end
end