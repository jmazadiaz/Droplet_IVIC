%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       parcial.m
%   Input
%       f = Es una copia de una linea de pixel desde el centro al un punto de la circunferencia de Bresenham      
%   Output
%       p = Es el resulta de aplicar la parcial a la l�nea de pixel  
%
% Aplicando la ecuacion de la l�mina 5 del tema 3-2 del curso de topolog�a
% de imagenes digitales { df/dx = f(x+1) - f(x) } para determinar cambios
% de contraste en imagenes en escala de grisis. El objetico es identificar
% el punto donde se encuentra el l�quido en la linea de pixel.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function p = parcial(f)
    for i_ = 1:length(f)-1
       p(i_) = f(i_+1) - f(i_);
    end
end
