%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       area.m
%   Input
%       drop =  imgen en blanco y negro de un objeto a medir
%       a_ = área del objeto en la unidad de preferencia
%   Output
%       mm_x_plx2 = mm por pixels cuadrados en el objeto
%       mm_x_plx = mm por pixels en el objeto 
%       perimeter = perimetro del objeto en la imagen en mm
%
% Calcula la relación px/mm con una imagen en blanco y negro de un objeto y
% su respectivo tamaño en milimetros
%
% a_=6.875533829;% Es el área del target en mm^2
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [mm_x_plx2,mm_x_plx,perimeter] = area(drop,a)

    stats_ = regionprops('table',drop,'Area','Perimeter');%Calcula regiones con pizeles blancos
    
    ind_max_=find(max(stats_.Perimeter));
    mm_x_plx2 = a/stats_.Area(ind_max_);
    mm_x_plx = sqrt(mm_x_plx2);
    perimeter = stats_.Perimeter(ind_max_)*mm_x_plx;
    
clear stats_ ind_max_
end