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
%	struct('target',target_,'p_target',p_target_,'valor',valor_,'max',max_,'min',min_,'moda',med_);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function fig = objectplus(img ,P_List)

    tlist_ = vertcat(P_List.target);
    bwt_=false(size(img));
    bwt_(tlist_) = true;
    img(P_List.p_target) = P_List.max;
    
    [endi_ endj_] = size(img);
    
    for i_ = 1:endi_
        for j_ = 1:endj_
            if bwt_(i_,j_) == 1
                if img(i_,j_)< P_List.max  & img(i_,j_)>= P_List.min
                    temp_ = (2*img(i_,j_) + P_List.valor)/2 ;
                    if temp_ <= 255
                    	fig(i_,j_) = temp_;
                    else
                        fig(i_,j_) = P_List.max + P_List.valor;
                    end
                end
            else
                fig(i_,j_) = img(i_,j_);
            end
            
        end
    end
    
    fig(P_List.p_target) = img(P_List.p_target);

end

