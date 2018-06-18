%Script File: ShowPosition
% How to position the current figure window.
%
% Syntax: set(gcf,’position’,[a b L W])
%
% (a,b) = is the lower left corner
% L = the horizontal length of the window
% W = the vertical width of the window
%
% Different screens have different dimensions.
% A window that fits on one screen may not fit on another.
% Vary the lower left corner...

%%      No hace falta el for, solo define a y b ejecutas ser y listo

%%
% close
% figure
% shg
% L = 600;
% W = 400;
% for a = 50:100:350
% for b = 50:50:200
% set(gcf,'position',[a b L W])
% title(sprintf('[ a , b , L , W ] = [%1d , %1d , %1d , %1d]',a,b,L,W),'Fontsize',14)
% text(.3,.5,'Vary Lower Left Corner (a,b)','Fontsize',14)
% pause
% end
% end
% Vary the length and width of the figure...
%close
figure
shg
a = 10;
b = 10;
for L = 500:1000:1920
for W = 500:1000:1080
set(gcf,'position',[a b L W])
title(sprintf('[ a , b , L , W ] = [%1d , %1d , %1d , %1d]',a,b,L,W),'Fontsize',14)
text(.3,.5,'Vary Length and Width','Fontsize',14)
pause
end
end