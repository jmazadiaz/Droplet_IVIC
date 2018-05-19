%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   
%       objectplus.m
%   Input
%       bw = Imagen de estudio (solo para el tamaño)
%       PixelList = Lista de pixeles a modificar
%       valor = Cantidad de incremento del pixe entre max y min
%       max = Maximo valor del pixel escogido
%       min = Minomo valor del pixel escogido
%   Output
%      figure = Imagen modificada con los PixelIdxList modificada
%
% Esta función la uso para crear una imagen  donde, partiendo de una imagen
% en escala de grises y una lista de pixel a tratar, se modifica el valor
% de cada pixel de la imagen, contenido en la lista, si está entre los
% valores maximos y mínimos, incrementandolo su valor, sumandole la
% cantidad 'valor'.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function figure = objectplus(img ,PixelList, valor, max, min)
    bwf=false(size(img));
    bwf(PixelList) = true;
    [endi_ endj_] = size(img);
   
    for i_ = 1:endi_
        for j_ = 1:endj_
            if bwf(i_,j_) == 1
                if  img(i_,j_)< max  & img(i_,j_)> min
                    figure(i_,j_) = img(i_,j_) + valor;
                end
            else
                figure(i_,j_) = img(i_,j_);
            end
            
        end
    end
end

