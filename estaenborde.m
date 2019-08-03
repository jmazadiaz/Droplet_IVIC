%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    estaenborde.m
%   Input 
%       imagen = Imagen a evaluar
%   Output
%       x = Respuesta a la pregunta �Hay algo en el borde?
%
% La funci�n recibe la imagen, encuentra el umbral de grises, binariza la
% imagen seg�n este umbral, aplica un elemento estructurante en forma de
% disco de radio 1, erociona la imagen con este elemento, seguido una
% reconstruccion con este elemento y por ultimo limpia el borde. Si alguna
% imagen esta en el borde la borrar�, Si algo est� en el borde de la imagen
% el valor de x ser� cierto.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function x = estaenborde(imagen,bw)

    if bw == false
    umbral_img_ = graythresh(imagen);
    bw_ =im2bw(imagen, umbral_img_);
    img_BWMask_ = imcomplement(bw_);
    elseif bw == true
        img_BWMask_ = imagen;
    end

    ele_estructurante_ = strel('disk',1);
    
    img_BWMark_ = imerode(img_BWMask_,ele_estructurante_);
    img_Rcnst_=imreconstruct(img_BWMark_,img_BWMask_);
    img_BWE_limBorde_ = imclearborder(img_Rcnst_);
    
    x = max(max(img_BWE_limBorde_))== false;
    
    % figure
%     imshow([img_BWMask_,img_BWE_limBorde_,])
%     title('Eliminaci�n de objetos del borde por reconstrucci�n geod�sica (BW)');

end