%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%   Este Script permite clasificar cada parte del video para su posterior
%   analisis, visto que durante la caida, el esparcimiento y su posterior       Nivel(1) = Condición: 2 imanes anagenes antes del aparecer la gota
%   fragmentación los criterios de medidas son distintos y es mucho más         Nivel(2) = Aparece la gota en la imagen.
%   eficiente trabajarlas por separado. Los siquientes valores de la            Nivel(3) = Inicio de parte A, toda la gota en la pantalla arriba.
%   variable "nivel" es una guia para identenficar con mayor facilidad que      Nivel(4) = Condición: Gota aparece en la imagen abajo.
%   significa cada paso en la busqueda de los indice del fotoframa donde        Nivel(5) = Condición: la gota esta fuera del borde.
%   empezaría cada fase, esta ultima variable se busca para cada video del      Nivel(7) = Condición: La gota aparece en imagen, arriba derecha (AD).
%   caso de estudio, y se guardan en la variable "indices_"  el significado     Nivel(8) = Inicio de parte B -> Toda la gota en la image AD.
%   de los mismos estan en el Script 'cuadrante.m' y comentados en este en      Nivel(9) = Condición: La gota aparece en la imagen, Centroid + r + 3px (CR1)
%   su respectivo espacio de aparición.                                         Nivel(10)= Fin de parte B +1 inicio Parte C -> Toda la gota en la imagen CR1.
%                                                                               Nivel(11)= Condición: Toda la imagen CR1 negra.
%   hice una modificacion para los casos en que el reflejo y la gota pasan      Nivel(12)= Fin de parte C -> Aparece un picel banco en la imagen CR1
%   por el mismo lugar solo hasta inicio parte B que tiene que estar en         Nivel(13)= fin de parte C e inicio parte D -> las cuatros imagnes sucesivas.
%   busqueda paralelo a A.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear indices_
close all
%%  Constantes

T_bw_ = 70;                                                                 % Maximo valor en binarización
inv_ = true;                                                                % inverso del binarizaciónm
nun_cc_ = 8;                                                                %(4o8)specifies the desired connectivivty for the connected components
T_O_= 50;                                                                   %Numero de pixels para objetos grandes en la imagen
cond_ = false;                                                              % Condicion en Nivel dos si gota == 2 para detectar la salida de la gota de vectAi_;
cond1_ = false;                                                             % Condicion en Nivel dos si gota == 2 para detectar la salida de la gota de vectAi_;

vect_ = [1,1;256,200];                                                     % en caso que quieras recortar la imagen para evitar manchas en el inferior
% vectAi_= [1,1;90,50];                                                      % Recuadro superior Izquierdo
vectAi_ = [26,1;83,50];
vectAe_ = [56,200;90,256];                                                  % Recuadro Inferior izquierdo
vectBi_= [80,1;116,50];                                                     % Recuadro superior central
vectE_ = [40,40;240,250];                                                   % Recuadro central
c1_ = 3;
c2_ = 2;
%%
test_ = false
valor_ = 6                                                                 % Video que quiere revisar
ener_ =1                                                                    % Como revisa todos los casos puede escojer cual en Test
level_ = 6;                                                                 % Lugar donde quiere empezar (min 6 para gota_2)
gota_ = 1;                                                                  % 1= si la gota pasa por un lado diferente al reflejo 
                                                                            %   2 = Si la gota pasa por el mismo lado que el reflejo
%%
indices_(1:13) = 0; 

folfer_video_ = 'D:\Dropbox\Droplets\Matlab\Droplets\folders';
mesg1_='Caso  :  ';
mesg11_ = '   /   ';
mesg2_='       Porcentaje de videos  :  '; 
filetype_video_ = 'mat';

dir_ = strcat(folfer_video_,'\*.',filetype_video_);
files_ = dir(dir_);

filetype_drops_ = 'jpg';                                                   % Tipo de Archivo en var (archivo_)

video_= leedir(folfer_video_, filetype_video_ );                            % Lee todos los tipos de archivo mat con al informacion de los videos

nivel(1:13) = false;                                                        % Inicializa Nivel

