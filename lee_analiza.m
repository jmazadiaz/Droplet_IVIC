

nombre='D:\Droplets Video\glicerina\48 cm\AVI\IMG\img-g48-1\'; %Recore el diretorio
ruta=strcat(nombre,'*.jpg');%concatena el directorio con la extesion de los archivos
lee_archivos = dir(ruta); %el formato de imagen puede ser modificado.

archivo = lee_archivos(179).name;
i=imread(strcat(nombre,archivo));
i2=rgb2gray(i);

%%%% variable filtro %%

% size_i = 258; % Largo de la matriz  2
% size_j = 258; % Ancho de la matriz -2
% 
% max_intensity = 210; % Revisar en histograma para saber cual es el valor mas alto de la imagen
% min_intensity = 200; % Es 5 o 10 puntos por debajo del 
% 
%%%%%%%%  Ejemplo de los granos

% background = imopen(i,strel('disk',15));
% figure
% surf(double(background(1:8:end,1:8:end))),zlim([0 255]);
% set(gca,'ydir','reverse');
% I2 = i + background;
% imshow(I2);

 bw1=binarizacion(i2,70);
 bw3 = imcomplement(bw1);
  
%   imshow(bw3)
 
%  imandhist(i,im,'log');
% 
% I3 = imadjust(I2);
% imshow(I3);

% bw = imbinarize(I3);

% threshold = graythresh(I3);
% bw=im2bw(I3,threshold);

% bw = bwareaopen(bw, 50);
% imshow(bw);
% 
% cc=bwconncomp(bw, 4);
% 
% cc.NumObjects
% 
% grain = false(size(bw));
% grain(cc.PixelIdxList{1}) = true;
% imshow(grain);
% 
% labeled = labelmatrix(cc);
% RGB_label = label2rgb(labeled, @spring, 'c', 'shuffle');
% imshow(RGB_label)
% 
% graindata = regionprops(cc, 'basic');
% graindata(1).Area
% grain_areas = [graindata.Area];
% [min_area, idx] = max(grain_areas)
% grain = false(size(bw));
% grain(cc.PixelIdxList{idx}) = true;
% imshow(grain);


%%%%    Segment Image Overlaying Mask and Contour on Original Image

% I=bw2;
% % imshow(I);
% sz=size(I)
% mask=false(sz);
% 
% mask(sz/2-25:sz/2+25,sz/2-25:sz/2+25)=true;
% % visboundaries(mask,'Color','b');
% bw = activecontour(I, mask, 200, 'edge');
% 
% visboundaries(mask,'Color','b');
% bw = activecontour(I, mask, 200, 'edge');
% imshow(bw);
%   

%%%%%%%%%%%%%%%








% background = imopen(i,strel('disk',10));
% backnega=negativo(background);
% imshow(backnega);
% % 
% I2=i+background*0.3;
% subplot(2,1,1)
% surf(double(I2(1:8:end,1:8:end))),zlim([0 255]);
% set(gca,'ydir','reverse');
% subplot(2,1,2)
%%%%%%%%%%%%%%%%%%
% imshow(I2)

%%%%% Binarizacion
% im=binarizacion(i,7);
%  imandhist(i,im,'log');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%




% filtro='gaussian';
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% mask = fspecial(filtro,25);
% im = imfilter(i,mask);

% backgrond = uint8(randi([min_intensity,max_intensity],size_i,size_j));

%%%%%%%%%%%%%%    Restamos a la imagen    %%% Funciono pero quiero intentar
%%%%%%%%%%%%%%    algo
% 
% mask = fspecial('gaussian',25);
% ext_fondo_gauss = imfilter(backgrond,mask);
% 
% fondo_antes = backgrond(2:257,2:257);
% fondo_gauss = ext_fondo_gauss(2:257,2:257);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% for in_i = 1:256
%     for in_j = 1:256
%         temp= fondo_gauss(in_i,in_j)-i(in_i,in_j) ;
%         
%         if temp < 80
%             
%             im(in_i,in_j) = temp +i(in_i,in_j);
%         else
%             im(in_i,in_j) = i(in_i,in_j);
%         end
%         
%     end
% end



%%%%% Muestra las imagenes sin y con fultro %%%%%%


% 
subplot(1,2,1);
imshow(i);
title('imagen Sin modificar') 
subplot(1,2,2);
imshow(bw3);
title('Hist I S/m');
% subplot(2,2,3);
% imshow(i);
% title(strcat('filtro : '));
% subplot(2,2,4);
% imhist(i);
% title(strcat('hist filtro: '));


% 
% subplot(2,2,1);
% imshow(i);
% title('imagen Sin modificar') 
% % subplot(2,2,2);
% % imhist(i);
% % title('Hist I S/m');
% % subplot(2,2,3);
% % imshow(im);
% % title(strcat('filtro : ',filtro));
% % subplot(2,2,4);
% % imhist(im);
% % title(strcat('hist filtro: ', filtro));