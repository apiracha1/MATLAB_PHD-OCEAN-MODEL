%
%
% [LATITUDE,LONGITUDE,~,~,~,~,~,ARATIO]=COLTSREG(OCEAN,SIZ)
%
% most if this routine is never used, it is used to provide the correct
% latitude and longitude verctors as well as an appropriate aspect ratio
% for plotting the respective ocean regions
% input: name of the ocean basin OCEAN (string), size of the region SIZ
% mostly used ouput: LATITUDE, LONGITUTDE, ARATIO
% the other output paramters are actually not needed, they are rather a
% left over of when I first wrote the routine.
%
%

function [latitude longitude regdiv cm bbox trange srange aratio] = colTSreg(ocean,siz)

if strcmp(ocean,'SO')
    
    latitude = -89.5:-40.5;
    longitude = 1:360;
    regdiv = nan(siz(1),siz(2));
    cmfull = jet(54); cm = cmfull(1:3:end,:);
    bbox = [1 60 1 30; 61 120 1 30; 121 180 1 30; 181 240 1 30; 241 300 1 30; 301 360 1 30;...
            1 60 31 40; 61 120 31 40; 121 180 31 40; 181 240 31 40; 241 300 31 40; 301 360 31 40;...
            1 60 41 50; 61 120 41 50; 121 180 41 50; 181 240 41 50; 241 300 41 50; 301 360 41 50];
    t = 0;
    for b = 1:size(bbox,1)
        regdiv(bbox(b,3):bbox(b,4),bbox(b,1):bbox(b,2)) = t; t = t+1;
    end
    trange = -5:0.5:25; srange = 28:0.5:38;
    aratio = [3 1 1];
    
elseif strcmp(ocean,'IO')
    
    latitude = -40:19;
    longitude = 29:119;
    regdiv = nan(siz(1),siz(2));
    cmfull = jet(54); cm = cmfull(1:3:end,:);
    bbox = [1 15 1 20; 16 30 1 20; 31 45 1 20; 46 60 1 20; 61 75 1 20; 76 91 1 20;...
            1 15 21 40; 16 30 21 40; 31 45 21 40; 46 60 21 40; 61 75 21 40; 76 91 21 40;...
            1 15 41 60; 16 30 41 60; 31 45 41 60; 46 60 41 60; 61 75 41 60; 76 91 41 60];
    t = 0;
    for b = 1:size(bbox,1)
        regdiv(bbox(b,3):bbox(b,4),bbox(b,1):bbox(b,2)) = t; t = t+1;
    end
    trange = 10:0.5:35; srange = 28:0.5:38;
    aratio = [2 1 1];
    
elseif strcmp(ocean,'SP')
    
    latitude = -40:-5.5;
    longitude = 149:269;
    regdiv = nan(siz(1),siz(2));
    cmfull = jet(54); cm = cmfull(1:3:end,:);
    bbox = [1 20 1 12; 21 40 1 12; 41 60 1 12; 61 80 1 12; 81 100 1 12; 101 121 1 12;...
            1 20 13 24; 21 40 13 24; 41 60 13 24; 61 80 13 24; 81 100 13 24; 101 121 13 24;...
            1 20 25 35; 21 40 25 35; 41 60 25 35; 61 80 25 35; 81 100 25 35; 101 121 25 35;];
    t = 0;
    for b = 1:size(bbox,1)
        regdiv(bbox(b,3):bbox(b,4),bbox(b,1):bbox(b,2)) = t; t = t+1;
    end
    trange = 10:0.5:35; srange = 30:0.5:40;
    aratio = [2 1 1];

elseif strcmp(ocean,'EP')
    
    latitude = -4.5:4.5;
    longitude = 149:269;
    regdiv = nan(siz(1),siz(2));
    cm = jet(6);
    bbox = [1 20 1 10; 21 40 1 10; 41 60 1 10;  61 80 1 10; 81 100 1 10; 101 121 1 10];
    t = 0;
    for b = 1:size(bbox,1)
        regdiv(bbox(b,3):bbox(b,4),bbox(b,1):bbox(b,2)) = t; t = t+1;
    end
    trange = 15:0.5:35; srange = 32:0.5:37;
    aratio = [5 1 1];
   
elseif strcmp(ocean,'NP')
    
    latitude = 5:59;
    longitude = 119:239;
    regdiv = nan(siz(1),siz(2));
    cmfull = jet(54); cm = cmfull(1:3:end,:); cm = [cm; 0.5 0 0];
    bbox = [1 20 1 15; 21 40 1 15; 41 60 1 15; 61 80 1 15; 81 100 1 15; 101 121 1 15;...
            1 40 16 30; 41 60 16 30; 61 80 16 30; 81 100 16 30; 101 121 16 30;...
            1 20 31 45; 21 40 31 45; 41 60 31 45; 61 80 31 45; 81 100 31 45; 101 121 31 45;...
            1 60 46 55; 61 120 46 55];
    t = 0;
    for b = 1:size(bbox,1)
        regdiv(bbox(b,3):bbox(b,4),bbox(b,1):bbox(b,2)) = t; t = t+1;
    end
    trange = -5:0.5:35; srange = 25:0.5:40;
    aratio = [2 1 1];

