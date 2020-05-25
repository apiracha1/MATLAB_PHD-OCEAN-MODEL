function movingwindow(maxx,minx,xint,miny,maxy,sigma0,t,ttt)

num = sigma0(t) - 1000;

for i = num
subplot(3,2,[1 3])
r = rectangle('position', [num -400  xint 1200]);
   subplot(3,2,5)
    c = rectangle('position', [num 0 xint 800]);
drawnow
pause(0.5)
delete(r)    
delete (c)
end




% minx = 23.8;
% for i = minx:xint:maxx;
%     subplot(3,2,[1 3])
%     r = rectangle('position', [(i) miny  xint maxy]);
%     subplot(3,2,5)
%     c = rectangle('position', [(i) 0 xint 400]);
%     % xlim([minx maxx])
%     % set(gca,'xtick',(minx:1:maxx))
%     drawnow
%     pause (0.5)
%     delete (r)
% delete (c)
% end
% 


end
subplot(3,2,[1 3])
mblu = [0 0.4 1];
dred = [0.8 0 0];
ora = [1 0.5 0];
hold on
plot(sigma0-1000,Frho_all_1st(1,:),'color',mblu,'linewidth',1.5);
hold on;
plot(sigma0-1000,Frho_all_st(3,:),'color',dred,'linewidth',1.5)

    
if n_loop==3
plot(sigma0-1000,Frho_all_st(2,:),'color',ora,'linewidth',1.5)
end
% %errorbar plot
x1 = sigma0-1000;
y1 = Frho_all(1,:);
e1 = Frho_all_std(1,:);
(errorbar(x1,y1,e1,'color',mblu,'linewidth',0.5));
plot(20:30,zeros(size(20:30)),'k-')

subplot(3,2,5)
plot((sigma0(36:end))-1000,tindind(1:46),'k-')
xlim([sigma0(2)-1000 sigma0(end)-1000])


subplot(1,2,2)

