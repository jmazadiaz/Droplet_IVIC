clear
% clc

nombre='D:\Droplets Video\glicerina\48 cm\AVI\IMG\img-g48-1\'; %Recore el diretorio
ruta=strcat(nombre,'*.jpg');%concatena el directorio con la extesion de los archivos
lee_archivos = dir(ruta); %el formato de imagen puede ser modificado.

ind_ = 1;

centro_ = [129.2508 , 107.5139];

archivo = lee_archivos(ind_).name;
i=imread(strcat(nombre,archivo));

i2=rgb2gray(i);
bw_ini_=binarizacion(i2,70);
bw_inv = imcomplement(bw_ini_);

cc=bwconncomp(bw_inv, 8);
cc.NumObjects;

%%%%        Los elementos más grandes segun su lista de pixel

C = vertcat(cc.PixelIdxList);
num_elem_(1:cc.NumObjects) = 0; 

%%%     Separa elementos con mas de 50 puntos
for i_ = 1:cc.NumObjects
    M = cell2mat(C(i_));
    [tnum_elem_(i_),~] = size(M);
    if tnum_elem_(i_)>50
        num_elem_(i_) = tnum_elem_(i_);
    else
        num_elem_(i_) = 0;
    end
end
    clear i_ M tnum_elem_(i_);
%%%%%%%%%%%%%%                  %%%%%%%%%%%%%%  
[n_e_,orden] = sort(num_elem_,'descend');
 s2max = n_e_(1:5);
 s2maxpos = orden(1:5);
% end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


bw1 = object(bw_inv,cc.PixelIdxList{s2maxpos(1)});
[mm2Xpx,mmXpx,perimeter] = area(bw1);% calcula la relación pixel mm target

[cen_i,cen_j,radii] = centre(bw1);

centroids = [cen_i,cen_j];


%%%%%%%%%%%%%%%%%%%         PARTE A DEL FENOMENO        %%%%%%%%%%%%%%%%%%%
%%%%%       MIDE LA VELOCIDAD DE LA GOTA

