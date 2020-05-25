function cm = anom_cmap_white(limits)

cm = zeros(32,3);

limdist = limits(2) - limits(1);
lenneg = round(abs(limits(1)/limdist)*size(cm,1));
lenpos = round(abs(limits(2)/limdist)*size(cm,1));

cm(1:round(lenpos/2),1) = 0.3:0.6/(round(lenpos/2)-1):0.9;
cm(1:round(lenpos/2),2) = 0;
cm(1:round(lenpos/2),3) = 0;

cm(round(lenpos/2)+1:lenpos+1,1) = 1;
cm(round(lenpos/2)+1:lenpos+1,2) = 0:0.8/((lenpos+1)-round(lenpos/2)-1):0.8;
cm(round(lenpos/2)+1:lenpos+1,3) = 0:0.8/(lenpos+1-round(lenpos/2)-1):0.8;

% cm(lenpos,:) = [ 0.95    0.95    0.95];

% cm(lenpos,:) = [1.0000    0.1143    0.1143];
% cm(lenpos,:) = [ 0.3000         0    0.6000];
cm(lenpos+1,:) = [1 1 1];


%  keyboard
cm(lenpos+2:lenpos+round(lenneg/3)+1,1) = 0.8:-0.8/(round(lenneg/3)-1):0;
cm(lenpos+2:lenpos+round(lenneg/3)+1,2) = 1;
cm(lenpos+2:lenpos+round(lenneg/3)+1,3) = 1;

cm(lenpos+round(lenneg/3)+2:lenpos+2*round(lenneg/3)+1,1) = 0;
cm(lenpos+round(lenneg/3)+2:lenpos+2*round(lenneg/3)+1,2) = 0.9:-0.5/(round(lenneg/3)-1):0.4;
cm(lenpos+round(lenneg/3)+2:lenpos+2*round(lenneg/3)+1,3) = 1;

cm(lenpos+2*round(lenneg/3)+2:lenpos+lenneg+1,1) = 0;
cm(lenpos+2*round(lenneg/3)+2:lenpos+lenneg+1,2) = 0.4:-0.4/(lenneg-2*round(lenneg/3)-1):0;
cm(lenpos+2*round(lenneg/3)+2:lenpos+lenneg+1,3) = 0.9:-0.3/(lenneg-2*round(lenneg/3)-1):0.6;



% cm(1:7,1) = 0.3:0.1:0.9;
% cm(8:16,1) = ones(9,1); cm(8:16,2) = 0:0.1:0.8; cm(8:16,3) = 0:0.1:0.8;
% cm(17:23,1) = 0.8:-(0.8/6):0; cm(17:23,2) = ones(7,1); cm(17:23,3) = ones(7,1);
% cm(23:32,2) = 0.9:-0.1:0; cm(23:32,3) = [1; 1; 1; 1; 1; 1; 0.9; 0.8; 0.7; 0.6];

cm = flipud(cm);