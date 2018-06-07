%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   
%   Nivel(1) = Condición: 2 imanes anagenes antes del aparecer la gota
%   Nivel(2) = Inicio de parte A, toda la gota en la pantalla arriba.
%   Nivel(3) = Condición: Gota aparece en la imagen abajo.
%   Nivel(4) = Condición: la gota esta fuera del borde.
%   Nivel(5) = Fin de parte A -> La gota casi sale del cuadro, abajo.
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
folder_drops_ = 'D:\Droplets Video\glicerina\48 cm\AVI\IMG\img-g48-1'; %Recore el diretorio
filetype_drops_ = 'jpg';% Tipo de Archivo

T_bw_ = 70;% Maximo valor en binarización
inv_ = true;% inverso del binarizaciónm
nun_cc_ = 8;%(4o8)specifies the desired connectivivty for the connected components
T_O_= 50; %Numero de pixels para objetos grandes en la imagen

vectAi_= [1,1;90,50];
vectAe_ = [1,206;90,256];
vectBi_= [70,1;150,50];
vectE_ = [40,40;240,250];

nivel(1:13)=false;
nivel(1) = true;

indices_(1:9) = 0; 
 
%%  Procesos

archivo_ = leedir(folder_drops_, filetype_drops_ );  % Lee todos los tipos de archivos en la carpeta 

img_ =imread(archivo_{1});    % Arriba  ind_
img2_=rgb2gray(img_);

bw_=binarizacion(img2_,T_bw_,inv_);    %Ariiba T_bw_ inv_

cc=bwconncomp(bw_, nun_cc_);
[s2max, s2maxpos]=objectMaxSize(cc,T_O_);  % Arriba T_O_

bw1_ = object(bw_,cc.PixelIdxList{s2maxpos(1)}); % Copia el objeto más grande en bw1

[centro,radii] = centre(bw1_);

vectBe_ = floor([centro(1)-radii-4, centro(2)-radii-3 ; centro(1)+radii+4, centro(2)+radii+3]);


j_ = 1;

clear bw_ img_ img2_ bw1_

for i_ = 1:length(archivo_)
    
   img_ = imread(archivo_{i_});
   
   if nivel(1) == true
       t_img_vAi_ = cortarimg(img_,vectAi_);
       img2_=rgb2gray(t_img_vAi_);
       bw_=binarizacion(img2_,T_bw_,inv_);    %Ariiba T_bw_ inv_
%       imshowpair(img_,bw_,'montage')
       max_ = max(max(bw_));
       if max_ == true
           indices_(j_,1) = i_-2;   %       ANTES DE APARECER LA GOTA
           indices_(j_,2) = i_;     %       APARECE LA GOTA
           nivel(2) = true;
           nivel(1) = false;
       end
       clear t_img_vAi_ img2_ bw_ max_
   elseif nivel(2) == true
       t_img_vAi_ = cortarimg(img_,vectAi_);
 %        imshow(t_img_vAi_)
       x_ = estaenborde(t_img_vAi_,false);
        if x_ == false
            indices_(j_,3) = i_;    %   TODA LA GOTA ARRIBA (INI PARTE A)
            nivel(3) = true;
            nivel(2) = false;
        end
        clear t_img_vAi_ x_
   elseif nivel(3) == true
       t_img_vAe_ = cortarimg(img_,vectAe_);
       img2_=rgb2gray(t_img_vAe_);
       bw_=binarizacion(img2_,T_bw_,inv_);    %Ariiba T_bw_ inv_
%      imshowpair(img_,bw_,'montage')
       max_ = max(max(bw_));
       if max_ == true
           nivel(4) = true;
           nivel(3) = false;
       end
       clear t_img_vAe_ img2_ bw_ max_
   elseif nivel(4) == true 
       t_img_vAe_ = cortarimg(img_,vectAe_);
%         imshowpair(t_img_vBe_,img_,'montage')
       x_ = estaenborde(t_img_vAe_,false);
        if x_ == false
            nivel(5) = true;
            nivel(4) = false;
        end
        clear t_img_vAe_ x_
   elseif nivel(5) == true    
       t_img_vAe_ = cortarimg(img_,vectAe_);
 %        imshowpair(t_img_vAe_,img_,'montage')
       x_ = estaenborde(t_img_vAe_,false);
       if x_ == true
            indices_(j_,4) = i_-1;    %   GOTA CASI POR DESAPARECER (END PARTE A)
            nivel(6) = true;
            nivel(5) = false;
       end
       clear t_img_vAe_ x_
   elseif nivel(6) == true
       t_img_vBi_ = cortarimg(img_, vectBi_);
       img2_=rgb2gray(t_img_vBi_);
       bw_=binarizacion(img2_,T_bw_,inv_);    %Ariiba T_bw_ inv_
