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

Folder_ = '/home/maza/AllMeida/Dropbox/Droplets/Matlab/Droplets/folders';
f_type_ = 'mat';
f_img_ = 'jpg';


%%
v_Tcorte = [116,225;141,228];         v_Dcorte = [1,1;256,168];             % Vectores de corte, Target(parte inferior mas oscura) y gota(Segmento antes de hacer contacto con el target)
ft_ini_ =2;                           ft_end_ =44;                          % Inicio y fin de los cuadro de la caina    
err_px_ = 0.87;                                                             % Erro de la camara
T_ = 0.00018519;                                                            % Delta T entre cuadros
d_target_ = 3.024;                                                          % Diametro del target en mm.       

l_fold_fall_ = leedir(Folder_,f_type_);                                     % Lista de archivo con las carpetas que contienen los cuadros

%%       CASOs
for ind_caso_ = 1:length(l_fold_fall_)

    load(l_fold_fall_{ind_caso_});                                          % Abre el 'ind_caso Esimo' Son 4 en total
    
    file_ = strcat('Varaibles_medidas/DiamScala/'...                        % String con al direccion de guardado de los datos
                   ,l_fold_fall_{ind_caso_}(66:70),'.mat');

%%      Videos    

    for ind_vid_ = 1: length(folders_)
    archivo_ = leedir(folders_{ind_vid_},f_img_);                           % Listo los cuadros (imagenes) de la 'ind_vid_ esima' Carpeta  de imagenes.

%%      Cuadros    
    
     for ind_ft = ft_ini_ : ft_end_                                         
         Tiempo = T_ * abs(ind_ft-2);                                       % Calculo el instante de cada cuadro
         
        t_img_ = rgb2gray(imread(archivo_{ind_ft}));                        % Cuadro en escala de Grises
        
        f_img = cortarimg(t_img_,v_Tcorte,false);                           % Recorte del target
        [TBW_,~] = segTarget(f_img);                                        % Funcion gen erada para binarizar solo en ancho del target
        T_stats_=regionprops(TBW_,'Area');                                  % Propiedades de target
        l_t_ = max(T_stats_.Area)/4;                                        % Diametro del target PX
        Scala = d_target_/l_t_;                                             % Calculo de la escala Cuantos Px equivale un mm en el mundo real
        ErrScala = abs(l_t_)*0.001 + abs(3.024/(l_t_*l_t_))*err_px_;        % Error porpagado    
        
clear f_img BW T_stats_ l_t_

        f_img = cortarimg(t_img_,v_Dcorte,false);                           % Recorte de Espacio de la gota 
        [TBW,~] = segtImgDrop(f_img);                                       % Busqueda de esferas en la imagen
        TCC_ = bwconncomp(TBW_);                                            % Inversion de imagen binaria, para que la gota negra sea un conjunto blanco
        T_stats_ = regionprops(TBW,'Centroid','MajorAxisLength'...          % Calculo de propiedades de la gota
                            ,'MinorAxisLength');
        DiametroPx = (T_stats_.MajorAxisLength + ...                        % Diametro promendio en Px
                      T_stats_.MinorAxisLength)/2;

       Indice = ((ind_vid_-1)* (ft_end_-1))+ ind_ft-1;                      % Calculo del indice para ordenar datos en una sola fila y construir una tabla
        
       DC_drop  (Indice,1:6)={Tiempo,Scala,ErrScala,DiametroPx,err_px_...   % Celda con todos los datos
                              ,T_stats_.Centroid};
                          
clear  TBW_  TCC_  t_maxPx   t_maxPos T_bw_drop_  T_stats_  Indice 
        
     end
     
    end
    
    TabDrop =  cell2table(DC_drop,...                                       % Tabla con los datos (Puedo mejorarse junto con VelCaida para hacer un solo objeto y definir una sola clase)
    'VariableNames',{'Tiempo' 'Escala' 'errEscala'...
                     'DiametroPx' 'errDia' 'Centro'});
                 
                 save(file_,'TabDrop');                                     % Guardo los datos

                 
end


