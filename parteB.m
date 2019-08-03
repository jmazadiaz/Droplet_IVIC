%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                      PARTE B DEL FENOMENO (caida reflejada)                           %%
%%              MIDE LA VELOCIDAD DE LA GOTA y el diametro 
      
b_end_i_ = b_end_ -b_ini_;

b_table_(1:b_end_i_,1:5) = 0;  % Crea tabla de datos (# elementos, 1:5 # columnas)
% b_table_(1,1) = 1/5400* b_ini_;
b_in_=1;

b_archivo_=archivo_(b_ini_:b_end_);

%%                  Iteración                                            %     b_i_n = 121; b_archivo_ = lee_archivos(b_i_n).name;% comienza en (2)103 120(1)121 termina en 155
  for b_i_ = 1:b_end_i_;
    
    b_img_=imread(b_archivo_{b_i_});

    b2_img_=rgb2gray(b_img_);
    
    b2_img_(d_target_) = b2_img_(d_target_) + 40; 

%%  		REALSA EL TARGET PARA QUE NO PUEDA SER BINARIZADO
   
    b_bw_=binarizacion(b2_img_, T_bw_, inv_);
%     imshow(b_bw_)

    b_cc_=bwconncomp(b_bw_, nun_cc_);
    
%        No es necesaria para el FOR  {Los elementos más grandes segun
%        su lista de pixel

    [b_sa2max, b_sa2maxpos] = objectMaxSize(b_cc_,b_T_O_);

%        Calcula desplazamiento y aisla el objeto de estudio

    b_drop_ = object(b_bw_,b_cc_.PixelIdxList{b_sa2maxpos(1)});
    
%     [b_cen_,b_des_,b_diameters_] = desplazamiento(b_drop_,Tcentroids);
            des_ = desplazamiento(b_drop_,Tcentroids);

%%               SAVE DATA

     Tiempo_(b_i_,1) = 1/5400* b_i_;
     Diametro(b_i_,1) = des_.diametros;
     Desplazamiento(b_i_,1) = des_.Des;
     Centro_x(b_i_,1) = des_.centro(1);
     Centro_y(b_i_,1) = des_.centro(2);
     Des_x(b_i_,1) = des_.Dx;
     Des_y(b_i_,1) = des_.Dy;
                
%             SAVED DATA
%%    b_in_=b_in_ + 1;

  end
  
b_tab_ = table(Tiempo_,Diametro,Desplazamiento,Centro_x,Centro_y,...
                  Des_x,Des_y);
              
clear Tiempo_ Diametro Desplazamiento Centro_x ...
      Centro_y Des_x Des_y


