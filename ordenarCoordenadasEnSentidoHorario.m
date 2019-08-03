function [X, Y] = ordenarCoordenadasEnSentidoHorario( X, Y )

%Esta función ordena la matriz [X,Y] en el siguiente ordes: [1,1]:
%coordenadas X e Y de la esquina superior izquierda, [2,2]: coordenadas de
%la esquina superior derecha, [3,3]: coordenadas de la esquina inferior
%derecha, [4,4]: coordenadas de la esquina inferior izquierda

%Los primeros dos valores más grandes de Y serán los 2 bordes superiores
%vertices_superiores_Y = ordenarCoordenadasDeAcuerdoAX(Y);
vertices_superiores_Y = sort(Y);%Ordeno ascendentemente los valores de Y
   
%Ordeno ahora los valores de X de acuerdo a la nueva posición de los
%valores de los datos del vector Y
    for i=1:4
        for j=1:4
            if vertices_superiores_Y(i) == Y(j)
                vertices_superiores_X(i) = X(j);
            end
        end
    end
   
   %Transpongo y convierto el vector con los x ordenados a un vector columna
   vertices_superiores_X = vertices_superiores_X'; 
   %Reemplazo los vectores X e Y originales con los vectores ordenados
   X = vertices_superiores_X;
   Y = vertices_superiores_Y;

   % El mayor de los valores de x para los primeros 2 valores altos para el eje Y
   % pertenece a la esquina superior derecha
   % Esquinas superior izquierda y derecha identificadas
   %Si el valor de la posición dos es mayor al valor de la posición 1 del
   %vector X, entonces se intercambian los valores de dichas posiciónes,
   %tanto para X como para Y
   if X(1) > X(2)
       vertices_superiores_X(1) = X(2); 
       vertices_superiores_Y(1) = Y(2);        
       vertices_superiores_X(2) = X(1); 
       vertices_superiores_Y(2) = Y(1);         
   end
   
   %Actualizo nuevament los vectores de datos X e Y
   X = vertices_superiores_X;
   Y = vertices_superiores_Y;

% El mayor de los valores X para los últimos 2 valores altos para el eje Y
% pertenece a la esquina inferior derecha
   %Nuevamente se intercambian los valores en caso de ser necesario.
   if X(3) < X(4)
       vertices_superiores_X(3) = X(4); 
       vertices_superiores_Y(3) = Y(4);        
       vertices_superiores_X(4) = X(3); 
       vertices_superiores_Y(4) = Y(3);         
   end
   %Y se actualizan en los vectores X e Y
   X = vertices_superiores_X;
   Y = vertices_superiores_Y;
end