%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    transform
%   Input 
%       x1 , y1 =   Coordenadas (x,y) del punto 1 de la linea a trazar
%       x2 , y2 =   Coordenadas (x,y) del punto 2 de la linea a trazar
%   Outpu
%       point = Lista de puntos de la linea de Bresenham (i,X_,Y_)
%
% La linea de Bresenham es una linea descrita en un espacio discreto, tal
% espacio esta compuesto por un espacio mallado x,y  para el caso 2D, los
% puntos que arroja esta función son los pixel que tocaría una linea recta
% trazada entre p1 (x1,y1) y el p2 (x2,y2).
%
%   https://es.wikipedia.org/wiki/Algoritmo_de_Bresenham
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function point = linea_bresenham(x1,y1,x2,y2)

    dx_ = (x2-x1);      dy_ = (y2-y1);
    
    condY_ = false;
    condX_  = false;
    
     if abs(dy_) >= abs(dx_ ) % Condición límite para el bucle sec (4)
         B_ = y2;
         condY_ = true;
     else
         B_ = x2;
         condX_ = true;
     
     end
    
    %%   1)   Incrementos para las secciones con avance inclinado

    if dy_ >= 0
        IncYi_ = 1;
    else
        dy_= -dy_;
        IncYi_ = -1;
    end

    if dx_ >= 0
        IncXi_ = 1;
    else
        dx_ = -dx_;
        IncXi_ = -1;
    end

    %%  2)  Incrementos para las secciones con avance recto

    if dx_ >= dy_
        IncYr_ = 0;
        IncXr_ = IncXi_;
    else
        IncXr_ = 0;
        IncYr_ = IncYi_;

    % %     Cuando dy es mayor que dx, se incrementa para reutilizar el mismo bucle
    % % %    Ver octantces blancos en la imagen encima del códígo
    
        k_ = dx_;         dx_ = dy_;          dy_ = k_;
    end

    %%  3)  Inicializar valores y error

    X_ = x1;     Y_ = y1;

    avR_ = (2*dy_);     av_ = (avR_ - dx_);     avI_ = (av_ - dx_);

    %%  4)  Bucle para el trazado de las líneas
% 
     i_ = 1; %   Variable para guardar cada coordenada en cada bucle del While
    
%         
%     
%             A_ ~=  B_
    while X_ ~=  B_ && condX_ |  Y_ ~= B_ && condY_ 
        point (i_,1:2) = [X_ Y_];

        if av_ >= 0
            X_ = X_ + IncXi_;     Y_ = Y_ + IncYi_;     av_ = av_ + avI_;
        else
            X_ = X_ + IncXr_;     Y_ = Y_ + IncYr_;     av_ = av_ + avR_;
        end

        i_ = i_ + 1;
    end

    point (i_,1:2) = [x2 y2];
end
    
