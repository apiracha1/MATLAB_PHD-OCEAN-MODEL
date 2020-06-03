function NEW_DATA = regridding_dataset_c(NEW_RES,OLD_RES,X_NEW_GRID,Y_NEW_GRID,data)
% matlab code of similar function written in c
SCALE_S = round(NEW_RES / OLD_RES);
	for x = 1:X_NEW_GRID
		for y = 1:Y_NEW_GRID
            if (x == 1) 
                old_x = ((x) / (1 / SCALE_S))-3;
            else
                old_x = ((x) / (1 / SCALE_S))-3;
            end
            if (y == 1) 
                old_y = ((y) / (1 / SCALE_S))-3;
            else
                old_y = ((y) / (1 / SCALE_S))-3;
            end
            if (old_y >= 677)
                old_y = 676;
            end
            if (old_x >= 253)
                old_x = 252;
            end

            if ((mod(x-1,SCALE_S) == 0) && (mod(y-1,SCALE_S) == 0))
				NEW_DATA(x,y) = data(old_x,old_y);
			else 
				interpd_data = data(old_x,old_y) * (1 - ( 1 / (1 / SCALE_S)))...
					+ data(old_x + 1,old_y) * (1 - (( (1 / SCALE_S) - 1)  / (1 / SCALE_S)));
				interpd_data2 = data(old_x,old_y + 1) * (1 - (1 / (1 / SCALE_S)))...
					+ data(old_x + 1,old_y + 1) * (1 - (( (1 / SCALE_S) - 1) / (1 / SCALE_S)));
				new_data = interpd_data * (1 - (1 / (1 / SCALE_S)))...
					+ interpd_data2 * (1 - (( (1 / SCALE_S) - 1) / (1 / SCALE_S)));
				NEW_DATA(x,y) = new_data;
            end

		end
	end
end