if gota_ == 1
    
      nivel(1) = true;
      
    for h_ = 1: length(video_);                                             % Bucle de los caso de estudio

        load(video_{h_});                                                   %   Abrel la lista de carpeta de los fotogramas

        for j_ = 1:length(folders_)                                         % Bucle de las carpetas con fotogramas

            porcentaje2_ = floor(j_/length(folders_)*100);
            disp(strcat(mesg1_,num2str(h_), mesg11_, ...
                 num2str(length(video_)), '    -->' ,...
                 mesg2_,num2str(porcentaje2_), ' %'));

            folder_drops_ = folders_{j_};
            archivo_ = leedir(folder_drops_, filetype_drops_ );             % Lee todos los tipos de archivos en la carpeta 

            img_ =imread(archivo_{1});                                      % Arriba  ind_
            img2_=rgb2gray(img_);

            bw_=binarizacion(img2_,T_bw_,inv_);                             % Ariiba T_bw_ inv_

            cc=bwconncomp(bw_, nun_cc_);
            [s2max, s2maxpos]=objectMaxSize(cc,T_O_);                       % Arriba T_O_

            bw1_ = object(bw_,cc.PixelIdxList{s2maxpos(1)});                % Copia el objeto más grande en bw1

            [centro,radii] = centre(bw1_);

            vectBe_ = floor([centro(1)-radii-c1_, centro(2)-radii-c2_ ...
                      ; centro(1)+radii+c1_, centro(2)+radii+c2_]);

            clear bw_ img_ img2_ bw1_
            
            for i_ = 1:length(archivo_)                                     % Bucle de los Fotogramas

               img_ = rgb2gray(imread(archivo_{i_}));
