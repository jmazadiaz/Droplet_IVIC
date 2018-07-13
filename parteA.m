%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                          PARTE A DEL FENOMEN (caida real)
%%                     MIDE LA VELOCIDAD DE LA GOTA 103 - 151

a_end_i_ = a_end_ -a_ini_;

a_table_(1:a_end_i_,1:5) = 0;  % Crea tabla de datos (# elementos, # columnas)
a_table_(1,1) = 1/5400* a_ini_;
a_in_=1;

a_archivo_=archivo_(a_ini_:a_end_);

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
    des_ = desplazamiento(a_drop_,Tcentroids);
    
%%                  SAVE DATA
%                 
    
     Tiempo_(a_i_,1) = 1/5400* a_i_;
     Desplazamiento(a_i_,1) = des_.Des;
     Des_x(a_i_,1) = des_.Dx;
     Des_y(a_i_,1) = des_.Dy;

%                   FIN  SAVED DATA
%%                 SHOW DATA
    
%%                 SHOWED DATA    
 end
 
  a_tab_ = table(Tiempo_,Desplazamiento,Des_x ,Des_y);
%%%%               VARIABLES INECESARIAS
 
clear Tiempo_ Desplazamiento Des_x Des_y des_