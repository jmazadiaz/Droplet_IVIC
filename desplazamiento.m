%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       desplazamiento.m
%   Input
%       drop = Imagen del objeto a encontrar su centroide
%       observador = Punto de referencia(observador) para medir desplazamiento
%   Output
%       centre_ = centro del objeto en la imagen(imagen con un solo objeto)
%       des = Desplazamiento con respecto a 'centre'
%       diameters = diametro del objeto en caso se ser circular
%
% Esta función mide el desplazamiento del centro de un objeto respecto a un
% observador posicionado en el punto 'centre_'
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function desplaza = desplazamiento(drop,observador)

stats_ = regionprops('table',drop,'Centroid','MajorAxisLength','MinorAxisLength');%Calcula regiones con pizeles blancos
[len_,~]=size(stats_);

centro = stats_.Centroid(1,:);

    if len_>1
        fprintf('Existe mas de dos contornos en la imagen de entrada')
    else
        diameters = mean([stats_.MajorAxisLength(1) stats_.MinorAxisLength(1)],2);% M = mean(A,dim) dim = (1 since top to down matrix), =(2 since left to right)
    end
    
    dx = centro(1)-observador(1);
    dy = centro(2)-observador(2);
    
    des = sqrt((dx)^2 +(dy)^2);
    
     desplaza = struct('centro',centro,'diametros',diameters ,'Dx',dx,'Dy',dy,'Des',des );

end