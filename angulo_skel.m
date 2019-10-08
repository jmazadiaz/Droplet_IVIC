%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       angulo_skel.mat
%   input
%       puntos =  conjunto de puntos(ang_) para diferentes videos (vid_)
%       centros =  Centros para diferentes videos (vid_)
%   output
%       Angulos = Angulos de cada punto y un vector  ( 100, 0)
%
%   Calcula el angulo de los puntos y entre dos vectores en un sistema de 
%   referencia posicionado en cada centro, usando la función  ab2v.
%
%   Angulos(vid_,1) = vector 2 (punto)
%   Angulos(vid_,2) = Magnitud del vector 2
%   Angulos(vid_,3) = Angulos de cada componente (x,y) de Vector 2
%   Angulos(vid_,4) =  Angulo entrer Vector 2 y el vector (100, 0)
%                       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Angulos = angulo_skel(puntos,centros)
Angulos = cell(length(puntos),3);
for vid_ = 1:length(puntos)
    t_angulos_ = cell(length(puntos{vid_}),4);
    
    for ang_ = 1:length(puntos{vid_})
     v1=  [100   0];
     v2_= puntos{vid_}(ang_).Centroid-centros(vid_,:);
     [t_mag_, t_ang_] = ab2v(v1, v2_, false);
     
      if v1(2) > v2_(2)
       t_ang_ = 360- t_ang_;                                                % Ajuste del cuadrante al que pertenece
      end
     
     t_angulos_(ang_,1:4) = {puntos{vid_}(ang_).Centroid,t_mag_(2),t_ang_(3:4),t_ang_(5)};
     
clear    m      a       v2_  
    end
% Ordena los angulos de menor a mayor    
[~,index] = sortrows([t_angulos_{:,4}].');     
t_angulos_ = t_angulos_(index,:);                                            
clear index
%%
    [IndC13 , IndC24] = sortcuadrante(t_angulos_);
    Angulos(vid_,1:3) = {t_angulos_,IndC13,IndC24};
    
clear    t_angulos_
end
clear    ang_            ang_
end