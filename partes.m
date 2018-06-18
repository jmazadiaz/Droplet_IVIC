%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   
%   Nivel(1) = Condición: 2 imanes anagenes antes del aparecer la gota
%   Nivel(2) = Aparece la gota en la imagen.
%   Nivel(3) = Inicio de parte A, toda la gota en la pantalla arriba.
%   Nivel(4) = Condición: Gota aparece en la imagen abajo.
%   Nivel(5) = Condición: la gota esta fuera del borde.
%   Nivel(6) = Fin de parte A -> La gota casi sale del cuadro, abajo.
%   Nivel(7) = Condición: La gota aparece en imagen, arriba derecha (AD).
%   Nivel(8) = Inicio de parte B -> Toda la gota en la image AD.
%   Nivel(9) = Condición: La gota aparece en la imagen, Centroid + r + 3px (CR1)
%   Nivel(10)= Fin de parte B +1 inicio Parte C -> Toda la gota en la imagen CR1.
%   Nivel(11)= Condición: Toda la imagen CR1 negra.
%   Nivel(12)= Fin de parte C -> Aparece un picel banco en la imagen CR1
%   Nivel(13)= fin de parte C e inicio parte D -> las cuatros imagnes sucesivas.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
close all
%%  Constantes

T_bw_ = 70;% Maximo valor en binarización
inv_ = true;% inverso del binarizaciónm
nun_cc_ = 8;%(4o8)specifies the desired connectivivty for the connected components
T_O_= 50; %Numero de pixels para objetos grandes en la imagen

% vectAi_= [1,1;90,50]; % Recuadro superior Izquierdo
vectAi_ = [70,1;150,50];
vectAe_ = [69,95;162,125]; % Recuadro Inferior izquierdo
vectBi_= [70,1;150,50]; % Recuadro superior central
vectE_ = [40,40;240,250];   % Recuadro central

indices_(1:13) = 0; 

folfer_video_ = 'D:\Dropbox\Droplets\Matlab\Droplets\mat';
mesg1_='Caso  :  ';
mesg11_ = '   /   ';
mesg2_='       Porcentaje de videos  :  '; 
filetype_video_ = 'mat';

dir_ = strcat(folfer_video_,'\*.',filetype_video_);
files_ = dir(dir_);


% folder_drops_ = 'D:\Droplets Video\glicerina\48 cm\AVI\IMG\img-g48-1'; %Recore el diretorio
 filetype_drops_ = 'jpg';% Tipo de Archivo 

video_= leedir(folfer_video_, filetype_video_ ); % Lee todos los tipos de archivo mat con al informacion de los videos
%%  Procesos
% archivo_ = leedir(folder_drops_, filetype_drops_ );  % Lee todos los tipos de archivos en la carpeta 
%for h_ = 3: length(video_);   
for h_ = 3: 3;      
    
    load(video_{h_});
    
    
    for j_ = 1:length(folders_)
                    
        porcentaje2_ = floor(j_/length(folders_)*100);
        disp(strcat(mesg1_,num2str(h_), mesg11_, num2str(length(video_)), '    -->' ,mesg2_,num2str(porcentaje2_), ' %'));
        
        nivel(1:13) = false;
        nivel(1) = true;
        
        folder_drops_ = folders_{j_};
        archivo_ = leedir(folder_drops_, filetype_drops_ );  % Lee todos los tipos de archivos en la carpeta 

        img_ =imread(archivo_{1});    % Arriba  ind_
        img2_=rgb2gray(img_);

        bw_=binarizacion(img2_,T_bw_,inv_);    %Ariiba T_bw_ inv_

        cc=bwconncomp(bw_, nun_cc_);
        [s2max, s2maxpos]=objectMaxSize(cc,T_O_);  % Arriba T_O_

        bw1_ = object(bw_,cc.PixelIdxList{s2maxpos(1)}); % Copia el objeto más grande en bw1

        [centro,radii] = centre(bw1_);

        vectBe_ = floor([centro(1)-radii-4, centro(2)-radii-3 ; centro(1)+radii+4, centro(2)+radii+3]);

    %     j_ = 1;

        clear bw_ img_ img2_ bw1_
        
        for i_ = 1:length(archivo_)

           img_ = rgb2gray(imread(archivo_{i_}));
           
           %%
           if nivel(1) == true                          % LA GOTA APARECE       INDICE(1,2) (Ini, Fin parte 0)
              t_img_vAi_ = cortarimg(img_,vectAi_,false);
              bw_ = binarizacion(t_img_vAi_,T_bw_,inv_);
