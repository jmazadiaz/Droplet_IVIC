%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       borratarget.m
%   Input
%       fig = Imagen con el target a borrar
%       target =  Px donde se marca el target
%       Incremento = Incremento en el valor del pixel
%   output
%       fig = Imagen modificada (Px(target) = + Incremento).     
%       bw_lim = Valor que más aparece en el target.
%
% Esta función se encarga de recibir los indices de un objeto previamente
% identificado y un valor entero de incremento para hacer que los valores
% mas oscuros de los px contenidos en los indices del target, se realsen 
% para poder eliminarlos de una binarización en el resto de la imagen.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [fig bw_lim] = borratarget(fig ,target, incremento)

    th_ = imhist(fig(target));
    pvalor_ = mode(fig(target));

    h_indi_ = sumhasta(th_,5);    % Retorna el valor maximo del 5% acumulado de los pexel.
    bw_lim = h_indi_ -2;

    ti_=1;
    for d_i_ = 1:length(target)
        if fig(target(d_i_))<=h_indi_
            ch_ind_(ti_) = target(d_i_);
            ti_ = ti_ +1;
        end
    end
    % ch_ind_ = find(figi2_(target_) <= h_indi_);

    fig(ch_ind_) = pvalor_ + incremento;
end