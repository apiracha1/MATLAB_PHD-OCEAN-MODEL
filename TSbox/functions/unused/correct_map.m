function correct_map(latitude,longitude,ocean)   
%drawing a world map which surround lat-lon of user selected ocean basin

        if strcmp (ocean,'SO')
            worldmap ([-90 latitude(end)],[longitude(1) longitude(end)])
        elseif strcmp (ocean,'all')
            worldmap world
        else
            worldmap ([latitude(1) latitude(end)],[longitude(1) longitude(end)])
        end
end