%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       line_radial.m
%   Input
%       centro =  Centro del la circunferencia
%       radio = Radio de la circunferencia
%       cuadrante = 1 para la parte superiro, 2 para la inferior del circulo
%   Output
%       xy_ = Coordenadas de las linas radiales de una circunferencia
%
% Esta función calculas los indices de las líneas radiales de una
% circunferencias de radio 'radio' y centro 'centro', usando los argoritmos
% de Bresenham para el circulo y la línea.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [lxy p_line] = line_radial(centro,radio,octante)

     cxy_ = circulo_bresenham(radio);
     endi_ = length(cxy_);
     
     if octante == 1
         temp_ = vertcat(cxy_.octante1);
         temp_=[temp_(:,1)+centro(1) temp_(:,2)+centro(2)];
     elseif octante == 3
         temp_ =vertcat(cxy_(endi_:-1:1).octante2);
         temp_=[temp_(:,1)+centro(1) temp_(:,2)+centro(2)];
     elseif octante == 3
         temp_ = vertcat(cxy_.octante3);
         temp_=[temp_(:,1)+centro(1) temp_(:,2)+centro(2)];
      elseif octante == 4
         temp_ =vertcat(cxy_(endi_:-1:1).octante4);
         temp_=[temp_(:,1)+centro(1) temp_(:,2)+centro(2)];
     elseif octante == 5
         temp_ = vertcat(cxy_.octante5);
         temp_=[temp_(:,1)+centro(1) temp_(:,2)+centro(2)];
     elseif octante == 6
         temp_ =vertcat(cxy_(endi_:-1:1).octante6);
         temp_=[temp_(:,1)+centro(1) temp_(:,2)+centro(2)];
     elseif octante == 7
         temp_ = vertcat(cxy_.octante7);
         temp_=[temp_(:,1)+centro(1) temp_(:,2)+centro(2)];
     elseif octante == 8
        temp_ =vertcat(cxy_(endi_:-1:1).octante8);
        temp_=[temp_(:,1)+centro(1) temp_(:,2)+centro(2)];
     else
        disp('Solo{ 1) Parte superior de la circunferencia ó 2) Parte inferior de la circunferencia')
     end
          
     lxy (:,1:3) = [centro(1) centro(2) 0]; 
          
     for i_ = 1: endi_ 
         t_xy_(:,1:2) = linea_bresenham(centro(1),centro(2),temp_(i_,1),temp_(i_,2));
         t_xy_(:,3) = i_;
         lxy = vertcat(lxy,t_xy_);   
         clear t_xy_
     end
       p_line =   temp_;
     clear cxy_  endi_ t_xy_
              
end
