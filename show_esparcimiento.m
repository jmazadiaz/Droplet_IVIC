clear
close all

fold_PC_ = 'partes';
f_PC_ = leedir(fold_PC_,'mat');

calcula = false;             show = true;                                   % Calcula solo una vez, cuando cambien los datos.


file = 'Varaibles_medidas/Esparcimiento/Vel_esparcimiento.mat';
fP_fluidos = 'Data_proce/parametros_fluidos.mat';

if show == true
    
    load(file)
    load(fP_fluidos)
    
for fluid = 1:4
 figure1=...  
 figure('Name',strcat('EspFluids -',num2str(TabVelRadial.altura(fluid)))...                      % Crea una ventana con la cadena de caracteres
                ,'NumberTitle','off')
 axes1 = axes('Parent',figure1);           
    
    for caso_ =fluid:4: height(TabVelRadial)
        tao_ = P_fluidos.Diametro(caso_)/P_fluidos.Velocidad(caso_); 
        plot(axes1,TabVelRadial.Tiempo{caso_,1}./tao_,TabVelRadial.Diametro{caso_,1}./TabVelRadial.DiaGota(caso_));
        legend_{(caso_-fluid)/4+1} = strcat(TabVelRadial.Caso{caso_}(1:3),':We = ',num2str(rweber (P_fluidos,TabVelRadial.Caso{caso_})));
        hold on
    end
    title(strcat('Esparcimeinto : Fluidos -'...                      % Crea una ventana con la cadena de caracteres
                 ,num2str(TabVelRadial.altura(fluid))))
     xlabel('Tiempo (s)/Tiempo*(s)');          ylabel('Diametro (mm)/Diametro de gota(mm)');
     
     ylim(axes1,[0 34]);                  % Limita el eje y
     xlim(axes1,[0 3.7]);                  %Limita el eje x

     l1 = legend(legend_{1},legend_{2},legend_{3},'location','best');
     title(l1,'D.Esparcimiento')
     clear l1 caso_ axes1 figure1
end



for altu_ = 1:3
 figure2=...  
 figure('Name',strcat('EspAltura -',TabVelRadial.Caso{altu_*4}(1:3))...                      % Crea una ventana con la cadena de caracteres
                ,'NumberTitle','off')
 axes2 = axes('Parent',figure2);           
    
    for caso_ = 1+4*(altu_-1):4*altu_
        tao_ = P_fluidos.Diametro(caso_)/P_fluidos.Velocidad(caso_); 
        plot(axes2,TabVelRadial.Tiempo{caso_,1}./tao_...
             ,TabVelRadial.Diametro{caso_,1}./TabVelRadial.DiaGota(caso_));
        legend_{caso_-4*(altu_-1)} = strcat(TabVelRadial.Caso{caso_}(4:5),':We = ',num2str(rweber (P_fluidos,TabVelRadial.Caso{caso_})));
        hold on
    end
    title(strcat('Esparcimeinto : Fluidos -'...                      % Crea una ventana con la cadena de caracteres
                 ,TabVelRadial.Caso{altu_*4}(1:3)))
     xlabel('Tiempo (s)/Tiempo*(s)');          ylabel('Diametro (mm)/Diametro de gota(mm)');
     
     ylim(axes2,[0 34]);                  % Limita el eje y
     xlim(axes2,[0 3.7]);                  %Limita el eje x

     l2 = legend(legend_{1},legend_{2},legend_{3}',legend_{4},'location','best');
     title(l2,'D.Esparcimiento')
     clear l2 caso_ axes2 figure2
end


figure3=...  
 figure('Name','Esparcimiento','NumberTitle','off')                      % Crea una ventana con la cadena de caracteres
                
 axes3 = axes('Parent',figure3);           
    
    for caso_ = 1:height(TabVelRadial)
        tao_ = P_fluidos.Diametro(caso_)/P_fluidos.Velocidad(caso_); 
        plot(axes3,TabVelRadial.Tiempo{caso_,1}./tao_...
             ,TabVelRadial.Diametro{caso_,1}./TabVelRadial.DiaGota(caso_));
        legend_{caso_} = strcat(TabVelRadial.Caso{caso_}(4:5),':We = ',num2str(rweber (P_fluidos,TabVelRadial.Caso{caso_})));
        hold on
    end
    title(strcat('Esparcimeinto : Fluidos -'...                      % Crea una ventana con la cadena de caracteres
                 ,TabVelRadial.Caso{altu_*4}(1:3)))
     xlabel('Tiempo (s)/Tiempo*(s)');          ylabel('Diametro (mm)/Diametro de gota(mm)');
     
     ylim(axes3,[0 34]);                  % Limita el eje y
     xlim(axes3,[0 3.7]);                  %Limita el eje x

     l3 = legend(legend_{1},legend_{2},legend_{3}',legend_{4},legend_{5},legend_{6},legend_{7},legend_{8},legend_{9},legend_{10},legend_{11},legend_{12},'location','best');
     title(l3,'D.Esparcimiento')
     clear l3 caso_ axes3 figure3

%

elseif calcula == true

escala_=0.028567337278107;
dscala_ = 0.028567337278107;

for caso_ = 1:length(f_PC_)

load(f_PC_{caso_})

    for iv_ = 1:length(Partes)
    tiempo_(:,iv_) = [Partes{iv_, 3}.Tiempo_]';   
    diametro_(:,iv_) = [Partes{iv_,3}.Diametro]';
    err_dia_ (:,iv_) = abs(diametro_(:,iv_).*dscala_) + abs(escala_*0.87); 
    desplazamiento_(:,iv_) = [Partes{iv_, 3}.Desplazamiento]';
    err_des_ (:,iv_) = abs(desplazamiento_(:,iv_).*dscala_) + abs(escala_*0.87); 
    end

Tiempo = mean(tiempo_,2);
Diametro = mean(diametro_,2);
errDia = mean(err_dia_,2);
Desplazamiento = mean(desplazamiento_,2);
errDes = mean(err_des_,2);

clear tiempo_           diametro_                   err_dia_        ...
                        desplazamiento_             err_des_

DC_esparci (caso_,1:7)={f_PC_{caso_}(15:19),str2num(f_PC_{caso_}(18:19))...
                          ,Tiempo,Diametro,errDia,Desplazamiento,errDes};      % Celda con todos los datos
                 
clear Tiempo           Diametro                   errDia        ...
                       Desplazamiento             errDes            
end

TabVelRadial =  cell2table(DC_esparci,...                                       % Tabla con los datos (Puedo mejorarse junto con VelCaida para hacer un solo objeto y definir una sola clase)
    'VariableNames',{'Caso' 'altura' 'Tiempo' 'Diametro' 'errDia'...
                                      'Desplazamiento' 'errDes'});

save(file,'TabVelRadial')
end
% %%%%% COMETAR ESTA PARTE %%%%%
%           COPIA Partes D en Partes(:,3)
% fold_PD_ = 'partes/Otros/Partes_D'
% fold_PC_ = 'partes';
% 
% f_partesD_ = leedir(fold_PD_,'mat');
% 
% f_partesC_ = leedir(fold_PC_,'mat');
% 
% for caso_ = 1:length(f_partesD_)
% if length(f_partesD_) == length(f_partesC_)...
% &  min(f_partesD_{caso_}(30:34) == f_partesC_{caso_}(15:19))
% 
% load(f_partesD_{caso_})
% 
% parteD_ = Partes;
% clear Partes;
% 
% load(f_partesC_{caso_})
%  
% Partes(1:end,4) = parteD_(1:end,4);
% 
% save(f_partesC_{caso_},'Partes')
% end
% end


