%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       sortangle.mat
%   Input
%       vectores = Lista de vectores a calcular angulo
%       centro =  Origen del sistema de referencia
%   Output
%       angles_sort =  Estructura con magnitud, angulos y Vectores2
%       
% Permite Ordenar los angulos de mayor a menor, primero fijamos un eje de 
% coordenadas en el centro, luego canculamos los angulos entre el primer 
% punto, puede ser cualquiera, con el resto, el angulo resultante se ajusta
% dendiendo del cuadrante en donde se encuentre y por ultimo se devuelve la
% lista de los angulos ordenadas de menor a mayor
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function angles_sort = sortangle(vectores,centro)

    A1_ = vectores(1).PixelList(1:2)-centro ;                               % Se obtiene vector del primer punto con el ejer en el centro. 
    
    angles_sort(1) = struct(...                                             % Estructura de salida 
    'Magnitud1',norm(A1_),'Magnitud2',norm(A1_),...
    'Angulos1' ,acosd(A1_ / norm(A1_)),'Angulo2',acosd(A1_ / norm(A1_)),...
    'Angulo',0,'Vector2',vectores(1).PixelList(1:2), 'AngDif', 0);

for ind_angle_ = 2: length(vectores)
                                                                            
   t_A2_ = vectores(ind_angle_).PixelList(1:2)-centro;                      % Segundo vector del nuevo sistema de cooredenada
    
   [temp_mag_ ,temp_angle_]= ab2v( A1_ , t_A2_, false);                     % Calculo los angulos y magnitures de cada vector(ab2c sirve para 2 dimensiones)
   
   if A1_(2)<t_A2_(2)
       temp_angle_ = 360-temp_angle_;                                      % Ajuste del cuadrante al que pertenece
   end
   
   
   angles_sort(ind_angle_) = struct(...                                     % Add nueva fila a la estructura
  'Magnitud1',temp_mag_(1),'Magnitud2',temp_mag_(2),...
  'Angulos1' ,temp_angle_(1:2),'Angulo2',temp_angle_(3:4),...
  'Angulo',temp_angle_(5),'Vector2',vectores(ind_angle_).PixelList(1:2),...
  'AngDif', 0);    
            
clear  temp_mag_   temp_angel_  t_A2_  t_diff    
end
% Ordena la estructura a apartir de los angulos de menor a mayor
[~,index] = sortrows([angles_sort.Angulo; angles_sort.Magnitud2].');        
angles_sort = angles_sort(index);                                           
clear index
for ind_sort_ = 2: length(angles_sort)
   angles_sort(ind_sort_).AngDif = angles_sort(ind_sort_).Angulo...
                                - angles_sort(ind_sort_-1).Angulo;
end

end