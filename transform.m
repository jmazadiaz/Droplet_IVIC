%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    transform
%   Input 
%       imgFix_FNames = Nombre de la imagen fija
%       imgMov_FNames = Nombre de la imagen movida
%       extra =  Unos pixeles extra para agrandar la imagen resultante (negro)
%
%   Output
%       P2 =  imagen movida transformada
%       Tform = matris de transformación de ambas imagenes
%
% Detecta los puntos de las esquinas exteriores de un tablero de ajedrez
% pintado en dos imagenes de cuadriculas, vistas perpendicularmente(fix) y 
% con cierto ángulo(mov), para generar el patron de transformación de las 
% imagenes y retornar tanto el patron de transformación y la imagen movida 
% transformada. 
%
%   Usa " forma.m "
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [P2 Tform]  = transform(imgFix_FNames,imgMov_FNames,extra)

imagen_mov=imread(imgMov_FNames);
imagen_fix=imread(imgFix_FNames);

    [iF_Points, iD_boardSize, ~] = detectCheckerboardPoints(imgFix_FNames);
    [iM_Points, ~ , ~] = detectCheckerboardPoints(imgMov_FNames);

    iM_p = esquinas(iM_Points);
    iF_p = esquinas(iF_Points);

    xmin = min(iF_p(:,1))-extra;
    xmax = max(iF_p(:,1))+extra;

    ymin = min(iF_p(:,2))-extra;
    ymax = max(iF_p(:,2))+extra;

Tform = forma(iF_p,iM_p);

P2=imtransform(imagen_mov,Tform,'XData',[xmin xmax],'YData',[ymin ymax]);

clear xmin xmax ymin ymax  imagen_fix iF_Points...
      iM_Points iM_p iF_p 

end