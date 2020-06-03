function boxAveraging_c(NEW_RES,OLD_RES,X_NEW_GRID,Y_NEW_GRID,data)

SCALE_S = round(NEW_RES/OLD_RES);
NEW_DATA = zeros(X_NEW_GRID,Y_NEW_GRID);
for x = 1:X_NEW_GRID
    for y = 1:Y_NEW_GRID
        for i = 1:4
                for j = 1:4
                    if (x == 1) 
                        old_x = ((x) / (1 / SCALE_S))-3+(i-1);
                    else
                        old_x = ((x) / (1 / SCALE_S))-3+(i-1);
                    end
                    if (y == 1) 
                        old_y = ((y) / (1 / SCALE_S))-3+(j-1);
                    else
                        old_y = ((y) / (1 / SCALE_S))-3+(j-1);
                    end
                    if (old_y >= 677)
                        old_y = 676-4;
                    end
                    if (old_x >= 253)
                        old_x = 253-4;
                    end
            
                    NEW_DATA(x,y) = NEW_DATA(x,y)+data(old_x,old_y)/16;
                end
                
        end
    end
end

end