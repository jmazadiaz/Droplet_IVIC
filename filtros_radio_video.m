%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%iver%%%%%%     
%
%   filtros_radio_video.m                                                  
%   Imput
%       videos{#video, Instante}(fotograma).>fotos o px_final< 
%   Output
%       Imagen con bordes resaltados para hacer mejor la medida
%
%   Este script pretende conseguir un conjuto de filtrado que permita
%   suavizar el ruido de fondo para hacer una mejor medida del radio de
%   esparcimiento.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('videos/vid_g48.mat') 

i_ = 1;     j_ = 1;                                                             % Los indices del video e instante que quiero convertir

img = videos{i_, j_}(1).fotos;                                                  % copio temporalmente la imagen de video a una variable

 j = rangefilt(img);                                                            % Aplico un filtro Local range of image
 
 bwj = im2bw(j,0.2);                                                            % Conbierto en blanco y negro con rango de 0.2
 
 se = strel('line',10,0);                                                       % Creo un mascara lineal para operar luego
 erodebwj = imerode(bwj,se);                                                    % Aplico una eroci�n  con la mascara anterior 
 
 imshow(erodebwj)                                                               % muestro la imagen.
 
 
background = imclose(img,strel('disk',20));
I2 = img + background;
surf(I2)
figure
surf(background)
 



%% para el radio

hg = fspecial('gaussian',[2,7],0.6)
hl = fspecial('laplacian',0.6)


img_lap =  imfilter(foto_1_,hl,'replicate');

foto_img = [foto_1_ - 5*ilapla];
 
 