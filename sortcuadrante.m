%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       sortcuadrante.mat
%   input
%       t_angulos_ =  Lista con todos los angulos y puntos(salida angulo_ske)
%   output
%       IndC13 = Indices de los cuadrantes 1 y 3 (en diagonal) 
%       IndC24 = Indices de los cuadrantes 2 y 4 (diagonal opuesta 13)
%
%   Devuelve los indices de los angulos que estan dendro de la media mas
%   las desviación estandar para cada par de cuadrantes opuestos de una
%   lista de angulos.
%                       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [IndC13 , IndC24] = sortcuadrante(t_angulos_)
cont_C13_= 1;           cont_C24_ = 1;
for i_ang_ = 1:length(t_angulos_)

if 0<=t_angulos_{i_ang_,4} & t_angulos_{i_ang_,4}<=90
    C13_(cont_C13_,1:2) = [t_angulos_{i_ang_,4} ; i_ang_];
    cont_C13_ = cont_C13_+1;
    
elseif 90<=t_angulos_{i_ang_,4} & t_angulos_{i_ang_,4}<=180
    C24_(cont_C24_ ,1:2) = [t_angulos_{i_ang_,4} ; i_ang_];
    cont_C24_ = cont_C24_ +1;
    
elseif 180<=t_angulos_{i_ang_,4} & t_angulos_{i_ang_,4}<=270
    C13_ (cont_C13_,1:2) = [(t_angulos_{i_ang_,4} -180 ); i_ang_];
    cont_C13_ = cont_C13_+1;
    
elseif 270<=t_angulos_{i_ang_,4} & t_angulos_{i_ang_,4}<=360
    C24_ (cont_C24_ ,1:2) = [(t_angulos_{i_ang_,4} -180); i_ang_];
    cont_C24_ = cont_C24_ +1;
    
end

end
mc13_ = mean(C13_(:,1));          mc24_ = mean(C24_(:,1));
sc13_ = std(C13_(:,1));           sc24_ = mean(C24_(:,1));

C13 = find((mc13_-sc13_)<C13_(:,1) & C13_(:,1)<(mc13_+sc13_));
C24 = find((mc24_-sc24_)<C24_(:,1) & C24_(:,1)<(mc24_+sc24_));

IndC13(:,1)= C13_(C13,2);        IndC24(:,1)= C24_(C24,2);

clear C13         C13_          mc13_             sc13_            cont_C13_...  
      C24         C24_          mc24_             sc24_            cont_C24_ ...
      i_ang_
  
end