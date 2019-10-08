%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Name        : finger_ang_measure.m                               
%   Author      : Jesus Enrique Maza Diaz                                
%   Descripción : Es un script para calcular angulo de las falange de la
%   lámina de liquido 

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
1

%  clear
% clc
close all
%%

busca_img_ = false;                                                         % Solo para buscar los archivos (Hacer antes de calcular en caso de que cambie), Está al final
calcular_finger_ = false;  show_finger_ = true;

max_num_ob_ = 3000;

%%  Control del script

folder_caso_ = '/home/maza/AllMeida/Dropbox/Droplets/Matlab/Droplets/';
findis_ = 'indice/';                                                         % Carpeta de indice de las partes
finds_ = strcat(findis_,'*.mat' );
ffolders_ = 'folders/';                                                      % Capeta de las carpetas de fotogramas de los videos
ffolds_ = strcat(ffolders_,'*.mat' );
filetype_drops_ = 'jpg';     
ffold_save_ = 'fingering/';                                                 % Carpeta para guardar los datos
finge_ = strcat(ffold_save_,'*.mat');

%%  Variables para Mostrar Figure

zhorizontala_ = 0;        zVerticala_ = 45;      zX1 = 1920;     zY1 = 1080;


if calcular_finger_ == true

%%          Busca archivos .mat    
l_fold_ =   dir(ffolds_);                                                    % Todos las carpetas de fotogramas
l_inds_ =   dir(finds_);                                                    % todas las lista de indices
l_fing_ =   dir(finge_);                                                    % Todas las imagenes de maximo esparcimiento
    
    %%          Calculo de esqueleto                                        % Apartir del ultimo cuadro antes de romperse la gota

    for caso_ind = 1:length(l_fing_)

        load(strcat(l_fing_(caso_ind).folder,'/',l_fing_(caso_ind).name));  % Abre el iesimo caso

        for ind_vid_ = 1:length(fing_file_)                                 
            img_= rgb2gray(imread(fing_file_{ind_vid_}));                   % Imagen en Escala de grises 
            im_bw_ =imcomplement(imbinarize(img_));                         % Inverso de la imagen (La mancha en un conjunto cerrado de elementos)
            im_close_ = bwmorph(im_bw_,'close');                            % Clausura del conjunto en caso de estar abierto
            im_fill_ = imfill(im_close_,'holes');                           % Rellerno de los espacios internos vacios
        temp_cc_ = bwconncomp(im_fill_);                                    % listo los px donde el conjunto esta ubicado
        [~ ,temp_maxPos]=objectMaxSize(temp_cc_,max_num_ob_);               % Escojo el maximo conjunto (Debe ser el correspondiente a la lamina de liquido)
       t_objeto = object(im_fill_ , temp_cc_.PixelIdxList{temp_maxPos(1)}); % Copio en una imagen el objeto mas grande (La lámina de liquido)
            bw_fill_all_(:,:,ind_vid_) = t_objeto;                          % Matriz con el cuadro de la macha de cada video
            bw1_figure_all_(:,:,ind_vid_)  = bwmorph(t_objeto,'skel',inf);  % Esqueleto de la macha del ultimo cuadro
            bw2_figure_all_(:,:,ind_vid_)  = bwmorph(t_objeto,'remove');    % Borde o perimetro de la mancha del último objeto.

        
        clear  img_ im_bw_ im_close_calcular_finger_ im_fill_ im_close_ ...
               temp_maxPos t_objeto
        end
        finger_size_(caso_ind,1:5) = {l_fing_(caso_ind).name(11:15), ...    % Almaceno la informacion anterior por caso
                   str2num(l_fing_(caso_ind).name(14:15)), ...
                   bw1_figure_all_ ,bw2_figure_all_,bw_fill_all_};        

clear bw1_figure_all_ bw2_figure_all_ ind_vid_ bw_fill_all_ temp_cc_
    end 