%                imshow(img_);

               %%
               if nivel(1) == true                                          % LA GOTA APARECE       INDICE(1,2) (Ini, Fin parte 0)
                  t_img_vAi_ = cortarimg(img_,vectAi_,false);
                  bw_ = binarizacion(t_img_vAi_,T_bw_,inv_);
    %               imshowpair(img_,bw_,'montage')
                  max_ = max(max(bw_));
                  if max_ == true
                      indices_(j_,1) = i_-2;                                %   ANTES DE APARECER LA GOTA
                      indices_(j_,2) = i_;                                  %   APARECE LA GOTA
                      nivel(2) = true;      nivel(1) = false;
                   end
               clear t_img_vAi_ bw_ max_
               %%                                                                   
               elseif nivel(2) == true                                      % LA GOTA COMPLETA ARRIBA  INDICE(3) (Inicio parte A)
                   t_img_vAi_ = cortarimg(img_,vectAi_,false);
    %              imshow(t_img_vAi_)
                   bw_ = binarizacion(t_img_vAi_,T_bw_,inv_);

                   x_ = estaenborde(bw_,true);
                   if x_ == false
                       indices_(j_,3) = i_;                                 %   TODA LA GOTA ARRIBA (INI PARTE A)
                            nivel(3) = true;     nivel(2) = false;          % para videos donde la gota pasa por un lado diferente frente a la camara que el reflejo
                   end
               clear t_img_vAi_ bw_ x_
               %%    
               elseif nivel(3) == true                                      % APARECE ABAJO
                   t_img_vAe_ = cortarimg(img_,vectAe_,false);
                   bw_ = binarizacion(t_img_vAe_,T_bw_,inv_);
    %              imshowpair(img_,bw_,'montage')
                   max_ = max(max(bw_));
                   if max_ == true
                           nivel(4) = true;     nivel(3) = false;
                   end
               clear t_img_vAe_ bw_ max_
               %%             
               elseif nivel(4) == true                                      % SALIO DEL TOPE DOWN
                       t_img_vAe_ = cortarimg(img_,vectAe_,false);
                       bw_ = binarizacion(t_img_vAe_,T_bw_,inv_);
        %              imshowpair(t_img_vAe_,img_,'montage')
                       x_ = estaenborde(bw_,true);
                            if x_ == true
                                    nivel(5) = true;     nivel(4) = false;
                            end
               clear t_img_vAe_ bw_ x_
               %%     
               elseif nivel(5) == true                                      % ESTA EN EL BORDE DOWN   INDICE(4) (Fin parte A)
                   t_img_vAe_ = cortarimg(img_,vectAe_,false);
                   bw_ = binarizacion(t_img_vAe_,T_bw_,inv_);
    %              imshowpair(t_img_vAe_,img_,'montage')
                   x_ = estaenborde(bw_,true);
                   if x_ == true
                        indices_(j_,4) = i_-1;                              % GOTA ESTA TOCANDO EL BORDE (END PARTE A)
                        nivel(6) = true;    nivel(5) = false;
                   end
               clear t_img_vAe_ bw_ x_
               %%    
               elseif nivel(6) == true                                      % APARECE EN EL BORDE UP REFLEJO
                   t_img_vBi_ = cortarimg(img_, vectBi_,false);
                   bw_ = binarizacion(t_img_vBi_,T_bw_,inv_);
    %                imshowpair(bw_,img_,'montage')
                   max_ = max(max(bw_));
                   if max_ == true
                        nivel(7) = true;    nivel(6) = false;
                   end
               clear t_img_vBi_ bw_ max_
               %%    
               elseif nivel(7) == true                                      % GOTA COMPLETA EN EL REFLEJO   INDICE(5) (Inicio parte B)
                    t_img_vBi_ = cortarimg(img_, vectBi_,false);
                    bw_ = binarizacion(t_img_vBi_,T_bw_,inv_);
    %                 imshowpair(img_,t_img_vBi_,'montage')
                    x_ = estaenborde(bw_,true);
                    if x_ == false
                            indices_(j_,5) = i_; 
                            nivel(8) = true;    nivel(7) = false;
                       end
               clear t_img_vBi_ bw_ x_ 
               %%    
               elseif nivel(8) == true                                      % GOTA EN EL TARGET
                   img_=img_+50;
                   img_(cc.PixelIdxList{s2maxpos(1)})= 0;
                   t_img_vBe_ = cortarimg(img_, vectBe_,false);
    %                imshowpair(img_,t_img_vBe_,'montage')
                   x_ = estaenborde(t_img_vBe_,false);
                   if x_ == true
                        nivel(9) = true;        nivel(8) = false;
                   end
               clear img_ t_img_vBe_ x_
               %%    
               elseif nivel(9) == true                                      % GOTA CASI IMPACTA     INDICE(6,7) (Fin parte B, Inicio Parte C)             
                   img_=img_+50;
                   img_(cc.PixelIdxList{s2maxpos(1)})= 0;
                   t_img_vBe_ = cortarimg(img_, vectBe_,false);
    %                imshowpair(img_,t_img_vBe_,'montage')
                   x_ = estaenborde(t_img_vBe_,false);
                   if x_ == false
                        indices_(j_,6) = i_;                                %   GOTA ESTA POR IMPACTAR (END PARTE B)
                        indices_(j_,7) = i_+1;                              %   GOTA IMPACTÓ  (INI PARTE C)
                        nivel(10) = true;       nivel(9) = false;
                   end
               clear img_ img2_ t_img_vBe_ x_
               %%    
               elseif nivel(10) == true                                     % GOTA EXPANDIENDOSE INICIO
                   t_img_vBe_ = cortarimg(img_, vectBe_,false);
                   img2_ = t_img_vBe_;
                   bw_=binarizacion(img2_,T_bw_,inv_);
                   pp_ = px2part(bw_);
                   if pp_(1) > 94.5
                       nivel(11) = true;        nivel(10) = false;
                   end
               clear img_ t_img_vBe_ img2_ bw_ pp_
               %%    
               elseif nivel(11) == true                                     % LAMINA DE LA GOTA ROMPIENDOSE   INDICE(8,9) (Fin parte C, Lamina muy rota inicio parte D)
                   t_img_vBe_ = cortarimg(img_, vectBe_,false);
                    img2_ = t_img_vBe_;
                   bw_=binarizacion(img2_,T_bw_,inv_);
                   pp_ = px2part(bw_);
                   if pp_(1) < 93.5
                       indices_(j_,8) = i_;
                       indices_(j_,9) = i_+2;
                       nivel(12) = true;        nivel(11) = false;
                   end
               clear img_ t_img_vBe_ img2_ bw_ pp_
               %%
               elseif nivel(12) == true                                     % FRAGMENTACION   INDICE(10,11) (Fin de parte D, Fin del proceso)
                   imgb_ = rgb2gray(imread(archivo_{i_+1}));
                   imgc_ = rgb2gray(imread(archivo_{i_+2}));
                   t_img_a_ = cortarimg(img_, vectE_,false);
                   t_img_b_ = cortarimg(imgb_,vectE_,false);
                   t_img_c_ = cortarimg(imgc_,vectE_,false);
                   cab_ = corr2(t_img_a_,t_img_b_);
                   cac_ = corr2(t_img_a_,t_img_c_);
                   cdif_ = cab_ - cac_;
    %               imshow([t_img_a_,t_img_b_,t_img_c_])
    %               title(strcat('imagen A B C: correlacion A-B:',num2str(cab_),'   ;      Correlacion A-C:',num2str(cac_),'   <-->  ',num2str(cab_-cac_)))
                   if cdif_ <= 0.001
                       indices_(j_,10) = i_;
                       indices_(j_,11) = i_+4;
                       indices_(j_,12) = 1;
                       indices_(j_,13) = length(archivo_);                  %   INDICE(12,13) (Inicio y final del video.)
                       nivel(13) = true;        nivel(12) = false;
                   end
               clear img_ imgb_ imgc_ t_img_a_ t_img_b_ t_img_c_ ...
                     cab_ cac_ cdif_
               %%
               elseif nivel(13) == true                                     % NO HAY MÁS QUE REVISAR (finalizo el proceso)
                   nivel(13) = false;
                   nivel(1) = true;
                   break
               else
                   fprintf(strcat('Hay un error en el video:  '...
                           ,num2str(j_)))
                   indices_(j_,1:13) = 0; 
               end
            
            end                                                             % Fin de bucle de los Fotogramas
                  
        end                                                                 % Fin de bucle de las capetas con fotogramas
        file_archivo_ = strcat('indice\','indi_',files_(h_).name)
        save(file_archivo_,'indices_');
        
    end                                                                     % Fin de bucle de los caso de estudio

elseif gota_ == 2

    if test_ == true;
        
        indice_(valor_,14) = valor_;
        h_ = ener_;
        smaxp_ = 1;
        j_ = valor_;
        nivel(1:13) = false;
        
        load(video_{h_});
            
             if level_ == 1
                 nivel(1) = true;       indice_(j_,1:2) = 1:2;
             elseif level_ ==2
                 nivel(2) = true;       indice_(j_,1:3) = 1:3;
             elseif level_ == 3
                 nivel(3) = true;       indice_(j_,1:3) = 1:3;
             elseif level_ == 4  
                 nivel(4) = true;       indice_(j_,1:3) = 1:3;
             elseif level_ == 5
                 nivel(5) = true;       indice_(j_,1:4) = 1:4;
             elseif level_ == 6
                 nivel(6) = true;       indice_(j_,1:4) = 1:4;
             end
         
        porcentaje2_ = floor(j_/length(folders_)*100);
        disp(strcat(mesg1_,num2str(h_), mesg11_, num2str(length(video_)), '    -->' ,mesg2_,num2str(porcentaje2_), ' %'));

        folder_drops_ = folders_{j_};
        archivo_ = leedir(folder_drops_, filetype_drops_ );  % Lee todos los tipos de archivos en la carpeta 

        img_ =imread(archivo_{1});    % Arriba  ind_
        img2_=rgb2gray(img_);

        bw_=binarizacion(img2_,T_bw_,inv_);    %Ariiba T_bw_ inv_

        cc=bwconncomp(bw_, nun_cc_);
        [s2max, s2maxpos]=objectMaxSize(cc,T_O_);  % Arriba T_O_

        bw1_ = object(bw_,cc.PixelIdxList{s2maxpos(smaxp_)}); % Copia el objeto más grande en bw1

        [centro,radii] = centre(bw1_);

        vectBe_ = floor([centro(1)-radii-c1_, centro(2)-radii-c2_ ...
                        ; centro(1)+radii+c1_, centro(2)+radii+c2_]);

        clear bw_ img_ img2_ bw1_

            for i_ = 1:length(archivo_)

               img_ = rgb2gray(imread(archivo_{i_}));

               %%
               if nivel(1) == true                          % LA GOTA APARECE       INDICE(1,2) (Ini, Fin parte 0)
                  t_img_vAi_ = cortarimg(img_,vectAi_,false);
                  bw_ = binarizacion(t_img_vAi_,T_bw_,inv_);
                  imshowpair(img_,bw_,'montage')
                  max_ = max(max(bw_));
                  if max_ == true
                      indice_(j_,1) = i_-2;   %       ANTES DE APARECER LA GOTA
                      indice_(j_,2) = i_;     %       APARECE LA GOTA
                      nivel(2) = true;      nivel(1) = false;
                      imshow(img_)
                      pause
                   end
               clear t_img_vAi_ bw_ max_
               %%                                                                   
               elseif nivel(2) == true                     % LA GOTA COMPLETA ARRIBA  INDICE(3) (Inicio parte A)
                   t_img_vAi_ = cortarimg(img_,vectAi_,false);
    %              imshow(t_img_vAi_)
                   bw_ = binarizacion(t_img_vAi_,T_bw_,inv_);
                   x_ = estaenborde(bw_,true);
                   if cond_ == false
                        if x_ == false
                           indice_(j_,3) = i_;     %   TODA LA GOTA ARRIBA (INI PARTE A)
                           cond_ = true;
                           imshow(img_)
                        end
                   elseif cond_ == true     
                      	if x_ == true               %   LA GOTA EN EL BORDE INFERRIOR ARRIBA
                        cond1_ = true
                        end
                   elseif cond1_ == true
                        if x_ == false              %   LA GOTA FUERA DEL CUADRO ARRIBA
                        nivel(3) = true;     nivel(2) = false;
                        end
                   end
               clear t_img_vAi_ bw_ x_
               %%    
               elseif nivel(3) == true                      % APARECE ABAJO
                   t_img_vAe_ = cortarimg(img_,vectAe_,false);
                   bw_ = binarizacion(t_img_vAe_,T_bw_,inv_);
    %              imshowpair(img_,bw_,'montage')
                   max_ = max(max(bw_));
                   if max_ == true
                       nivel(4) = true;     nivel(3) = false;
                   end
               clear t_img_vAe_ bw_ max_
               %%             
               elseif nivel(4) == true                      % SALIO DEL TOPE DOWN
                   t_img_vAe_ = cortarimg(img_,vectAe_,false);
                   bw_ = binarizacion(t_img_vAe_,T_bw_,inv_);
    %              imshowpair(t_img_vAe_,img_,'montage')
                   x_ = estaenborde(bw_,true);
                   if x_ == true
                        nivel(5) = true;     nivel(4) = false;
                   end
               clear t_img_vAe_ bw_ x_
               %%     
               elseif nivel(5) == true                      % ESTA EN EL BORDE DOWN   INDICE(4) (Fin parte A)
                   t_img_vAe_ = cortarimg(img_,vectAe_,false);
                   bw_ = binarizacion(t_img_vAe_,T_bw_,inv_);
    %              imshowpair(t_img_vAe_,img_,'montage')
                   x_ = estaenborde(bw_,true);
                   imshow(img_)
                   if x_ == true
                        indice_(j_,4) = i_-1;    %   GOTA ESTA TOCANDO EL BORDE (END PARTE A)
                        nivel(6) = true;    nivel(5) = false;
                   end
               clear t_img_vAe_ bw_ x_
               %%    
               elseif nivel(6) == true                      % APARECE EN EL BORDE UP REFLEJO
                   t_img_vBi_ = cortarimg(img_, vectBi_,false);
                   bw_ = binarizacion(t_img_vBi_,T_bw_,inv_);
    %                imshowpair(bw_,img_,'montage')
                   max_ = max(max(bw_));
                   imshow(img_)
                   if max_ == true
                        nivel(7) = true;    nivel(6) = false;
                   end
               clear t_img_vBi_ bw_ max_
               %%    
               elseif nivel(7) == true                      % GOTA COMPLETA EN EL REFLEJO   INDICE(5) (Inicio parte B)
                    t_img_vBi_ = cortarimg(img_, vectBi_,false);
                    bw_ = binarizacion(t_img_vBi_,T_bw_,inv_);
    %                 imshowpair(img_,t_img_vBi_,'montage')
                    x_ = estaenborde(bw_,true);
                    imshow(img_)
                    if x_ == false
                            indice_(j_,5) = i_; 
                            nivel(8) = true;    nivel(7) = false;
                    end
               clear t_img_vBi_ bw_ x_ 
               %%    
               elseif nivel(8) == true                      % GOTA EN EL TARGET
                   img_=img_+50;
                   img_(cc.PixelIdxList{s2maxpos(smaxp_)})= 0;
                   t_img_vBe_ = cortarimg(img_, vectBe_,false);
    %                imshowpair(img_,t_img_vBe_,'montage')
                   x_ = estaenborde(t_img_vBe_,false);
                   imshow(img_)
                   %  nivel(6) = true;     nivel(8) = false; Para saltar la
                   %  sombra
                   if x_ == true
                        nivel(9) = true;        nivel(8) = false;
                   end
               clear img_ t_img_vBe_ x_
               %%    
               elseif nivel(9) == true                          % GOTA CASI IMPACTA     INDICE(6,7) (Fin parte B, Inicio Parte C)             
                   img_=img_+50;
                   img_(cc.PixelIdxList{s2maxpos(smaxp_)})= 0;
                   t_img_vBe_ = cortarimg(img_, vectBe_,false);
    %                imshowpair(img_,t_img_vBe_,'montage')
                   x_ = estaenborde(t_img_vBe_,false);
                   imshow(img_)
                   if x_ == false
                        indice_(j_,6) = i_;    %   GOTA ESTA POR IMPACTAR (END PARTE B)
                        indice_(j_,7) = i_+1;  %   GOTA IMPACTÓ  (INI PARTE C)
                        nivel(10) = true;       nivel(9) = false;
                        imshow(img_)
                   end
               clear img_ img2_ t_img_vBe_ x_
               %%    
               elseif nivel(10) == true                         %GOTA EXPANDIENDOSE INICIO
                   t_img_vBe_ = cortarimg(img_, vectBe_,false);
                   img2_ = t_img_vBe_;
                   bw_=binarizacion(img2_,T_bw_,inv_);
                   imshowpair(img_,bw_,'montage')

                   pp_ = px2part(bw_);
                  if pp_(1) > 94.5
                       nivel(11) = true;        nivel(10) = false;
                       % nivel(12) = true;        nivel(10) = false;  nivel(10) = false;
                   end
               clear img_ t_img_vBe_ img2_ bw_ pp_
               %%    
               elseif nivel(11) == true                         %   LAMINA DE LA GOTA ROMPIENDOSE   INDICE(8,9) (Fin parte C, Lamina muy rota inicio parte D)
                   t_img_vBe_ = cortarimg(img_, vectBe_,false);
                    img2_ = t_img_vBe_;
                   bw_=binarizacion(img2_,T_bw_,inv_);
                    imshowpair(img_,bw_,'montage')
                   pp_ = px2part(bw_);
                   if pp_(1) < 93.5
                       indice_(j_,8) = i_;
                       indice_(j_,9) = i_+2;
                       nivel(12) = true;        nivel(11) = false;
                       imshow(img_)
                   end
               clear img_ t_img_vBe_ img2_ bw_ pp_
               %%
               elseif nivel(12) == true                         %   FRAGMENTACION   INDICE(10,11) (Fin de parte D, Fin del proceso)
                   
                   imgb_ = rgb2gray(imread(archivo_{i_+1}));
                   imgc_ = rgb2gray(imread(archivo_{i_+2}));
                   t_img_a_ = cortarimg(img_, vectE_,false);
                   t_img_b_ = cortarimg(imgb_,vectE_,false);
                   t_img_c_ = cortarimg(imgc_,vectE_,false);
                   cab_ = corr2(t_img_a_,t_img_b_);
                   cac_ = corr2(t_img_a_,t_img_c_);
                   cdif_ = cab_ - cac_;
                  imshow([t_img_a_,t_img_b_,t_img_c_])
    %               title(strcat('imagen A B C: correlacion A-B:',num2str(cab_),'   ;      Correlacion A-C:',num2str(cac_),'   <-->  ',num2str(cab_-cac_)))
                   if cdif_ <= 0.001
                       indice_(j_,10) = i_;
                       indice_(j_,11) = i_+4;
                       indice_(j_,12) = 1;
                       indice_(j_,13) = length(archivo_);                              %   INDICE(12,13) (Inicio y final del video.)
                       nivel(13) = true;        nivel(12) = false;
                       imshow(img_) 
                       pause
                   end
               clear img_ imgb_ imgc_ t_img_a_ t_img_b_ t_img_c_ cab_ cac_ cdif_
               %%
               elseif nivel(13) == true                             %   NO HAY MÁS QUE REVISAR (finalizo el proceso)
                   break
               else
                   fprintf(strcat('Hay un error en el video:  ',num2str(j_)))
                   indice_(j_,1:13) = 0; 
                   imshow(img_)
               end

            end
%%        
        file_archivo_ = strcat('indice\','ind_',files_(h_).name)
        save(file_archivo_,'indice_');
        clear indices_
            
    elseif test_ == false
        
       nivel(6) = true;
          
       for h_ = 1: length(video_);                                         % Bucle de los caso de estudio

        load(video_{h_});                                                   %   Abrel la lista de carpeta de los fotogramas

        for j_ = 28:length(folders_)                                         % Bucle de las carpetas con fotogramas

            porcentaje2_ = floor(j_/length(folders_)*100);
            disp(strcat(mesg1_,num2str(h_), mesg11_, ...
                 num2str(length(video_)), '    -->' ,...
                 mesg2_,num2str(porcentaje2_), ' %'));

            folder_drops_ = folders_{j_};
            archivo_ = leedir(folder_drops_, filetype_drops_ );             % Lee todos los tipos de archivos en la carpeta 

            img_ =imread(archivo_{1});                                      % Arriba  ind_
            im2_=rgb2gray(img_);
            img2_ = cortarimg(im2_, vect_,false);                           % en caso que necesites borrar una mancha que evite identificar el target

            bw_=binarizacion(img2_,T_bw_,inv_);                             % Ariiba T_bw_ inv_

            cc=bwconncomp(bw_, nun_cc_);
            [s2max, s2maxpos]=objectMaxSize(cc,T_O_);                       % Arriba T_O_

            bw1_ = object(bw_,cc.PixelIdxList{s2maxpos(1)});                % Copia el objeto más grande en bw1

            [centro,radii] = centre(bw1_);

            vectBe_ = floor([centro(1)-radii-c1_, centro(2)-radii-c2_ ...
                      ; centro(1)+radii+c1_, centro(2)+radii+c2_]);

            clear bw_ img_ img2_ bw1_
            
            for i_ = 1:length(archivo_)                                     % Bucle de los Fotogramas

               img_ = rgb2gray(imread(archivo_{i_}));
               
%                imshow(img_);

               if nivel(6) == true                                      % APARECE EN EL BORDE UP REFLEJO
                   t_img_vBi_ = cortarimg(img_, vectBi_,false);
                   bw_ = binarizacion(t_img_vBi_,T_bw_,inv_);
%                    imshow(img_)
%                    imshowpair(bw_,img_,'montage')
                   max_ = max(max(bw_));
                   if max_ == true
                        nivel(7) = true;    nivel(6) = false;
                   end
               clear t_img_vBi_ bw_ max_
               %%    
               elseif nivel(7) == true                                      % GOTA COMPLETA EN EL REFLEJO   INDICE(5) (Inicio parte B)
                    t_img_vBi_ = cortarimg(img_, vectBi_,false);
                    bw_ = binarizacion(t_img_vBi_,T_bw_,inv_);
                    imshow(img_)
    %                 imshowpair(img_,t_img_vBi_,'montage')
                    x_ = estaenborde(bw_,true);
                    if x_ == false
                            indices_(j_,5) = i_; 
                            nivel(8) = true;    nivel(7) = false;
                            close figure 1
                       end
               clear t_img_vBi_ bw_ x_ 
               %%    
               elseif nivel(8) == true                                      % GOTA EN EL TARGET
                   img_=img_+50;
                   img_(cc.PixelIdxList{s2maxpos(1)})= 0;
                   t_img_vBe_ = cortarimg(img_, vectBe_,false);
%                    imshowpair(img_,t_img_vBe_,'montage')
                   x_ = estaenborde(t_img_vBe_,false);
                   if x_ == true
                        nivel(9) = true;        nivel(8) = false;
                   end
               clear img_ t_img_vBe_ x_
               %%    
               elseif nivel(9) == true                                      % GOTA CASI IMPACTA     INDICE(6,7) (Fin parte B, Inicio Parte C)             
                   img_=img_+50;
                   img_(cc.PixelIdxList{s2maxpos(1)})= 0;
                   t_img_vBe_ = cortarimg(img_, vectBe_,false);
    %                imshowpair(img_,t_img_vBe_,'montage')
                   x_ = estaenborde(t_img_vBe_,false);
                   if x_ == false
                        indices_(j_,6) = i_;                                %   GOTA ESTA POR IMPACTAR (END PARTE B)
                        indices_(j_,7) = i_+1;                              %   GOTA IMPACTÓ  (INI PARTE C)
                        nivel(10) = true;       nivel(9) = false;
                   end
               clear img_ img2_ t_img_vBe_ x_
               %%    
               elseif nivel(10) == true                                     % GOTA EXPANDIENDOSE INICIO
                   t_img_vBe_ = cortarimg(img_, vectBe_,false);
                   img2_ = t_img_vBe_;
                   bw_=binarizacion(img2_,T_bw_,inv_);
                   pp_ = px2part(bw_);
                   if pp_(1) > 94.5
                       nivel(11) = true;        nivel(10) = false;
                   end
               clear img_ t_img_vBe_ img2_ bw_ pp_
               %%    
               elseif nivel(11) == true                                     % LAMINA DE LA GOTA ROMPIENDOSE   INDICE(8,9) (Fin parte C, Lamina muy rota inicio parte D)
                   t_img_vBe_ = cortarimg(img_, vectBe_,false);
                    img2_ = t_img_vBe_;
                   bw_=binarizacion(img2_,T_bw_,inv_);
                   pp_ = px2part(bw_);
                   if pp_(1) < 93.5
                       indices_(j_,8) = i_;
                       indices_(j_,9) = i_+2;
                       nivel(12) = true;        nivel(11) = false;
                   end
               clear img_ t_img_vBe_ img2_ bw_ pp_
               %%
               elseif nivel(12) == true                                     % FRAGMENTACION   INDICE(10,11) (Fin de parte D, Fin del proceso)
                   imgb_ = rgb2gray(imread(archivo_{i_+1}));
                   imgc_ = rgb2gray(imread(archivo_{i_+2}));
                   t_img_a_ = cortarimg(img_, vectE_,false);
                   t_img_b_ = cortarimg(imgb_,vectE_,false);
                   t_img_c_ = cortarimg(imgc_,vectE_,false);
                   cab_ = corr2(t_img_a_,t_img_b_);
                   cac_ = corr2(t_img_a_,t_img_c_);
                   cdif_ = cab_ - cac_;
    %               imshow([t_img_a_,t_img_b_,t_img_c_])
    %               title(strcat('imagen A B C: correlacion A-B:',num2str(cab_),'   ;      Correlacion A-C:',num2str(cac_),'   <-->  ',num2str(cab_-cac_)))
                   if cdif_ <= 0.001
                       indices_(j_,10) = i_;
                       indices_(j_,11) = i_+4;
                       indices_(j_,12) = 1;
                       indices_(j_,13) = length(archivo_);                  %   INDICE(12,13) (Inicio y final del video.)
                       nivel(13) = true;        nivel(12) = false;
                   end
               clear img_ imgb_ imgc_ t_img_a_ t_img_b_ t_img_c_ ...
                     cab_ cac_ cdif_
               %%
               elseif nivel(13) == true                                     % NO HAY MÁS QUE REVISAR (finalizo el proceso)
                   nivel(13) = false;
                   nivel(6) = true;
                   break
               else
                   fprintf(strcat('Hay un error en el video:  '...
                           ,num2str(j_)))
                   indices_(j_,1:13) = 0; 
               end
            
            end                                                             % Fin de bucle de los Fotogramas
                  
        end                                                                 % Fin de bucle de las capetas con fotogramas
        file_archivo_ = strcat('indice\','indi_',files_(h_).name(8:end))
        save(file_archivo_,'indices_');
        
    end
    
    
    end
end

