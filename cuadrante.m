
%%
clear
% clc
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%           CONTROL PRINCIPAL                          %%
%%

folder_drops_ = 'D:\Droplets Video\glicerina\48 cm\AVI\IMG\img-g48-1'; %Recore el diretorio
filetype_drops_ = 'jpg';% Tipo de Archivo

ind_ = 1;
centro_ = [129.2508 , 107.5139];% Centro 1er Ejemplo, Cambiar a referent point
nun_cc_ = 8;%(4o8)specifies the desired connectivivty for the connected components
T_bw_ = 70;% Maximo valor en binarización
inv_ = true;% inverso del binarizaciónm
T_O_= 50; %Numero de pixels para objetos grandes en la imagen
a_=6.875533829;% Área del target en mm^2

%%          CONTROL DE PARTE A DEL FENÓMENO
%%
 a_ini_ = 38;    a_end_ = 88;
 a_T_O_ = 40;    %Numero de pixels para objetos grandes en la imagen

%%          CONTROL DE PARTE B DEL FENÓMENO
%% 
 b_ini_ = 103;    b_end_ = 155;
 b_T_O_ = 70;
 
%%          CONTROL DE PARTE C DEL FENÓMENO
%% 
c_ini_ = 169;    c_end_ = 191;
c_T_O_ = 70;
c_T_vent_ =  10; % Tamaño de la ventana del cuadrante (arco) en 'cetre.m'
c_cuadrante_ = 1;% Parte del arco que quiere visualizar 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%             CENTRO DE LA PRIMERA IMAGEN   (target)                  %%                                                                    %%
%%

archivo = leedir(folder_drops_, filetype_drops_ );
    clear folder_drops_ filetype_drops_

i=imread(archivo{ind_});    % Arriba  ind_
i2=rgb2gray(i);
bw_=binarizacion(i2,T_bw_,inv_);    %Ariiba T_bw_ inv_

cc=bwconncomp(bw_, nun_cc_);

%   Los elementos más grandes segun su lista de pixel > Y               %

[s2max, s2maxpos]=objectMaxSize(cc,T_O_);  % Arriba T_O_

bw1 = object(bw_,cc.PixelIdxList{s2maxpos(1)});

[mm2Xpx,mmXpx,Tperimeter] = area(bw1,a_);% calcula la relación pixel mm target