%       imshowpair(img_,bw_,'montage')
       max_ = max(max(bw_));
       if max_ == true
            nivel(7) = true;
            nivel(6) = false;
       end
       clear t_img_vB_ img2_ bw_ max_
   elseif nivel(7) == true
        t_img_vBi_ = cortarimg(img_, vectBi_);
%        imshowpair(img_,t_img_vBi_,'montage')
        x_ = estaenborde(t_img_vBi_,false);
        if x_ == false
            indices_(j_,4) = i_-1;    %   GOTA APARECE REFLEJO (INI PARTE B)
            nivel(8) = true;
            nivel(7) = false;
       end
       clear t_img_vB_ x_
   elseif nivel(8) == true
       img_=img_+50;
       img2_=rgb2gray(img_);
       img2_(cc.PixelIdxList{s2maxpos(1)})= 0;
       clear img_
       img_(:,:,1)= img2_;     img_(:,:,2)= img2_;      img_(:,:,3)= img2_;
       t_img_vBe_ = cortarimg(img_, vectBe_);
%      imshowpair(img_,t_img_vBe_,'montage')
       x_ = estaenborde(t_img_vBe_,false);
       if x_ == true
            nivel(9) = true;
            nivel(8) = false;
       end
       clear img_ img2_ img2_ t_img_vBe_ x_
   elseif nivel(9) == true   
       img_=img_+50;
       img2_=rgb2gray(img_);
       img2_(cc.PixelIdxList{s2maxpos(1)})= 0;
       clear img_
       img_(:,:,1)= img2_; 
       img_(:,:,2)= img2_; 
       img_(:,:,3)= img2_;
       t_img_vBe_ = cortarimg(img_, vectBe_);
%        imshowpair(img_,t_img_vBe_,'montage')
       x_ = estaenborde(t_img_vBe_,false);
       if x_ == false
            indices_(j_,5) = i_;    %   GOTA ESTA POR IMPACTAR (END PARTE B)
            indices_(j_,6) = i_+1;  %   GOTA IMPACTÓ  (INI PARTE C)
            nivel(10) = true;
            nivel(9) = false;
       end
       clear img_ img2_ t_img_vBe_ x_
   elseif nivel(10) == true
       t_img_vBe_ = cortarimg(img_, vectBe_);
       img2_=rgb2gray(t_img_vBe_);
       bw_=binarizacion(img2_,T_bw_,inv_);
       pp_ = px2part(bw_);
       if pp_(1) > 94.5
           nivel(11) = true;
           nivel(10) = false;
       end
       clear img_ t_img_vBe_ img2_ bw_ pp_
   elseif nivel(11) == true
       t_img_vBe_ = cortarimg(img_, vectBe_);
       img2_=rgb2gray(t_img_vBe_);
       bw_=binarizacion(img2_,T_bw_,inv_);
       pp_ = px2part(bw_);
       if pp_(1) < 93.5
           indices_(j_,5) = i_;
           indices_(j_,6) = i_+2;
           nivel(12) = true;
           nivel(11) = false;
       end
       clear img_ t_img_vBe_ img2_ bw_ pp_
   elseif nivel(12) == true
       imgb_ = imread(archivo_{i_+1});
       imgc_ = imread(archivo_{i_+2});
       t_img_a_ = rgb2gray(cortarimg(img_, vectE_));
       t_img_b_ = rgb2gray(cortarimg(imgb_,vectE_));
       t_img_c_ = rgb2gray(cortarimg(imgc_,vectE_));
       cab_ = corr2(t_img_a_,t_img_b_);
       cac_ = corr2(t_img_a_,t_img_c_);
       cdif_ = cab_ - cac_;
    %  imshow([t_img_a_,t_img_b_,t_img_c_])
    %  title(strcat('imagen A B C: correlacion A-B:',num2str(cab_),'   ;      Correlacion A-C:',num2str(cac_),'     ',num2str(cab_-cac_)))
       if cdif_ <= 0.001
           indices_(j_,7) = i_;
           indices_(j_,8) = i_+4;
           indices_(j_,9) = 1;
           indices_(j_,10) = length(archivo_);
           nivel(13) = true;
           nivel(12) = false;
       end
       clear img_ imgb_ imgc_ t_img_a_ t_img_b_ t_img_c_ cab_ cac_ cdif_
   elseif nivel(13) == true
       break
   else
       fprintf(strcat('Hay un error en el video:  ',num2str(j_)))
       indices_(j_,1:10) = 0; 
   end
    
   end
   