%%              Angulo y puntos    
for caso_ind = 1:length(l_fing_)
    
    for ind_vid_ = 1:length(fing_file_)
        
        %%   Calcular centro
       i_fill_ = finger_size_{caso_ind,5}(:,:,ind_vid_);                    % Imagen de lamina completa expandida 
       i_skel_ = finger_size_{caso_ind,3}(:,:,ind_vid_);                    % Imagen del esqueleto
       i_remove_ = finger_size_{caso_ind,4}(:,:,ind_vid_);                  % Imagen del perimetro
%      
       centro_ = regionprops(i_fill_ ,'centroid');                          % Calcula el centro de la imagen
%%          Operaciones morfologias
   
       tp_branch_ = bwmorph(i_skel_,'branchpoints');                        % Puntos de ramificaciones del esqueleto
       p_end_ = bwmorph(i_skel_,'endpoints');                               % Puntos final de cada falange
       pp_end =    regionprops(p_end_,'PixelList');                            % Listado de los puntos finales
       pp_branch = regionprops(tp_branch_,'PixelList');                     % listado de los puntos ramificados
%%          Conteo de cajas

      [n_fil , r_fil] = boxcount(i_fill_);                                  % A lamina
      [n_end , r_end] = boxcount(i_skel_);                                  % A esqueleto
      [n_rmv , r_rmv] = boxcount(i_remove_);                                % A perimetro

      frc_dim_(ind_vid_) = struct('NBoxF',n_fil,'RBoxF',r_fil,...           % Estructura con todos los datos del conteo de cajas
                                   'NBoxE',n_end,'RBoxE',r_end,...
                                   'NBoxR',n_rmv,'RBoxR',r_rmv);  
       
%%  Calculo de angulos       
       t_angles_end = sortangle(pp_end,centro_.Centroid);                   % A partir de los puntos externos calculo el angulo de los puntos y los ordeno de mayor a menor
       t_angles_brach = sortangle(pp_branch,centro_.Centroid);              % " a puntos de ramas, Restando el centro, calcula cada angulo con el primero y los oredena 
       all_angle{ind_vid_,1} = t_angles_end;                                % Construyo estructura con los angulos de las falanges
       all_angle{ind_vid_,2} = t_angles_brach;                              % " con los angulos entre los puntos de ramas
       all_angle{ind_vid_,3} = angleMS ([t_angles_end.AngDif]);             % " con las diferencia entre dos angulos consecutivos ordenados.
       
clear   t_angles_end       t_angles_brach...
        i_fill_            i_skel_                 i_remove_...
        n_fil              n_end                   n_rmv...
        r_fil              r_end                   r_rmv...
        centro_            p_end_                  pp_end ...
        pp_branch          tp_branch_
 end
    
    finger_angle_(caso_ind,1:4) = {l_fing_(caso_ind).name(11:15), ...       % Almaceno la informaci�n anterior por caso
                   str2num(l_fing_(caso_ind).name(14:15)), ...
                   all_angle,frc_dim_};        
               
clear   ind_vid_ all_angle frc_dim_
end
clear zhorizontala_       zVerticala_         zX1             zY1         ...
      l_fold_             l_inds_             ... l_fing_                     ...
      folder_caso_        findis_             finds_          ffolders_   ...
      ffolds_             filetype_drops_     ffold_save_     finge_      ...
      fing_file_          caso_ind            busca_img_                  ...
      show_finger_        calcular_finger_    calcular_finger_          ...
      frc_dim_            all_angle           max_num_ob_             ...
%       
elseif show_finger_ == true
%%              Mostrar esqueleto y borde                                       FALTA AGREGAR LA ESCALA  IGUAL PARA TODOS, Esta comentado

% figure1 = figure                    %  Define la ventana
% axes1 = axes('Parent',figure1);      % Define El eje

% Grafico y despues fijo los limetes

% xlim(axes1,[0 200]);                  %Limita el eje x
% ylim(axes1,[0 .5]);                  % Limita el eje y


    for sh_caso_ = 1:length(finger_size_)