[Tcentroids,Tradii] = centre(bw1);
    
    clear i ind_ i2 i bw_ cc s2max s2maxpos  bw1 
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % %%                          PARTE A DEL FENOMEN
% % %%                     MIDE LA VELOCIDAD DE LA GOTA
% 
% a_end_i_ = a_end_ -a_ini_;
% 
% a_table_(1:a_end_i_,1:5) = 0;  % Crea tabla de datos (# elementos, # columnas)
% a_table_(1,1) = 1/5400* a_ini_;
% a_in_=1;
% 
% a_archivo_=archivo(a_ini_:a_end_);
% 
% %     in_a_ = 38; % comienza en 38 termina en 88
%  for a_i_ = 1:a_end_i_;
%     
%     a_img_=imread(a_archivo_{a_i_});
% 
%     a2_img_=rgb2gray(a_img_);
%     a_bw_=binarizacion(a2_img_,70,true);
%   
%     a_cc_=bwconncomp(a_bw_, nun_cc_);
%     
% 
% %%%%        No es necesaria para el FOR  {Los elementos más grandes segun
% %%%%        su lista de pixel}
% [a_sa2max, a_sa2maxpos] = objectMaxSize(a_cc_,a_T_O_);
% %%%%            Calcula desplazamiento
% 
%   a_drop_ = object(a_bw_,a_cc_.PixelIdxList{a_sa2maxpos(2)});
%     [a_cen_,a_des_,a_diameters_] = desplazamiento(a_drop_,Tcentroids);
%     
% %%%
% %                  SAVE DATA
% 
%     
%     a_table_(a_in_,2)=a_diameters_;
%     a_table_(a_in_,3)=a_des_;
%     a_table_(a_in_,4)=a_cen_(1);
%     a_table_(a_in_,5)=a_cen_(2);
% 
%     if a_in_ ~= a_end_i_+1
%         a_table_(a_in_+1,1)= a_table_(a_in_,1)+1.8519e-04;
%     end
% 
% %%%                 SAVED DATA
% 
% %%%                 SHOW DATA
% 
%     a_radio_ = floor(a_diameters_/2);
% 
%     a_x_=-a_radio_:1:a_radio_;
%     a_y1=floor(a_cen_(2))-sqrt((a_radio_.^2)-a_x_.^2);
%     a_y2=floor(a_cen_(2))+sqrt((a_radio_.^2)-a_x_.^2);
%     a_x_= a_cen_(1)+a_x_;
% 
%     imshow(a_drop_)
% 
%     hold on
%     plot(centro_(1),centro_(2), 'b*')
%     plot(a_cen_(1),a_cen_(2),'b*')
%     plot(a_x_,a_y1,a_x_,a_y2)
%     hold off
%     a_in_=a_in_ + 1;
% %%%                 SHOWED DATA    
%  end
%  
% %%%%               VARIABLES INECESARIAS
%  
%     clear a_end_i_ a_in_ %inicio de sección A
%     clear a_i_ a_img_ a2_img_ a_bw_ a_cc_ a_sa2max a_sa2maxpos ...
%         a_drop_ a_cen_ a_des_ a_diameters_ %Calculo de las variables
%     clear a_radio_ a_x_ a_y1 a_y2 a_x_% Show data
% % 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%                      PARTE B DEL FENOMENO                            %%
% %%              MIDE LA VELOCIDAD DE LA GOTA y el diametro 
%       
% b_end_i_ = b_end_ -b_ini_;
% 
% b_table_(1:b_end_i_,1:5) = 0;  % Crea tabla de datos (# elementos, # columnas)
% b_table_(1,1) = 1/5400* b_ini_;
% b_in_=1;
% 
% b_archivo_=archivo(b_ini_:b_end_);
% 
% 
%   for b_i_ = 1:b_end_i_;
% %     b_i_n = 121; b_archivo_ = lee_archivos(b_i_n).name;% comienza en (2)103 120(1)121 termina en 155
%     
%     b_img_=imread(b_archivo_{b_i_});
% 
%     b2_img_=rgb2gray(b_img_);
%     b_bw_=binarizacion(b2_img_, T_bw_, inv_);
%     
%     b_cc_=bwconncomp(b_bw_, nun_cc_);
%    
% %%%%        No es necesaria para el FOR  {Los elementos más grandes segun
% %%%%        su lista de pixel}
% [b_sa2max, b_sa2maxpos] = objectMaxSize(b_cc_,b_T_O_);
% %%%%            Calcula desplazamiento y aisla el objeto de estudio
% 
% if b_i_ <= 1203
% b_drop_ = object(b_bw_,b_cc_.PixelIdxList{b_sa2maxpos(2)});
% elseif b_i_ > 120;
%   b_drop_ = object(b_bw_,b_cc_.PixelIdxList{b_sa2maxpos(1)});
% end 
% 
%     [b_cen_,b_des_,b_diameters_] = desplazamiento(b_drop_,centro_);
% 
% imshow(b_drop_)
% 
% %%%               SAVE DATA
% 
%     
%     b_table_(b_in_,2)=b_diameters_;
%     b_table_(b_in_,3)=b_des_;
%     b_table_(b_in_,4)=b_cen_(1);
%     b_table_(b_in_,5)=b_cen_(2);
% 
%     if b_in_ ~= b_end_i_+1
%         b_table_(b_in_+1,1)= b_table_(b_in_,1)+1.8519e-04;
%     end
%                 
% %%%             SAVED DATA
% 
% %%%                 SHOW DATA
%     
%     b_centroids_ = [b_cen_(1),b_cen_(2)];
%     b_radio_ = floor(b_diameters_/2);
% 
%     b_x=-b_radio_:1:b_radio_;
%     b_y1=floor(b_centroids_(2))-sqrt((b_radio_.^2)-b_x.^2);
%     b_y2=floor(b_centroids_(2))+sqrt((b_radio_.^2)-b_x.^2);
%     b_x= b_centroids_(1)+b_x;
% 
%     imshow(b_drop_)
% 
%     hold on
%     plot(centro_(1),centro_(2), 'b*')
%     plot(b_centroids_(1),b_centroids_(2),'b*')
%     plot(b_x,b_y1,b_x,b_y2)
%     hold off
%     b_in_=b_in_ + 1;
%  %%%            SHOWED DATA
%  
%   end
% 
%     clear b_end_i b_in_
%     clear b_i_ b_img_ b2_img_ b_bw_ b_cc_ b_sa2max b_sa2maxpos...
%         b_drop_ b_cen_ b_des_ b_diameters_
%     clear b_centroids_ b_radio_ b_x b_y1 b_y2 b_x

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                      PARTE C DEL FENOMENO                            %%
%%            MIDE EL ESPARCIMIENTO DE LA GOTA (Corrección proyectiva) 169 - 191
      
c_end_i_ = c_end_ - c_ini_;

c_table_(1:c_end_i_,1:5) = 0;  % Crea tabla de datos (# elementos, # columnas)
c_table_(1,1) = 1/5400* c_ini_;
c_in_=1;

c_archivo_=archivo(c_ini_:c_end_);


%   for c_i_ = 1:c_end_i_;
c_i_ = 5;
%     b_i_n = 121; b_archivo_ = lee_archivos(b_i_n).name;% comienza en (2)103 120(1)121 termina en 155
    
    c_img_=imread(c_archivo_{c_i_});

    c2_img_=rgb2gray(c_img_);
    c_bw_=binarizacion(c2_img_, T_bw_, inv_);
    
    c_cc_=bwconncomp(c_bw_, nun_cc_); 
   
%%%%        No es necesaria para el FOR  {Los elementos más grandes segun
%%%%        su lista de pixel}
[c_sa2max, c_sa2maxpos] = objectMaxSize(c_cc_,c_T_O_);
%%%%            Calcula desplazamiento y aisla el objeto de estudio
c_drop_ = object(c_bw_,c_cc_.PixelIdxList{c_sa2maxpos(1)});

[c_copy1_rad, c_copy2_rad, c_copy3_rad] = radial(c_drop_,c_archivo_,c_i_,Tcentroids,c_T_vent_, c_cuadrante_);

subplot(3,2,1), imshow(c_copy1_rad),    title('img 1')
subplot(3,2,2), surf(c_copy1_rad),      title('surf img 1')
subplot(3,2,3), imshow(c_copy2_rad),    title('img 2')
subplot(3,2,4), surf(c_copy2_rad),      title('surf img 2')
subplot(3,2,5), imshow(c_copy3_rad),    title('img 3') 
subplot(3,2,6), surf(c_copy3_rad),      title('surf img 3')

%%%%%%%%%%%% GRAFICAR EN RADIAL EL CENTRO EN LA COPIA
%%%%%%%%%%%% MEDIR EL ESPARCIMIENTO DEL CENTRO A CADA PIXEL.

% if c_i_ <= 1203
% c_drop_ = object(c_bw_,c_cc_.PixelIdxList{c_sa2maxpos(2)});
% elseif c_i_ > 120;
%   c_drop_ = object(c_bw_,c_cc_.PixelIdxList{c_sa2maxpos(1)});
% end 
% 
%     [c_cen_,c_des_,c_diameters_] = desplazamiento(c_drop_,centro_);
% 
% imshow(c_drop_)
% 
% %%%               SAVE DATA
% 
%     
%     c_table_(c_in_,2)=c_diameters_;
%     c_table_(c_in_,3)=c_des_;
%     c_table_(c_in_,4)=c_cen_(1);
%     c_table_(c_in_,5)=c_cen_(2);
% 
%     if c_in_ ~= c_end_i_+1
%         c_table_(c_in_+1,1)= c_table_(c_in_,1)+1.8519e-04;
%     end
%                 
% %%%             SAVED DATA
% 
% %%%                 SHOW DATA
%     
%     c_centroids_ = [c_cen_(1),c_cen_(2)];
%     c_radio_ = floor(c_diameters_/2);
% 
%     c_x=-c_radio_:1:c_radio_;
%     c_y1=floor(c_centroids_(2))-sqrt((c_radio_.^2)-c_x.^2);
%     c_y2=floor(c_centroids_(2))+sqrt((c_radio_.^2)-c_x.^2);
%     c_x= c_centroids_(1)+c_x;
% 
%     imshow(c_drop_)
% 
%     hold on
%     plot(centro_(1),centro_(2), 'b*')
%     plot(c_centroids_(1),c_centroids_(2),'b*')
%     plot(c_x,c_y1,c_x,b_y2)
%     hold off
%     c_in_=c_in_ + 1;
%  %%%            SHOWED DATA
%  
% %   end
% 
%  clear c_end_i c_in_
% clear c_i_ c_img_ c2_img_ c_bw_ c_cc_ c_sa2max c_sa2maxpos...
%     c_drop_ c_cen_ c_des_ c_diameters_
% clear c_centroids_ c_radio_ c_x c_y1 c_y2 c_x

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%






%  
%  
%  
% % 
% 
% %   Separa las imagenes en los differentes cuadrantes de la imagen.
% 
% %img_cI_ = i2(1:centre(2),centre(1):length(i));
% %  img_cII_ = i2(1:centre(2),1:centre(1));
% % img_cIII_= i2(centre(2):length(i),1:centre(1));
% % img_cIV_= i2(centre(2):length(i),centre(1):length(i));
% %%%%%%%%%%%%%%%%%%%%%% SOLO PARA EL PRIMER VIDEO %%%%%%%%%%%%%
% % img_cI_ = i2(1:107,129:length(i));
% %  img_cII_ = i2(1:107,1:129);
% % img_cIII_= i2(107:length(i),1:129);
% % img_cIV_= i2(107:length(i),129:length(i));
% % img_cI_II_ = i2(1:107,1:length(i));
% % %%%%        Medida de caida y angulo de espejo
% % ini_b_ = 103;   end_b_ = 154;
% % 
% % for i_ = ini_b_ : end_b_;
% %     
% %     
% % end
% % 
% % %%%%        Medida del esparcimiento
% % 
% % ini_c_ = 169;   end_c_ = 189;
% % 
% % for j_ = ini_c_ : end_c_
% %     
% %     
% % 
% % end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %                       F   I   N
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% 
% % % table(1:fin_,1:6) = 0;  % Crea tabla de datos (# elementos, # columnas)
% % % table(1,1) = 1/5400* since_;
% % % ind_=1;
% %  %%%%         Copia el objeto los dos objetos más grandes del la imagen original
% %  
% % 
% % % bw2 = object(bw_inv,cc.PixelIdxList{s2maxpos(2)});
% % 
% % %%%%        Separar en cuadrantes la imagen desde el centroide
% % 
% % stats1 = regionprops('table',bw1,'Centroid','MajorAxisLength','MinorAxisLength');%Calcula regiones con pizeles blancos
% % % stats2 = regionprops('table',bw2,'Centroid','MajorAxisLength','MinorAxisLength');
% % % centroids = cat(1, stats1.Centroid,stats2.Centroid);
% % 
% % 
% % 
% % %%%%        Plotear rádeo
% % 
% % 
% % centre = floor(centroids);
% % 
% % 
% % % imshow(img_cI_II_)
% % imshow(i)
% %  hold on
% %  plot(centre(1),centre(2), 'b*')
% %  plot(x,y1,x,y2)
% %  hold off
% % 
% % 
% % % 
% % % 
% % % 
% % %     for(i_=since_:end_)
% % %                 
% % %        
% % % 
% % %         i2=rgb2gray(i);
% % %         bw1=binarizacion(i2,70);
% % %         bw3 = imcomplement(bw1);
% % % 
% % %         cc=bwconncomp(bw3,4);
% % %         cc.NumObjects;
% % %         drop = object(bw3,cc.PixelIdxList{1});
% % % 
% % % 
% % % %         [center,Tradii]= centre(bw3);
% % %         [area,centre_j,centre_i,perimeter,Tradii] = centre(bw3);
% % % 
% % %         table(ind_,2)=Tradii;
% % %         table(ind_,3)=perimeter;
% % %         table(ind_,4)=area;
% % %         table(ind_,5)=centre_i;
% % %         table(ind_,6)=centre_j;
% % %         
% % %         if ind_+1 ~= fin_+1
% % %         table(ind_+1,1)= table(ind_,1)+1.8519e-04;
% % %         end
% % %         ind_=ind_ + 1;
% % %     end