%   a_ini_ = 38;    a_end_ = 88;
% 
% a_end_i_ = a_end_ -a_ini_;
% % sa2maxpos=[1     7     2     3     4     5];% Calcular una vez en la identificacion auto-gota
% 
% a_table_(1:a_end_i_,1:5) = 0;  % Crea tabla de datos (# elementos, # columnas)
% a_table_(1,1) = 1/5400* a_ini_;
% a_in_=1;

%  for a_i_ = a_ini_:a_end_;
% %     in_a_ = 38; % comienza en 38 termina en 88
%     
%     a_archivo_ = lee_archivos(a_i_).name;
%     a_img_=imread(strcat(nombre,a_archivo_));
% 
%     a2_img_=rgb2gray(a_img_);
%     a_bw_ini_=binarizacion(a2_img_,70);
%     a_bw_inva_ = imcomplement(a_bw_ini_);
% 
%     a_cc_=bwconncomp(a_bw_inva_, 8);
%     a_cc_.NumObjects;
% 
% 
%   
% %%%%        No es necesaria para el FOR  {Los elementos más grandes segun
% %%%%        su lista de pixel}
% cuadrante_on_a
% %%%%            Calcula desplazamiento
% 
%   a_drop_ = object(a_bw_inva_,a_cc_.PixelIdxList{a_sa2maxpos(2)});
%     [a_cen_i_,a_cen_j_,a_des_,a_diameters_] = desplazamiento(a_drop_,centro_);
% 
% 
% 
% %%%%   Datos a guardar
% 
%     
%     a_table_(a_in_,2)=a_diameters_;
%     a_table_(a_in_,3)=a_des_;
%     a_table_(a_in_,4)=a_cen_i_;
%     a_table_(a_in_,5)=a_cen_j_;
% 
%     if a_in_ ~= a_end_i_+1
%         a_table_(a_in_+1,1)= a_table_(a_in_,1)+1.8519e-04;
%     end
%    
%     a_centroids_ = [a_cen_i_,a_cen_j_];
%     a_radio_ = floor(a_diameters_/2);
% 
%     a_x=-a_radio_:1:a_radio_;
%     a_y1=floor(a_centroids_(2))-sqrt((a_radio_.^2)-a_x.^2);
%     y2=floor(a_centroids_(2))+sqrt((a_radio_.^2)-a_x.^2);
%     a_x= a_centroids_(1)+a_x;
% 
%     imshow(a_drop_)
% 
%     hold on
%     plot(centro_(1),centro_(2), 'b*')
%     plot(a_centroids_(1),a_centroids_(2),'b*')
%     plot(a_x,a_y1,a_x,y2)
%     hold off
%     a_in_=a_in_ + 1;
%  end
 
 
%%%%%%%%%%%%%%%%%%%         PARTE B DEL FENOMENO        %%%%%%%%%%%%%%%%%%%
%%%%%       MIDE LA VELOCIDAD DE LA GOTA y el diametro 
 
b_ini_ = 103;    b_end_ = 155;

b_end_i_ = b_end_ -b_ini_;
% sa2maxpos=[1     7     2     3     4     5];% Calcular una vez en la identificacion auto-gota

b_table_(1:b_end_i_,1:5) = 0;  % Crea tabla de datos (# elementos, # columnas)
b_table_(1,1) = 1/5400* b_ini_;
b_in_=1;

  for b_i_ = b_ini_:b_end_;
%     b_i_n = 121; b_archivo_ = lee_archivos(b_i_n).name;% comienza en (2)103 120(1)121 termina en 155
    
    
    b_archivo_ = lee_archivos(b_i_).name;
    b_img_=imread(strcat(nombre,b_archivo_));

    b2_img_=rgb2gray(b_img_);
    b_bw_ini_=binarizacion(b2_img_,70);
    b_bw_inva_ = imcomplement(b_bw_ini_);

    b_cc_=bwconncomp(b_bw_inva_, 8);
    b_cc_.NumObjects;


  
%%%%        No es necesaria para el FOR  {Los elementos más grandes segun
%%%%        su lista de pixel}
cuadrante_on_b
%%%%            Calcula desplazamiento y aisla el objeto de estudio

if b_i_ <= 1203
b_drop_ = object(b_bw_inva_,b_cc_.PixelIdxList{b_sa2maxpos(2)});
elseif b_i_ > 120;
  b_drop_ = object(b_bw_inva_,b_cc_.PixelIdxList{b_sa2maxpos(1)});
end 

    [cen_i,cen_j,des_,diameters_a] = desplazamiento(b_drop_,centro_);

imshow(b_drop_)

%%%%   Datos a guardar

    
    b_table_(b_in_,2)=diameters_a;
    b_table_(b_in_,3)=des_;
    b_table_(b_in_,4)=cen_i;
    b_table_(b_in_,5)=cen_j;

    if b_in_ ~= b_end_i_+1
        b_table_(b_in_+1,1)= b_table_(b_in_,1)+1.8519e-04;
    end
   
    b_centroids_ = [cen_i,cen_j];
    b_radio_ = floor(diameters_a/2);

    x=-b_radio_:1:b_radio_;
    y1=floor(b_centroids_(2))-sqrt((b_radio_.^2)-x.^2);
    y2=floor(b_centroids_(2))+sqrt((b_radio_.^2)-x.^2);
    x= b_centroids_(1)+x;

    imshow(b_drop_)

    hold on
    plot(centro_(1),centro_(2), 'b*')
    plot(b_centroids_(1),b_centroids_(2),'b*')
    plot(x,y1,x,y2)
    hold off
    b_in_=b_in_ + 1;
 end

 
 
 
% 

%   Separa las imagenes en los differentes cuadrantes de la imagen.

%img_cI_ = i2(1:centre(2),centre(1):length(i));
%  img_cII_ = i2(1:centre(2),1:centre(1));
% img_cIII_= i2(centre(2):length(i),1:centre(1));
% img_cIV_= i2(centre(2):length(i),centre(1):length(i));
%%%%%%%%%%%%%%%%%%%%%% SOLO PARA EL PRIMER VIDEO %%%%%%%%%%%%%
% img_cI_ = i2(1:107,129:length(i));
%  img_cII_ = i2(1:107,1:129);
% img_cIII_= i2(107:length(i),1:129);
% img_cIV_= i2(107:length(i),129:length(i));
% img_cI_II_ = i2(1:107,1:length(i));
% %%%%        Medida de caida y angulo de espejo
% ini_b_ = 103;   end_b_ = 154;
% 
% for i_ = ini_b_ : end_b_;
%     
%     
% end
% 
% %%%%        Medida del esparcimiento
% 
% ini_c_ = 169;   end_c_ = 189;
% 
% for j_ = ini_c_ : end_c_
%     
%     
% 
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       F   I   N
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% % table(1:fin_,1:6) = 0;  % Crea tabla de datos (# elementos, # columnas)
% % table(1,1) = 1/5400* since_;
% % ind_=1;
%  %%%%         Copia el objeto los dos objetos más grandes del la imagen original
%  
% 
% % bw2 = object(bw_inv,cc.PixelIdxList{s2maxpos(2)});
% 
% %%%%        Separar en cuadrantes la imagen desde el centroide
% 
% stats1 = regionprops('table',bw1,'Centroid','MajorAxisLength','MinorAxisLength');%Calcula regiones con pizeles blancos
% % stats2 = regionprops('table',bw2,'Centroid','MajorAxisLength','MinorAxisLength');
% % centroids = cat(1, stats1.Centroid,stats2.Centroid);
% 
% 
% 
% %%%%        Plotear rádeo
% 
% 
% centre = floor(centroids);
% 
% 
% % imshow(img_cI_II_)
% imshow(i)
%  hold on
%  plot(centre(1),centre(2), 'b*')
%  plot(x,y1,x,y2)
%  hold off
% 
% 
% % 
% % 
% % 
% %     for(i_=since_:end_)
% %                 
% %        
% % 
% %         i2=rgb2gray(i);
% %         bw1=binarizacion(i2,70);
% %         bw3 = imcomplement(bw1);
% % 
% %         cc=bwconncomp(bw3,4);
% %         cc.NumObjects;
% %         drop = object(bw3,cc.PixelIdxList{1});
% % 
% % 
% % %         [center,radii]= centre(bw3);
% %         [area,centre_j,centre_i,perimeter,radii] = centre(bw3);
% % 
% %         table(ind_,2)=radii;
% %         table(ind_,3)=perimeter;
% %         table(ind_,4)=area;
% %         table(ind_,5)=centre_i;
% %         table(ind_,6)=centre_j;
% %         
% %         if ind_+1 ~= fin_+1
% %         table(ind_+1,1)= table(ind_,1)+1.8519e-04;
% %         end
% %         ind_=ind_ + 1;
% %     end