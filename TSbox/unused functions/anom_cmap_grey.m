%
%
% anom_cmap_grey
%
% creates a symmetric blue-red colormap 
% the ouput CM is a 32 by 3 matrix containg the RGB trios for a blue-red
% colormap with grey at the center
%

cm = zeros(31,3);

cm(1:6,1) = 0.5:0.1:1;
cm(6:16,1) = ones(11,1); cm(6:16,2) = 0:0.1:1; cm(6:16,3) = 0:0.1:1;
cm(16:21,1) = 1:-(1/5):0; cm(16:21,2) = ones(6,1); cm(16:21,3) = ones(6,1);
cm(21:31,2) = 1:-0.1:0; cm(21:31,3) = [1; 1; 1; 1; 1; 1; 1; 0.9; 0.8; 0.7; 0.6];

cm(16,:) = [0.5 0.5 0.5];
cm = flipud(cm);