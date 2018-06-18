%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    cortarimg.m
%   Input 
%       img = Imagen de la que se vá a recortar subimagen
%       vect = Vector de cuadrado p(1,1) y p(2,2) [x1,y1;x2,y2]
%   Output
%       f_img = Subimagen enmarcada por el rectangulo en vect
%
% Esta función hace un corte de un rectangulo contenido en vect(coordenadas 
% del Punto superior izquierdo y el punto inferior derecho)y lo devuelve en
% f_img.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function f_img = cortarimg(img,vect,rgb)
    ind_i_ = 1;
    ind_j_ = 1;
    if rgb == true
%     f_img = ones(vect(2,1)-vect(1,1)+1,vect(2,2)-vect(1,2)+1);
        for j_ = vect(1,1):vect(2,1)
            for i_ = vect(1,2):vect(2,2)
                f_img(ind_i_,ind_j_,1:3)= img(i_,j_,1:3);
                ind_i_ = ind_i_ + 1;
            end
            ind_j_ = ind_j_ + 1;
            ind_i_ = 1;
        end
    elseif rgb == false
        for j_ = vect(1,1):vect(2,1)
            for i_ = vect(1,2):vect(2,2)
                f_img(ind_i_,ind_j_,1)= img(i_,j_,1);
                ind_i_ = ind_i_ + 1;
            end
            ind_j_ = ind_j_ + 1;
            ind_i_ = 1;
        end
    end
        
end