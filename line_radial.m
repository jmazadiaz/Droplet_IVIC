%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       line_radial
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

function xy = line_radial(centro,radio,cuadrante)

     if cuadrante == 1
         ind_ = 1;          jnd_ = 2;
     elseif cuadrante == 2
         ind_ = 3;          jnd_ = 4;
     else
        disp('Solo{ 1) Parte superior de la circunferencia ó 2) Parte inferior de la circunferencia')
     end
     
     cxy = circulo_bresenham(radio);
     
     temp = [cxy(:,ind_)+centro(1) cxy(:,jnd_)+centro(2)];
     
     [endi_ ~]=size(cxy);
     
     xy (:,1:3) = [centro(1) centro(2) 0]; 
          
     for i_ = 1: endi_ 
          
     %%
     t_xy(:,1:2) = linea_bresenham(centro(1),centro(2),temp(i_,1),temp(i_,2));
     t_xy(:,3) = i_;
     %%
          
     xy = vertcat(xy,t_xy);   
 
     clear t_xy
     
     end
    
              
end
