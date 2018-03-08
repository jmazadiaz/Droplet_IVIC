function [centre_i,centre_j,radii] = centre(drop)

stats = regionprops('table',drop,'Centroid','MajorAxisLength','MinorAxisLength','Perimeter');%Calcula regiones con pizeles blancos

ind_max=find(max(stats.Perimeter));% encuentra el indice de mayor perimetro

centre_i = stats.Centroid(ind_max,1);
centre_j = stats.Centroid(ind_max,2);
diameters = mean([stats.MajorAxisLength(ind_max) stats.MinorAxisLength(ind_max)],2);% M = mean(A,dim) dim = (1 since top to down matrix), =(2 since left to right)
radii = diameters/2;
end