%               imshowpair(img_,bw_,'montage')
              max_ = max(max(bw_));
              if max_ == true
                  indices_(j_,1) = i_-2;   %       ANTES DE APARECER LA GOTA
                  indices_(j_,2) = i_;     %       APARECE LA GOTA
                  nivel(2) = true;      nivel(1) = false;
               end
           clear t_img_vAi_ bw_ max_
           %%                                                                   
           elseif nivel(2) == true                     % LA GOTA COMPLETA ARRIBA  INDICE(3) (Inicio parte A)
               t_img_vAi_ = cortarimg(img_,vectAi_,false);
%              imshow(t_img_vAi_)
               bw_ = binarizacion(t_img_vAi_,T_bw_,inv_);
               x_ = estaenborde(bw_,true);
               if x_ == false
                   indices_(j_,3) = i_;    %   TODA LA GOTA ARRIBA (INI PARTE A)
                   nivel(3) = true;     nivel(2) = false;
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
                if x_ == false
                    nivel(5) = true;     nivel(4) = false;
                end
           clear t_img_vAe_ bw_ x_
           %%     
           elseif nivel(5) == true                      % ESTA EN EL BORDE DOWN   INDICE(4) (Fin parte A)
               t_img_vAe_ = cortarimg(img_,vectAe_,false);
               bw_ = binarizacion(t_img_vAe_,T_bw_,inv_);
%              imshowpair(t_img_vAe_,img_,'montage')
               x_ = estaenborde(bw_,true);
               if x_ == true
                    indices_(j_,4) = i_-1;    %   GOTA ESTA TOCANDO EL BORDE (END PARTE A)
                    nivel(6) = true;    nivel(5) = false;
               end
           clear t_img_vAe_ bw_ x_
           %%    
           elseif nivel(6) == true                      % APARECE EN EL BORDE UP REFLEJO
               t_img_vBi_ = cortarimg(img_, vectBi_,false);
               bw_ = binarizacion(t_img_vBi_,T_bw_,inv_);
%                imshowpair(bw_,img_,'montage')
               max_ = max(max(bw_));
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
                if x_ == false
                    indices_(j_,5) = i_; 
                    nivel(8) = true;    nivel(7) = false;
               end
           clear t_img_vBi_ bw_ x_ 
           %%    
           elseif nivel(8) == true                      % GOTA EN EL TARGET
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
           elseif nivel(9) == true                          % GOTA CASI IMPACTA     INDICE(6,7) (Fin parte B, Inicio Parte C)             
               img_=img_+50;
               img_(cc.PixelIdxList{s2maxpos(1)})= 0;
               t_img_vBe_ = cortarimg(img_, vectBe_,false);
%                imshowpair(img_,t_img_vBe_,'montage')
               x_ = estaenborde(t_img_vBe_,false);
               if x_ == false
                    indices_(j_,6) = i_;    %   GOTA ESTA POR IMPACTAR (END PARTE B)
                    indices_(j_,7) = i_+1;  %   GOTA IMPACTÓ  (INI PARTE C)
                    nivel(10) = true;       nivel(9) = false;
               end
           clear img_ img2_ t_img_vBe_ x_
           %%    
           elseif nivel(10) == true                         %GOTA EXPANDIENDOSE INICIO
               t_img_vBe_ = cortarimg(img_, vectBe_,false);
               img2_ = t_img_vBe_;
               bw_=binarizacion(img2_,T_bw_,inv_);
               pp_ = px2part(bw_);
               if pp_(1) > 94.5
                   nivel(11) = true;        nivel(10) = false;
               end
           clear img_ t_img_vBe_ img2_ bw_ pp_
           %%    
           elseif nivel(11) == true                         %   LAMINA DE LA GOTA ROMPIENDOSE   INDICE(8,9) (Fin parte C, Lamina muy rota inicio parte D)
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
           elseif nivel(12) == true                         %   FRAGMENTACION   INDICE(10,11) (Fin de parte D, Fin del proceso)
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
                   indices_(j_,13) = length(archivo_);                              %   INDICE(12,13) (Inicio y final del video.)
                   nivel(13) = true;        nivel(12) = false;
               end
           clear img_ imgb_ imgc_ t_img_a_ t_img_b_ t_img_c_ cab_ cac_ cdif_
           %%
           elseif nivel(13) == true                             %   NO HAY MÁS QUE REVISAR (finalizo el proceso)
               break
           else
               fprintf(strcat('Hay un error en el video:  ',num2str(j_)))
               indices_(j_,1:13) = 0; 
           end

        end
        save(files_(h_).name,'indices_');
        %clear indices_
    end
end