% sh_caso_ = 4
figure1 = figure('Name',strcat('Img. fing.todos : '...                      % Crea una ventana con la cadena de caracteres
                ,finger_size_{sh_caso_}),'NumberTitle','off');              % por titulo de la ventana
  shg;       set(gcf,'position',[zhorizontala_ zVerticala_ zX1 zY1])        % Fija la ventana en el punto zX1 XY1  con las dimenciones zHor.. y zVer..
 
  axes1 = axes('Parent',figure1);      % Define El eje
  
 subplot(2,2,1)                             
 
        bw1_figure_all_ = finger_size_{ sh_caso_ ,3};
        bw2_figure_all_ = finger_size_{ sh_caso_ ,4};
                                                                            % Muestra todos los perimetros y el esqueletos mesclados
        imshowpair(...
[bw2_figure_all_(:,:,1)  bw2_figure_all_(:,:,2)  bw2_figure_all_(:,:,3)...
bw2_figure_all_(:,:,4)  bw2_figure_all_(:,:,5);  bw2_figure_all_(:,:,6)...
bw2_figure_all_(:,:,7)  bw2_figure_all_(:,:,8)  bw2_figure_all_(:,:,9)...
bw2_figure_all_(:,:,10); bw2_figure_all_(:,:,11) bw2_figure_all_(:,:,12)...
bw2_figure_all_(:,:,13) bw2_figure_all_(:,:,14) bw2_figure_all_(:,:,15)],...
[bw1_figure_all_(:,:,1)  bw1_figure_all_(:,:,2)  bw1_figure_all_(:,:,3)...
bw1_figure_all_(:,:,4)  bw1_figure_all_(:,:,5);  bw1_figure_all_(:,:,6)...
bw1_figure_all_(:,:,7)  bw1_figure_all_(:,:,8)  bw1_figure_all_(:,:,9)...
bw1_figure_all_(:,:,10); bw1_figure_all_(:,:,11) bw1_figure_all_(:,:,12)...
bw1_figure_all_(:,:,13) bw1_figure_all_(:,:,14) bw1_figure_all_(:,:,15)],...
        'blend');
    title(strcat('Esqueleto de lamina expandida :',finger_size_{sh_caso_}))
    
     subplot(2,2,3)
     
           imshowpair(...                                                   
[bw2_figure_all_(:,:,16) bw2_figure_all_(:,:,17) bw2_figure_all_(:,:,18)...
bw2_figure_all_(:,:,19) bw2_figure_all_(:,:,20); bw2_figure_all_(:,:,21)...
bw2_figure_all_(:,:,22) bw2_figure_all_(:,:,23) bw2_figure_all_(:,:,24)...
bw2_figure_all_(:,:,25); bw2_figure_all_(:,:,26) bw2_figure_all_(:,:,27)...
bw2_figure_all_(:,:,28) bw2_figure_all_(:,:,29) bw2_figure_all_(:,:,30)],...
[bw1_figure_all_(:,:,16) bw1_figure_all_(:,:,17) bw1_figure_all_(:,:,18)...
bw1_figure_all_(:,:,19) bw1_figure_all_(:,:,20); bw1_figure_all_(:,:,21)...
bw1_figure_all_(:,:,22) bw1_figure_all_(:,:,23) bw1_figure_all_(:,:,24)...
bw1_figure_all_(:,:,25); bw1_figure_all_(:,:,26) bw1_figure_all_(:,:,27)...
bw1_figure_all_(:,:,28) bw1_figure_all_(:,:,29) bw1_figure_all_(:,:,30)],...
        'blend');
subplot(2,2,2)
                                                                             % Muestra el ajuste del histograma para cada sustancia
BCslope(finger_angle_{sh_caso_,4},1,4,finger_angle_{sh_caso_})
hold on
BCslope(finger_angle_{sh_caso_,4},2,4,finger_angle_{sh_caso_})
hold on
BCslope(finger_angle_{sh_caso_,4},3,4,finger_angle_{sh_caso_})

subplot(2,2,4)
                                                                            % Muestra el Hitograma para de frecuencias relativas cada sustancia
histogram(axes1,cell2mat(finger_angle_{sh_caso_, 3}(:,end)),'Normalization'...
           ,'probability')

