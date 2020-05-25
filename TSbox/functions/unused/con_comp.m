function pixels = con_comp(formation_error_mean,S,T)
formation_error_mean(find(formation_error_mean<0))=0;
formation_error_mean(find(formation_error_mean>0))=10;
formation_error_mean(isnan(formation_error_mean)) = 0;
CC = bwconncomp(formation_error_mean,4);
pixels = CC.PixelIdxList;
    for i = 1:length(pixels)
        if length(pixels{1,i}) < 30
            pixels{1,i} = [];
            continue
        end
%         [row,col] = ind2sub([75 81],CC.PixelIdxList{1,i});
%         plot(S(col),T(row),'g.','MarkerSize',10)
    end
end