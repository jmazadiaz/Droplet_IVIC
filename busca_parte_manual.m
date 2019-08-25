%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   
%   Este script es para explorar las partes de cada v�deo  en el conjunto de
%   imagenes extraidas de los videos
%   
%   Nota: Primero buscar ajustar la misma cantidad de cuadros para la parte
%   de la caida, ejemplo (Primer cuadro Target solo, la segunda imagen esta
%   a 27 cuadros del primer contacto) Entre mas alto y el angulo del espejo 
%   Menos cuadros de esta parte a  seran. El resto de los cuadros son
%   iguales para el resto de las partes, de 20 a 18 cuadros esparcimiento,
%   10 cuadros empalamiento, y 8 cuadros al desintegracion antes de tocar
%   la superficie.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
clear;          
close all;      %clc;
%%%%%%%%%%%%%%              CONTROL PRINCIPAL                %%%%%%%%%%%%%%                     
%%

    caso = 12;                                                                   % Caso de estudio
    test = 0;                                                                   % 1 = Prueba 0 = recursivo
    video =24;                                                                  % Video a analizar(1,2,...,30)
    
    folder_Lfold_ = strcat(...
           '/home/maza/AllMeida/Dropbox/Droplets/Matlab/Droplets/folders');     %Recore el diretorio
    filetype_fold_ = 'mat';% Formato de archivo folders
    filetype_imag_ = 'jpg';% Formato de imagen

    caso_fluid_vel_ = leedir(folder_Lfold_, filetype_fold_ );
    
    
    clear folder_drops_ filetype_drops_
    
   load(caso_fluid_vel_{caso})                                                  % Caso ( fluido+altura ) [Abre la lista de video]

   
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%      CONTROL DE PARTES
   
   ind_ini_cero_ = 1;               ind_end_cero_ =  ind_ini_cero_;             % Parte 0: indices_(video,1) e indices_(video,2)
   ind_ini_a_    = 2;               ind_end_a_  =  27;                          % Parte A: indices_(video,3) e indices_(video,4)
   ind_ini_b_   = ind_end_a_;       ind_end_b_  =  47;                          % Parte B: indices_(video,5) e indices_(video,6)
   ind_ini_c_   = ind_end_b_;       ind_end_c_  =  57;                          % Parte C: indices_(video,7) e indices_(video,8)
   ind_ini_d_   = ind_end_c_;       ind_end_d_  = 65;                           % Parte D: indices_(video,9) e indices_(video,10)
   ind_end_proc_= ind_end_d_+1;                                                 % Parte no move:  indices_(video,11)
   ind_ini_vid_ = ind_ini_cero_;    ind_end_vid_ =  113;                        % ini-end video:  indices_(video,12) e indices_(video,13)
   
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    
indice_ = [ind_ini_cero_ , ind_end_cero_ ,...
           ind_ini_a_    ,    ind_end_a_ ,...
           ind_ini_b_    ,    ind_end_b_,...
           ind_ini_c_    ,    ind_end_c_,...
           ind_ini_d_    ,    ind_end_d_,...
           ind_end_proc_ ,               ...
           ind_ini_vid_ , ind_end_vid_];                                        % Los indice en un arreglo

       if test == 0
       
       
for video = 1:length(folders_)
    
    archivo_ = leedir(folders_{video},filetype_imag_);                          % Lista de cuadros (Direccion)
    indices_(video,:) = indice_;                                                % Copia inidice en las lista de indices usada en cuadrante
  
% Copiar en consola cuando termine todo los casos   
    
%    
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
       
       
   close
   %%
    figure;         shg;
    L = 1920;       W = 1000;        a=1920;       b=1;
    set(gcf,'position',[a b L W])
    
    %%
    subplot(2,4,1)
    imshow(imread(archivo_{ind_ini_a_}))
