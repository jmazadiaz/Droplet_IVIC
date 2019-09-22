%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Name        : 
%   Author      : Jesus Enrique Maza Diaz                                
%   Descripción : 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



folder_MT_DMGota_ = 'Varaibles_medidas/Densidad_y_masa_gota';
folder_Data_ = 'Varaibles_medidas/Velocidad';
folder_VelCaida_ = 'Varaibles_medidas/DiamScala/Fit';
folder_T_sup_ = 'Varaibles_medidas/Ten_sup';

file = 'Data_proce/parametros_fluidos.mat'


F_MT_DMGota_ = leedir(folder_MT_DMGota_ ,'mat');
F_Data_ = leedir(folder_Data_ ,'mat');
F_VelCaida_ = leedir(folder_VelCaida_ ,'mat');
F_T_sup_ = leedir(folder_T_sup_ ,'mat');

clear folder_MT_DMGota_             folder_Data_...
      folder_VelCaida_              folder_T_sup_

if length(F_MT_DMGota_)  == length(F_T_sup_)
%           Bucle de fluidos    
    for fluid_ = 1:length(F_T_sup_);
        
        if  min(F_MT_DMGota_{fluid_}(44:46) ==  F_T_sup_{fluid_}(30:32))    % Comprueba que Sea el mismo fluido 
        else
         'La lista MT_DMGta y T_sup no estan en el orden adecuado'
         break
        end
        
    if length(F_Data_)  == length(F_VelCaida_)    
%           Bucle de alturas        
      for Altu_ = 1:length(F_Data_)
              
            if min(F_Data_{Altu_}(35:36) == F_VelCaida_{Altu_}(39:40))      % Comprueba que sea la misma altura
%%                  Apertura de los datos                
 load(F_MT_DMGota_{fluid_});                    load(F_T_sup_{fluid_});               
 load(F_Data_{Altu_});                          load(F_VelCaida_{Altu_});
                
Densidad = mean(T_DMGota.Densidad);      deltaDen = mean(T_DMGota.ErrDen);
Velocidad = mean(Data.Velocidad(11:end));deltaVel  = mean(Data.errVel);
MasaGota = mean(T_DMGota.Mgota);         deltaMG  = 0.001;
Diametro = mean([VelCaida.Diametro]);    deltaD = mean([VelCaida.ErrDia]);
TenSup = mean(T_sup.Surf_tension(1:700));
deltTS = mean(T_sup.RMS_fit_dis_px(1:700));

Altura = str2num(F_Data_{Altu_}(35:36));   Fluido = F_T_sup_{fluid_}(30:32);

varDim_ = {Densidad,deltaDen,Velocidad,deltaVel,Diametro,deltaD...
            ,TenSup,deltTS};

[We, errWe] = numWe(varDim_);               indice_ = (Altu_+4*(fluid_-1));

D_fluidos(indice_,1:14) = {Fluido,Altura,We,errWe,MasaGota,deltaMG...
                            ,Densidad,deltaDen,TenSup,deltTS...
                            ,Velocidad,deltaVel,Diametro,deltaD};
                
                
                
        else
         'La lista DATA y VelCaida no estan en el orden adecuado'
         break  
        end
    end
      
    else
    'Las velocidades y el diametro de gota son diferentes'
    break  
    end
    end
    
P_fluidos = cell2table(D_fluidos...
,'VariableNames',{'Fluido'   'Altura'  'We' 'errWe' 'masaGota' 'errMasa'...
                 'Densidad'  'errDen'  'TenSuperf'  'errTsup'...
                 'Velocidad' 'errVel'  'Diametro'  'errDia'});
    
    P_fluidos = sortrows(P_fluidos,'We','ascend');
    save(file,'P_fluidos')
             
else
    'la Densidad y Tension Superficial no tienen el mismo número'
end  


% 