ylim(axes1,[0 1]);                  % Limita el eje y
xlim(axes1,[9 20]);                  %Limita el eje x

xlabel('Angulo Promedio entre falanges');
ylabel('Probabilidad');
title(strcat('Histograma de fecuencias entre falanges:'...
      ,finger_size_{sh_caso_}))
  clear axes1

    end
    
elseif busca_img_ == true                                                   % Solamente cuando se quiera generar la lista de los cuadros especifico de cada caso y video. 
    %%      Busca Las direcciones de cada imagen final del esparcimiento
    for caso_ind = 1:length(l_fold_)

    load(strcat(ffolders_,l_fold_(caso_ind).name));                             % Abre la variable folders_ (Contiene la carpetas de los cuadro de cada video)
    load(strcat(findis_,l_inds_(caso_ind).name));                               % Abre la variable indices_ (Contiene los indices de inicio y fin de cada proceso)

       for fold_ind_ = 1:length(folders_)
               archivo_ = leedir(folders_{fold_ind_}, filetype_drops_ );

                fing_file_ {fold_ind_}= archivo_{indices_(fold_ind_,6)};

       end

    file_save_ = strcat(ffold_save_,'fingering_',l_fold_(caso_ind).name(8:12),'.mat');
    save(file_save_,'fing_file_');   
    end
    
 clear l_fold_  l_inds_ ffolders_ ffolds_ findis_ finds_ archivo_ folders_ indices_
end




% 
% [bw2_figure_all_(:,:,1)  bw2_figure_all_(:,:,2)  bw2_figure_all_(:,:,3);...
% bw2_figure_all_(:,:,4)  bw2_figure_all_(:,:,5)  bw2_figure_all_(:,:,6);...
% bw2_figure_all_(:,:,7)  bw2_figure_all_(:,:,8)  bw2_figure_all_(:,:,9);...
% bw2_figure_all_(:,:,10) bw2_figure_all_(:,:,11) bw2_figure_all_(:,:,12);...
% bw2_figure_all_(:,:,13) bw2_figure_all_(:,:,14) bw2_figure_all_(:,:,15);...
% bw2_figure_all_(:,:,16) bw2_figure_all_(:,:,17) bw2_figure_all_(:,:,18);...
% bw2_figure_all_(:,:,19) bw2_figure_all_(:,:,20) bw2_figure_all_(:,:,21);...
% bw2_figure_all_(:,:,22) bw2_figure_all_(:,:,23) bw2_figure_all_(:,:,24);...
% bw2_figure_all_(:,:,25) bw2_figure_all_(:,:,26) bw2_figure_all_(:,:,27);...
% bw2_figure_all_(:,:,28) bw2_figure_all_(:,:,29) bw2_figure_all_(:,:,30)],...
% [bw1_figure_all_(:,:,1)  bw1_figure_all_(:,:,2)  bw1_figure_all_(:,:,3);...
% bw1_figure_all_(:,:,4)  bw1_figure_all_(:,:,5)  bw1_figure_all_(:,:,6);...
% bw1_figure_all_(:,:,7)  bw1_figure_all_(:,:,8)  bw1_figure_all_(:,:,9);...
% bw1_figure_all_(:,:,10) bw1_figure_all_(:,:,11) bw1_figure_all_(:,:,12);...
% bw1_figure_all_(:,:,13) bw1_figure_all_(:,:,14) bw1_figure_all_(:,:,15);...
% bw1_figure_all_(:,:,16) bw1_figure_all_(:,:,17) bw1_figure_all_(:,:,18);...
% bw1_figure_all_(:,:,19) bw1_figure_all_(:,:,20) bw1_figure_all_(:,:,21);...
% bw1_figure_all_(:,:,22) bw1_figure_all_(:,:,23) bw1_figure_all_(:,:,24);...
% bw1_figure_all_(:,:,25) bw1_figure_all_(:,:,26) bw1_figure_all_(:,:,27);...
% bw1_figure_all_(:,:,28) bw1_figure_all_(:,:,29) bw1_figure_all_(:,:,30)],...

