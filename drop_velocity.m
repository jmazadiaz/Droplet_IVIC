nombre='D:\Droplets Video\glicerina\48 cm\AVI\IMG\img-g48-1\'; %Recore el diretorio
ruta=strcat(nombre,'*.jpg');%concatena el directorio con la extesion de los archivos
lee_archivos = dir(ruta); %el formato de imagen puede ser modificado.

% [end_,~]=size(lee_archivos);

ind_ = 189;

archivo = lee_archivos(ind_).name;
i=imread(strcat(nombre,archivo));
i2=rgb2gray(i);

img_cI_ = i2(1:107,129:length(i));%   Cuadrante I de la imagen  

bw_ini_=binarizacion(img_cI_,70);
bw_inv_ = imcomplement(bw_ini_);
% 
% center = [107,1]

imshow(bw_inv_)

hold on
viscircles(center,);
plot(center(1),center(2), 'b*')
hold off
