%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Name        : vel_de_caida.m                               
%   Author      : Jesus Enrique Maza Diaz                                
%   Descripción : Es un script para calcular la velocidad de caida de la 
%                 gota a partir de los datos en Pates.
%                 mide la pendiente de los dato x,y de la caida, y la 
%                 aceleración con la velocidad entre dos puntos.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear

Folder_ = '/home/maza/AllMeida/Dropbox/Droplets/Matlab/Droplets/Varaibles_medidas/DiamScala';
f_type_ = 'mat';


%%
       

l_fold_fall_ = leedir(Folder_,f_type_);                                     % Lista de archivo con las carpetas que contienen los cuadros

for ind_caso_ = 1:length(l_fold_fall_)
    
    load(l_fold_fall_{ind_caso_});                                          % Abre el 'ind_caso Esimo' Son 4 en total
    
  file_struct = strcat('Varaibles_medidas/DiamScala/Fit/Fit'...                        % String con al direccion de guardado de los datos
                   ,l_fold_fall_{ind_caso_}(82:86),'.mat'); 
  file_TDATA = strcat('Varaibles_medidas/Velocidad/Vel'...                        % String con al direccion de guardado de los datos
                   ,l_fold_fall_{ind_caso_}(82:86),'.mat'); 
    
  [VelCaida, Data ] = VelCaida(TabDrop);  
  
  save(file_struct,'VelCaida');           save(file_TDATA,'Data');
   
  clear     VelCaida    Data
end