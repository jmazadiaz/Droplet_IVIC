function [centre_i,centre_j,des, diameters] = desplazamiento(drop,centre)

stats = regionprops('table',drop,'Centroid','MajorAxisLength','MinorAxisLength');%Calcula regiones con pizeles blancos
[len_,~]=size(stats);

centre_i = stats.Centroid(1,1);
centre_j = stats.Centroid(1,2);
if len_>1
    fprintf('Existe mas de dos contornos en la imagen de entrada')
else
diameters = mean([stats.MajorAxisLength(1) stats.MinorAxisLength(1)],2);% M = mean(A,dim) dim = (1 since top to down matrix), =(2 since left to right)
end
des = sqrt(abs((centre_i-centre(1)).^2 +(centre_j-centre(2).^2)));

end