%         title(['Parte A ini : ',archivo_{ind_ini_a_}(55:61),' -
%         ',archivo_{ind_ini_a_}(63:66)])
%         
        title(['Parte A ini : ',archivo_{ind_ini_a_}(54:60),...
              ' - Indice: ',num2str(ind_ini_a_)])
    subplot(2,4,5)
    imshow(imread(archivo_{ind_end_a_}))
%         title(['Parte A end : ',archivo_{ind_end_a_}(55:61),' - ',archivo_{ind_end_a_}(63:66)])
        title(['Parte A end : ',archivo_{ind_end_a_}(54:60),...
               ' - Indice: ',num2str(ind_end_a_)]);
    %%
    subplot(2,4,2)
    imshow(imread(archivo_{ind_ini_b_}))
%         title(['Parte B ini : ',archivo_{ind_ini_b_}(55:61),' - ',archivo_{ind_ini_b_}(63:66)])
        title(['Parte B ini : ',archivo_{ind_ini_b_}(54:61),...
              ' - Indice: ',num2str(ind_ini_b_)]);
        subplot(2,4,6)
    imshow(imread(archivo_{ind_end_b_}))
%         title(['Parte B end : ',archivo_{ind_end_b_}(55:61),' - ',archivo_{ind_end_b_}(63:66)])
        title(['Parte A end : ',archivo_{ind_end_b_}(54:60),...
               ' - Indice: ',num2str(ind_end_b_)])
   
        
    %%
    subplot(2,4,3)
    imshow(imread(archivo_{ind_ini_c_}))
%         title(['Parte C ini : ',archivo_{ind_ini_b_}(55:61),' - ',archivo_{ind_ini_b_}(63:66)])
        title(['Parte C ini : ',archivo_{ind_ini_c_}(54:60),...
              ' - Indice: ',num2str(ind_ini_c_)]);
    subplot(2,4,7)
    imshow(imread(archivo_{ind_end_c_}))
%        title(['Parte C end : ',archivo_{ind_end_b_}(55:61),' - ',archivo_{ind_end_b_}(63:66)])
        title(['Parte A end : ',archivo_{ind_end_c_}(54:60),...
               ' - Indice: ',num2str(ind_end_c_)])
    
    %%
    subplot(2,4,4)
    imshow(imread(archivo_{ind_ini_d_}))
%        title(['Parte D ini : ',archivo_{ind_ini_b_}(55:61),' - ',archivo_{ind_ini_b_}(63:66)])
       title(['Parte D ini : ',archivo_{ind_ini_d_}(55:61),...
              ' - Indice: ',num2str(ind_ini_d_)]);
    subplot(2,4,8)
    imshow(imread(archivo_{ind_end_d_}))
%        title(['Parte D end : ',archivo_{ind_end_b_}(55:61),' - ',archivo_{ind_end_b_}(63:66)])
        title(['Parte A end : ',archivo_{ind_end_d_}(55:61),...
               ' - Indice: ',num2str(ind_end_d_)])
   
 pause          
end           

file_save_indices_ = strcat(caso_fluid_vel_{caso}(1:53),'indice/',...
                             'indi-',caso_fluid_vel_{caso}(69:73),'.mat');     %  Dirección de guardado de var indices_
                     strcat('indi-',caso_fluid_vel_{caso}(69:73))              %  Mensaje
save(file_save_indices_,'indices_')                                            %  Guarda indices_ para el caso de estudio 
  close all
%%

elseif test == 1
           
           archivo_ = leedir(folders_{video},filetype_imag_);                          % Lista de cuadros (Direccion)
    indices_(video,:) = indice_;                                                % Copia inidice en las lista de indices usada en cuadrante
  
% Copiar en consola cuando termine todo los casos   
    
%    
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
       
       
   close
   %%
    figure;         shg;
    L = 1920;       W = 1000;        a=1920;       b=1;
    set(gcf,'position',[a b L W])
    
    %%
    subplot(2,4,1)
    imshow(imread(archivo_{ind_ini_a_}))
%         title(['Parte A ini : ',archivo_{ind_ini_a_}(55:61),' -
%         ',archivo_{ind_ini_a_}(63:66)])
%         
        title(['Parte A ini : ',archivo_{ind_ini_a_}(55:61),...
              ' - Indice: ',num2str(ind_ini_a_)])
    subplot(2,4,5)
    imshow(imread(archivo_{ind_end_a_}))
%         title(['Parte A end : ',archivo_{ind_end_a_}(55:61),' - ',archivo_{ind_end_a_}(63:66)])
        title(['Parte A end : ',archivo_{ind_end_a_}(55:61),...
               ' - Indice: ',num2str(ind_end_a_)])
    %%
    subplot(2,4,2)
    imshow(imread(archivo_{ind_ini_b_}))
%         title(['Parte B ini : ',archivo_{ind_ini_b_}(55:61),' - ',archivo_{ind_ini_b_}(63:66)])
        title(['Parte B ini : ',archivo_{ind_ini_b_}(55:61),...
              ' - Indice: ',num2str(ind_ini_b_)])
        subplot(2,4,6)
    imshow(imread(archivo_{ind_end_b_}))
%         title(['Parte B end : ',archivo_{ind_end_b_}(55:61),' - ',archivo_{ind_end_b_}(63:66)])
        title(['Parte A end : ',archivo_{ind_end_b_}(55:61),...
               ' - Indice: ',num2str(ind_end_b_)])
   
        
    %%
    subplot(2,4,3)
    imshow(imread(archivo_{ind_ini_c_}))
%         title(['Parte C ini : ',archivo_{ind_ini_b_}(55:61),' - ',archivo_{ind_ini_b_}(63:66)])
        title(['Parte C ini : ',archivo_{ind_ini_c_}(55:61),...
              ' - Indice: ',num2str(ind_ini_c_)])
    subplot(2,4,7)
    imshow(imread(archivo_{ind_end_c_}))
%        title(['Parte C end : ',archivo_{ind_end_b_}(55:61),' - ',archivo_{ind_end_b_}(63:66)])
        title(['Parte A end : ',archivo_{ind_end_c_}(55:61),...
               ' - Indice: ',num2str(ind_end_c_)])
    
    %%
    subplot(2,4,4)
    imshow(imread(archivo_{ind_ini_d_}))
%        title(['Parte D ini : ',archivo_{ind_ini_b_}(55:61),' - ',archivo_{ind_ini_b_}(63:66)])
       title(['Parte D ini : ',archivo_{ind_ini_d_}(55:61),...
              ' - Indice: ',num2str(ind_ini_d_)])
    subplot(2,4,8)
    imshow(imread(archivo_{ind_end_d_}))
%        title(['Parte D end : ',archivo_{ind_end_b_}(55:61),' - ',archivo_{ind_end_b_}(63:66)])
        title(['Parte A end : ',archivo_{ind_end_d_}(55:61),...
               ' - Indice: ',num2str(ind_end_d_)])
   
           
   end
   
%%%%%%%%%%%%%                    END                        %%%%%%%%%%%%%
