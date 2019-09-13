%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       ab2v.mat
%   input
%       TabDrop = Tabla de datos de Dimension y escala.
%   output
%       VelCaida = Estructura con TabDrop y las velocidad, aceleracion y
%                  sus respectivos errores.
%       Data     = Tabla con Tiempo, Distancia, Velocidad y sus errores.
%
%   Calcula las velocidades promedios a partir de los 43 puntos extraidos
%   de los 10 videos de cada altura, cada grupo se ajusta y con la escala
%   se calcula la velocidad física con su respectivo error, tambien se
%   calcula la aceleración, pero por el corto lapso de observacion su error
%   es muy grande.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [VelCaida, Data ] = VelCaida(TabDrop)

medidas_ = height(TabDrop)/10;                                              % Cantidade de medidas (Esto es muy especifico para este caso, 
%%                  Medidas                                                 % modificar para generalizar)
for j_ = 1:10
   for i_ = 1:medidas_
    za_(i_,j_) = TabDrop.Tiempo(i_+(43*(j_-1)));                            % Ordena medidas de 43 en 43 medidas (Es decir para falicitar el 
    ya_(i_,j_) = TabDrop.Centro(i_+(43*(j_-1)),2);                          % calculo del ajuste  de cada variable)
    xa_(i_,j_) = TabDrop.Centro(i_+(43*(j_-1)),1);
    scal_(i_,j_) = TabDrop.Escala(i_+(43*(j_-1)));
    escl_(i_,j_) = TabDrop.errEscala(i_+(43*(j_-1)));
    diaPx_(i_,j_) = TabDrop.DiametroPx(i_+(43*(j_-1)));
    edpx_(i_,j_) = TabDrop.errDia(i_+(43*(j_-1)));
    if i_ >= 2
        vel_(i_,j_) = norm(TabDrop(i_,:).Centro-TabDrop(i_-1,:).Centro)...  % Calculo de las velocidades a partir de la coordenada del centro
                       /(za_(i_,j_)-za_(i_-1,j_));
    else
        vel_(i_,j_) = 0;
    end
   end
end
clear j_ i_
%%                  Videos
for j_ =1 :10                                                               
    fitResXT_(j_,:) = polyfit(za_(:,j_),ya_(:,j_),1);                       % Ajusto linealmnete los datos de los cambio de altura durante cada caida
    fitResVT_(j_,:) = polyfit(za_(:,j_),vel_(:,j_),1);                      % Ajusto linealmente los datos de los cambio de velocudad durante cada caida
end
clear j_

stdYa_ = std(ya_,0,2);                   stdVel_ = std(vel_,0,2);           % Desviación estandar de las varaibles (DATA)
FitVel_ = mean(fitResXT_,1);             FitAcc_ = mean(fitResVT_,1);       % Promedio el valor de juste de los diez video
Mscla_ = mean(mean(scal_,1));            Mescla_ = mean(mean(escl_,1));     % Promedio del valor de escala, para convertir de Px a mm
MerrPX_ = mean(mean(edpx_));                                                % Promedio del error del valor de escala.

FVel_ = polyval(FitVel_,za_(:,1));       FAcc_ = polyval(FitAcc_,za_(:,1)); % Curva de ajuste de los datos      Velocidad y aceleracion  

T = za_(:,1);       Altura = Mscla_*FVel_;      Velocidad = Mscla_*FAcc_;   % Datos con dimensiones físicas (DATA)    

ea_ =  5400*errVel+(Velocidad./(T*5400)); 
errVel (1:43)= mean(MerrPX_*Mscla_);      errAcc(1:43) = mean(ea_(2:end));  % Error de los datos (DATA)

for j_ = 1:10                                                               % Estructura de salida de los datos
 VelCaida(j_) = struct('Tiempo',T,'Escala',scal_(:,j_)...
              ,'errEscala',escl_(:,j_),'DiametroPx',diaPx_(:,j_)...
              ,'ErrDia',edpx_(:,j_),'Centro',[xa_(:,j_) , ya_(:,j_)]...
              ,'FitYba',fitResXT_(j_,1:2), 'Velocidad',vel_ (:,j_)...
              ,'FitVelba',fitResVT_(j_,1:2));
end

Data = table(T, Altura, errVel' , Velocidad, errAcc' ,'VariableNames'...    % Tabla de datos de salida
            ,{'Tiempo' 'Altura' 'errAlt' 'Velocidad' 'errVel'});

end


