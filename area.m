function [mm_x_plx2,mm_x_plx,perimeter] = area(drop)
a_=6.875533829;% Es el área del target en mm^2
stats = regionprops('table',drop,'Area','Perimeter');%Calcula regiones con pizeles blancos
ind_max=find(max(stats.Perimeter));
mm_x_plx2 = a_/stats.Area(ind_max);
mm_x_plx = sqrt(mm_x_plx2);
perimeter = stats.Perimeter(ind_max)*mm_x_plx;

end