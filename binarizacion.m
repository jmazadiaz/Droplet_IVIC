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

function[bw]= binarizacion(I,T)
% clc;clear;
%I = imread('images/flowers.png');
% im_entrada=rgb2gray(I);
 im_entrada = I;

% imshow(I);

  [m,n] = size (im_entrada);
  im_salida = ones(m,n);
  

for i=1:m
    for j = 1:n
         if(im_entrada(i,j)>T)
             im_salida(i,j) = 1;
         else
             im_salida(i,j) =0;
         end
    end
end
% imshow(im_salida);
% se = strel('disk',100);
% im_cerrada= imclose(im_salida,se);
% figure 
% imshow(im_cerrada);
% bw = bwreaopen(im_cerrada,30);
% figure 
% imshow(bw);
bw=im_salida;
end