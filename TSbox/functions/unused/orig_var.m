function [SSS,SST,F,rho] = orig_var(month)

load('/home/ap/PHD-BEC/ESA/smos_box/TSdiag/Variables/1_degree/jan13dec13/Jan/All_variables.mat',...
                    'SST','SSS','F','rho')
                SSS = SSS(:,:,month);
                SST = SST(:,:,month);
                SST = SST - 273.15;
                
end       
           