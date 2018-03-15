%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Scrip para crear un fondo para hacer una matriz de diferencia y aplicarlo
% a cada cuadro y poder crear una matriz de diferencia y aplicarla a cada
% cuadro
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%   Variables de entrada   %%%%%%%%%%%%%

size_i = 258; % Largo de la matriz  2
size_j = 258; % Ancho de la matriz -2

max_intensity = 220; % Revisar en histograma para saber cual es el valor mas alto de la imagen
min_intensity = 210; % Es 5 o 10 puntos por debajo del 


%%%%%%%%%%%%%%%%%%%%%%%%%%%

backgrond = uint8(randi([min_intensity,max_intensity],size_i,size_j));

mask = fspecial('gaussian',25);
im = imfilter(backgrond,mask);

fondo_antes = backgrond(2:257,2:257);
fondo_gauss = im(2:257,2:257);

%%%%%%%%%%%%%%    Restamos a la imagen 
for in_i = 1:256
    for in_j = 1:256
        temp=fondo_gauss(in_i,in_j) -i(in_i,in_j);
        
        if temp < 90
            im(in_i,in_j) = temp +im(in_i,in_j);
        else
            im(in_i,in_j) = i(in_i,in_j);
        end
        
    end
end




%%%%% Muestra las imagenes sin y con fultro %%%%%%





subplot(2,2,1);
imshow(im);
title('imagen Sin modificar') 
subplot(2,2,2);
imhist(im);
title('Hist I S/m');
subplot(2,2,3);
imshow(i);
title(strcat('filtro : ',filtro));
subplot(2,2,4);
imhist(i);
title(strcat('hist filtro: ', filtro));