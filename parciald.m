%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       parciald.m
%   Input
%       f = Es una copia de una linea de pixel desde el centro al un punto de la circunferencia de Bresenham      
%   Output
%       p2 = Es el resulta de aplicar la parcial segunda a la línea de pixel  
%
% Aplicando la ecuacion de la lámina 5 del tema 3-2 del curso de topología
% de imagenes digitales { d2f/dx2 = f(x+1)+f(x-1) - 2f(x) } para determinar cambios
% de contraste en imagenes en escala de grisis. El objetico es identificar
% el punto donde se encuentra el líquido en la linea de pixel.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function p2 = partiald(f)
    for i_ = 2:length(f)-1
        p2(i_) = f(i_+1)+f(i_-1)-(2*f(i_));
end