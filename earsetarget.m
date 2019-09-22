%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       borratarget.m
%   Input
%       fig = Imagen con el target a borrar
%       target =  Px donde se marca el target
%       Incremento = Incremento en el valor del pixel
%   output
%       fig = Imagen modificada (Px(target) = + Incremento).     
%       bw_lim = Valor que m�s aparece en el target.
%
% Esta funci�n se encarga de recibir los indices de un objeto previamente
% identificado y un valor entero de incremento para hacer que los valores
% mas oscuros de los px contenidos en los indices del target, se realsen 
% para poder eliminarlos de una binarizaci�n en el resto de la imagen.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [fig ] = earsetarget(fig ,target)
    
    moda_ = double(mode(mode(fig,2))-1);
    
    for ind_ = 1:length(target)
        fig(target(ind_)) = uint8(random('Normal',moda_,.5));
    end
    fig (target) = imgaussfilt(fig(target),0.8);
end