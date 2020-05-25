function [ax,h]=subtitle(text)
%%---------------------------Start of Header-------------------------------
%Centers a title over a group of subplots.
%Returns a handle to the title and the handle to an axis.
% [ax,h]=subtitle(text)
%           returns handles to both the axis and the title.
% ax=subtitle(text)
%           returns a handle to the axis only.
%%-----------------------------End of Header-------------------------------
% ax=axes('Units','Normal','Position',[.075 .075 .85 .85],'Visible','off');
% ax=axes('Units','Normal','Position',[.085 .075 .85 .9],'Visible','off');
ax=axes('Units','Normal','Position',[.085 .075 .85 .89],'Visible','off');
set(get(ax,'Title'),'Visible','on')
% title(text);
title(text,'fontsize',10)
if (nargout < 2)
    return
end
h=get(ax,'Title');
end