%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    forma
%   Input 
%       iF_p = Puntos en la imagen fija
%       iM_p = Los mismos puntos en la imagen movida
%
%   Output
%       Tform = Estructura que transforma las imágenes movida a fijas
%
% Usando la geometría proyectiva esta función haya la matris de
% transformación entre una magen fija y otra imagen movida, usando puntos
% en la imagen que se detectan pentando un cuadro de ajedrez en las
% cuadriculas del cuadrante.
%
%   Se usa en transform.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function Tform = forma(iF_p,iM_p)

    [XM YM] = ordenarCoordenadasEnSentidoHorario( iM_p(:,1), iM_p(:,2) );
    [XF YF] = ordenarCoordenadasEnSentidoHorario( iF_p(:,1), iF_p(:,2) );

        A=zeros(8,8);
        A(1,:)=[XM(1),YM(1),1,0,0,0,-1*XM(1)*XF(1),-1*YM(1)*XF(1)];
        A(2,:)=[0,0,0,XM(1),YM(1),1,-1*XM(1)*YF(1),-1*YM(1)*YF(1)];

        A(3,:)=[XM(2),YM(2),1,0,0,0,-1*XM(2)*XF(2),-1*YM(2)*XF(2)];
        A(4,:)=[0,0,0,XM(2),YM(2),1,-1*XM(2)*YF(2),-1*YM(2)*YF(2)];

        A(5,:)=[XM(3),YM(3),1,0,0,0,-1*XM(3)*XF(3),-1*YM(3)*XF(3)];
        A(6,:)=[0,0,0,XM(3),YM(3),1,-1*XM(3)*YF(3),-1*YM(3)*YF(3)];

        A(7,:)=[XM(4),YM(4),1,0,0,0,-1*XM(4)*XF(4),-1*YM(4)*XF(4)];
        A(8,:)=[0,0,0,XM(4),YM(4),1,-1*XM(4)*YF(4),-1*YM(4)*YF(4)];

        v=[XF(1);YF(1);XF(2);YF(2);XF(3);YF(3);XF(4);YF(4)];

    u=A\v;

    U=reshape([u;1],3,3)';

    Tform=maketform('projective',U');

clear A v u U
end