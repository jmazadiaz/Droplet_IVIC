%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       binarización
%   Input
%       I = Imagen a transformar
%       T = Valor maximo de transformación
%       inv = Seleciona el positivo o el inverso de la imagen
%   Output
%       bw = Imagen binarizada
%
%   A partir de una imagen en gris, convierte todo lo que es mayor a 'T' en
%   1 y lo que este menor a este malor en cero, en caso de querer el valor
%   el inverso de la imagen binarizada, el valor 'inv' deber ser true.
% 
%   En la versión R2015a no cuenta con una función parecida, Quiero en otra
%   oportunidad hacer una binarización haciendo que T sea una superficie
%   curva con los maximo y minimo en cada punto.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   


%%% Down LINE 1

function[bw]= binarizacion(I,T,inv)

  [m_,n_] = size (I);
  bw = ones(m_,n_);
  
    for i_=1:m_
        for j_ = 1:n_
             if(I(i_,j_)>T)
                 bw(i_,j_) = 1;
             else
                 bw(i_,j_) =0;
             end
        end
    end

    if inv == true
        bw = imcomplement(bw);
    end
    
%%% Down LINE 34

clear m_ n_ i_ j_

end

%LINE 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%funcion para binarizar una imagen

% function[bw]= binarizacion(I,T)
% % clc;clear;
% %I = imread('images/flowers.png');
% % im_entrada=rgb2gray(I);
%  im_entrada = I;
% 
% imshow(I);
% 
%   [m,n] = size (im_entrada);
%   im_salida = ones(m,n);
%   
% 
% for i=1:m
%     for j = 1:n
%          if(im_entrada(i,j)<T)
%              im_salida(i,j) = 1;
%          else
%              im_salida(i,j) =0;
%          end
%     end
% end
% % imshow(im_salida);
% % se = strel('disk',100);
% % im_cerrada= imclose(im_salida,se);
% % figure 
% % imshow(im_cerrada);
% % bw = bwreaopen(im_cerrada,30);
% % figure 
% % imshow(bw);
% bw=im_salida;
% end


%LINE 34
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% imshow(im_salida);
% se = strel('disk',100);
% im_cerrada= imclose(im_salida,se);
% figure 
% imshow(im_cerrada);
% bw = bwreaopen(im_cerrada,30);
% figure 
% imshow(bw);