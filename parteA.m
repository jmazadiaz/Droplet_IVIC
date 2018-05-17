%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                          PARTE A DEL FENOMEN (caida real)
%%                     MIDE LA VELOCIDAD DE LA GOTA 103 - 151

a_end_i_ = a_end_ -a_ini_;

a_table_(1:a_end_i_,1:5) = 0;  % Crea tabla de datos (# elementos, # columnas)
a_table_(1,1) = 1/5400* a_ini_;
a_in_=1;

a_archivo_=archivo(a_ini_:a_end_);


%%                  Iteración                       %          in_a_ = 38; % comienza en 38 termina en 88
 for a_i_ = 1:a_end_i_;
    
    a_img_=imread(a_archivo_{a_i_});

    a2_img_=rgb2gray(a_img_);
    a_bw_=binarizacion(a2_img_,70,true);
  
    a_cc_=bwconncomp(a_bw_, nun_cc_);
    

%       No es necesaria para el FOR  {Los elementos más grandes segun
%        su lista de pixel}

    [a_sa2max, a_sa2maxpos] = objectMaxSize(a_cc_,a_T_O_);

%%            Calcula desplazamiento
%%         CALCULA EL DESPLZAMIENTO DE LA GOTA
%        LA VELOCIDAD DE LA GOTA EN CAIDA LIBRE REAL (VERTICAL)

    a_drop_ = object(a_bw_,a_cc_.PixelIdxList{a_sa2maxpos(2)});
    [a_cen_,a_des_,a_diameters_] = desplazamiento(a_drop_,Tcentroids);
    
%%                  SAVE DATA
%                 
    
    a_table_(a_in_,2)=a_diameters_;
    a_table_(a_in_,3)=a_des_;
    a_table_(a_in_,4)=a_cen_(1);
    a_table_(a_in_,5)=a_cen_(2);

    if a_in_ ~= a_end_i_+1
        a_table_(a_in_+1,1)= a_table_(a_in_,1)+1.8519e-04;
    end

%                   FIN  SAVED DATA
%%                 SHOW DATA

    a_radio_ = floor(a_diameters_/2);

    a_x_=-a_radio_:1:a_radio_;
    a_y1=floor(a_cen_(2))-sqrt((a_radio_.^2)-a_x_.^2);
    a_y2=floor(a_cen_(2))+sqrt((a_radio_.^2)-a_x_.^2);
    a_x_= a_cen_(1)+a_x_;

    imshow(a_drop_)

    hold on
    plot(centro_(1),centro_(2), 'b*')
    plot(a_cen_(1),a_cen_(2),'b*')
    plot(a_x_,a_y1,a_x_,a_y2)
    hold off
    a_in_=a_in_ + 1;
%%                 SHOWED DATA    
 end
 
%%%%               VARIABLES INECESARIAS
 
    clear a_end_i_ a_in_ %inicio de sección A
    clear a_i_ a_img_ a2_img_ a_bw_ a_cc_ a_sa2max a_sa2maxpos ...
        a_drop_ a_cen_ a_des_ a_diameters_ %Calculo de las variables
    clear a_radio_ a_x_ a_y1 a_y2 a_x_% Show data
% 