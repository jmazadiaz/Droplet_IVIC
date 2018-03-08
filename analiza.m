nombre='D:\Droplets Video\glicerina\48 cm\AVI\IMG\img-g48-1\'; %Recore el diretorio
ruta=strcat(nombre,'*.jpg');%concatena el directorio con la extesion de los archivos
lee_archivos = dir(ruta); %el formato de imagen puede ser modificado.


for(i_:since_,end_)

archivo = lee_archivos(i_).name;
I=imread(strcat(nombre,archivo));
I2=rgb2gray(I);

%%%%        Fase de mejoramiento de imagen                                              

% background = imopen(I2,strel('disk',15));
% figure
% surf(double(background(1:end,1:end))),zlim([0 255]);
% set(gca,'ydir','reverse');
% I2 = I2 - background;
% imshow(I2);..

%%%%           Por ahora solo binarizaré todo debajo de 70 es cero                      %%%%

 bw1=binarizacion(I2,70);
 bw3 = imcomplement(bw1);
 
%  imshow(bw3)

%%%%    Parte de separación de las figuras en blanco

 cc=bwconncomp(bw3, 8);
 cc.NumObjects

% drop=false(size(bw3));
% drop(cc.PixelIdxList{1}) = true;
% imshow(drop)

drop = object(bw3,cc.PixelIdxList{1});

%%%%           cambiada por función                      %%%%

% % stats = regionprops('table',drop,'Area','Perimeter','Centroid','MajorAxisLength','MinorAxisLength');
% % 
% % imshow(bw3);
% % title('Image with Circles');

%%%%    Calcula el centroide y el radio de un área data en BW   %%%% 

% stats = regionprops('table',drop,'Centroid','MajorAxisLength','MinorAxisLength');
% centers = stats.Centroid(1,:);
% diameters = mean([stats.MajorAxisLength(1) stats.MinorAxisLength(1)],2);% M = mean(A,dim) dim = (1 since top to down matrix), =(2 since left to right)
% radii = diameters/2;

[area,perimeter]= area(bw3);
[center,radii]= centre(bw3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% imshow(bw3)
hold on
viscircles(center,radii);
plot(center(:,1),center(:,2), 'b*')
hold off



end