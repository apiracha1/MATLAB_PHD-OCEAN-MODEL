
all_TS_WM = findobj(h,'type','Surface');
Form_Data = get (all_TS_WM,'CData');

[latitude, longitude, aratio] = colTSreg_v2(ocean);
ind_form = find(~isnan(Form_Data));

% latitude = -10:54;
% longitude = -90.5:14.5;
% latitude = -40:-1;
% longitude = -60.5:29.5;
% latitude = 5:59;
% longitude = 119:239;
%     latitude = -40:-5.5;
%     longitude = 109:309;

[row1,col1] = find(Form_Data == Form_Data(min(ind_form)));
plotm(latitude(row1(1)),longitude(col1(1)),'ro')

[row2,col2] = find(Form_Data == Form_Data(max(ind_form)));
plotm(latitude(row2(1)),longitude(col2(1)),'ro')

Form_Data1 =Form_Data';
ind_form = find(~isnan(Form_Data1));

[col3,row3] = find(Form_Data == Form_Data1(min(ind_form)));
plotm(latitude(col3(1)),longitude(row3(1)),'ro')

[col4,row4] = find(Form_Data == Form_Data1(max(ind_form)));
plotm(latitude(col4(1)),longitude(row4(1)),'go')


plotm([latitude(row1(1)) latitude(col3(1))],[longitude(col1(1)) longitude(row3(1))])
plotm([latitude(row2(1)) latitude(col4(1))],[longitude(col2(1)) longitude(row4(1))])
plotm([latitude(row1(1)) latitude(col4(1))],[longitude(col1(1)) longitude(row4(1))])
plotm([latitude(row2(1)) latitude(col3(1))],[longitude(col2(1)) longitude(row3(1))])
textm((latitude(row1(1))+latitude(row2(1)))/2,(longitude(col1(1))+longitude(col2(1)))/2,{'37 -> 37.5','19.9 -> 23.1'},'color','g')


t = size (a);


a = xlsread('satellite vs literature water masses (all products).xlsx',tframe);


xlswrite('satellite vs literature water masses (all products).xlsx',{latitude(row(1)),longitude(col(1)),'->',latitude(row1(1)),longitude(col1(1))},tframe,['I',num2str(t(1)-1)])


