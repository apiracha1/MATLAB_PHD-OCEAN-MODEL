function find_pixel_color (fignum1,fignum2)
% %%------------------------Start of Header----------------------------------
%
% ROUTINE                    conv_to_cmap
% AUTHOR                     Aqeel Piracha
% MAIL                       apiracha@btinternet.com
% DATE                       November 15th 2017
% VERSION                    1.0
% PURPOSE                    finds weather pixels incorresponding mean and
%                            STD WM Form maps equate to each other, 
%                            an indication monte-carlo has been
%                            applied to each pixel
%                            
%
%
% INPUT
% fignum1,2                  figures of mean and std which are to have
%                            there pixels compared

h1 = figure(fignum1);
h2 = figure(fignum2);

% getting all surfaces on figure
all_Surface_1 = findobj(h1,'type','Surface');
all_Surface_2 = findobj(h2,'type','Surface');

% getting each surface first figure
first1 = all_Surface_1 (1);  
second1 = all_Surface_1 (2);
third1 = all_Surface_1 (3);

% getting each surface second figure
first2 = all_Surface_2 (1);  
second2 = all_Surface_2 (2);
third2 = all_Surface_2 (3);

% Finding each non NaN pixel surf1, fig.1
CData11 = get (first1,'CData');
Cdata11 = ~isnan (CData11);
first1 = CData11 (Cdata11);

% Finding each non NaN pixel surf2, fig.1
CData12 = get (second1,'CData');
Cdata12 = ~isnan (CData12);
second1 = CData12 (Cdata12);

% Finding each non NaN pixel surf3, fig.1
CData13 = get (third1,'CData');
Cdata13 = ~isnan (CData13);
third1 = CData13 (Cdata13);

%
% Finding each non NaN pixel surf1, fig.2
CData21 = get (first2,'CData');
Cdata21 = ~isnan (CData21);
first2 = CData21 (Cdata21);

% Finding each non NaN pixel surf2, fig.2
CData22 = get (second2,'CData');
Cdata22 = ~isnan (CData22);
second2 = CData22 (Cdata22);

% Finding each non NaN pixel surf3, fig.2
CData23 = get (third2,'CData');
Cdata23 = ~isnan (CData23);
third2 = CData23 (Cdata23);

% checking if mean and STD map = number of pixels for each month

if length (first1) == length (first2)
    fprintf ('pixels for MONTH 1 in agreement\n')
else
    fprintf ('pixels for MONTH 1 not in agreement\n')
end


if length (second1) == length (second2)
    fprintf ('pixels for MONTH 2 in agreement\n')
else
    fprintf ('pixels for MONTH 2 not in agreement\n')
end

if length (third1) == length (third2)
    fprintf ('pixels for MONTH 3 in agreement\n')
else
    fprintf ('pixels for MONTH 3 not in agreement\n')
end

end