elseif strcmp(ocean,'NA')
    
    latitude = 0:44;
    longitude = -90.5:-0.5;
    regdiv = nan(siz(1),siz(2));
    cmfull = jet(54); cm = cmfull(1:3:end,:); 
    bbox = [1 15 1 15; 16 30 1 15; 31 45 1 15; 46 60 1 15; 61 75 1 15; 76 91 1 15;...
            1 15 16 30; 16 30 16 30; 31 45 16 30; 46 60 16 30; 61 75 16 30; 76 91 16 30;...
            1 15 31 45; 16 30 31 45; 31 45 31 45; 46 60 31 45; 61 75 31 45; 76 91 31 45];
    t = 0;
    for b = 1:size(bbox,1)
        regdiv(bbox(b,3):bbox(b,4),bbox(b,1):bbox(b,2)) = t; t = t+1;
    end
    trange = 0:0.5:35; srange = 28:0.5:38;
    aratio = [2 1 1];
    
elseif strcmp(ocean,'NA2')
    
    latitude = -10:54;
    longitude = -90.5:14.5;
    regdiv = nan(siz(1),siz(2));
    cmfull = jet(54); cm = cmfull(1:3:end,:); 
    bbox = [1 15 1 15; 16 30 1 15; 31 45 1 15; 46 60 1 15; 61 75 1 15; 76 91 1 15;...
            1 15 16 30; 16 30 16 30; 31 45 16 30; 46 60 16 30; 61 75 16 30; 76 91 16 30;...
            1 15 31 45; 16 30 31 45; 31 45 31 45; 46 60 31 45; 61 75 31 45; 76 91 31 45];
    t = 0;
    for b = 1:size(bbox,1)
        regdiv(bbox(b,3):bbox(b,4),bbox(b,1):bbox(b,2)) = t; t = t+1;
    end
    trange = 0:0.5:35; srange = 28:0.5:38;
    aratio = [1.25 1 1];    
elseif strcmp(ocean,'NAext')
    
    latitude = -20:54;
    longitude = -90.5:-0.5;
    regdiv = nan(siz(1),siz(2));
    cmfull = jet(54); cm = cmfull(1:3:end,:); 
    bbox = [1 15 1 15; 16 30 1 15; 31 45 1 15; 46 60 1 15; 61 75 1 15; 76 91 1 15;...
            1 15 16 30; 16 30 16 30; 31 45 16 30; 46 60 16 30; 61 75 16 30; 76 91 16 30;...
            1 15 31 45; 16 30 31 45; 31 45 31 45; 46 60 31 45; 61 75 31 45; 76 91 31 45];
    t = 0;
    for b = 1:size(bbox,1)
        regdiv(bbox(b,3):bbox(b,4),bbox(b,1):bbox(b,2)) = t; t = t+1;
    end
    trange = 0:0.5:35; srange = 28:0.5:38;
    aratio = [1 1 1];

elseif strcmp(ocean,'SA')
    
    latitude = -40:-1;
    longitude = -60.5:29.5;
    regdiv = nan(siz(1),siz(2));
    cmfull = jet(56); cm = cmfull(1:4:end,:); 
    bbox = [1 18 1 20; ...
            19 36 1 10; 37 54 1 10; 55 72 1 10; 73 90 1 10; 
            19 36 11 20; 37 54 11 20; 55 90 11 20; ...
            19 36 21 30; 37 54 21 30; 55 90 21 30; ...
            1 36 31 40; 37 54 31 40; 55 90 31 40];
    t = 0;
    for b = 1:size(bbox,1)
        regdiv(bbox(b,3):bbox(b,4),bbox(b,1):bbox(b,2)) = t; t = t+1;
    end
    trange = 5:0.5:30; srange = 28:0.5:38;
    aratio = [2 1 1];
    
elseif strcmp(ocean,'TP') %% added luigi castaldo 03.03.2016 
% missing remaining paramethers 
% regdiv=0; cm=0; bbox=0; trange=0; srange=0; aratio=[1 1 1];  
longitude = 120:280;  latitude = 71:110;        
regdiv=0; cm=0; bbox=0; trange=0; srange=0; aratio=[1 1 1];   
elseif strcmp(ocean,'all')
    
    latitude = -89.5:90;
    longitude = 0.5:359.5;
    regdiv = nan(siz(1),siz(2));
    cmfull = jet(56); cm = cmfull(1:4:end,:); 
    bbox = [1 18 1 20; ...
            19 36 1 10; 37 54 1 10; 55 72 1 10; 73 90 1 10; 
            19 36 11 20; 37 54 11 20; 55 90 11 20; ...
            19 36 21 30; 37 54 21 30; 55 90 21 30; ...
            1 36 31 40; 37 54 31 40; 55 90 31 40];
    t = 0;
    for b = 1:size(bbox,1)
        regdiv(bbox(b,3):bbox(b,4),bbox(b,1):bbox(b,2)) = t; t = t+1;
    end
    trange = 5:0.5:30; srange = 28:0.5:38;
    aratio = [1.7 1 1];
    
end
            
            