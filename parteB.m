%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                      PARTE B DEL FENOMENO (caida reflejada)                           %%
%%              MIDE LA VELOCIDAD DE LA GOTA y el diametro 
      
b_end_i_ = b_end_ -b_ini_;

b_table_(1:b_end_i_,1:5) = 0;  % Crea tabla de datos (# elementos, 1:5 # columnas)
b_table_(1,1) = 1/5400* b_ini_;
b_in_=1;

b_archivo_=archivo(b_ini_:b_end_);

%%                  Iteración                                            %     b_i_n = 121; b_archivo_ = lee_archivos(b_i_n).name;% comienza en (2)103 120(1)121 termina en 155
  for b_i_ = 1:b_end_i_;
    
    b_img_=imread(b_archivo_{b_i_});

    b2_img_=rgb2gray(b_img_);
    b_bw_=binarizacion(b2_img_, T_bw_, inv_);
    
    b_cc_=bwconncomp(b_bw_, nun_cc_);
   
%        No es necesaria para el FOR  {Los elementos más grandes segun
%        su lista de pixel

    [b_sa2max, b_sa2maxpos] = objectMaxSize(b_cc_,b_T_O_);

%        Calcula desplazamiento y aisla el objeto de estudio

    if b_i_ <= 1203
        b_drop_ = object(b_bw_,b_cc_.PixelIdxList{b_sa2maxpos(2)});
    elseif b_i_ > 120;
        b_drop_ = object(b_bw_,b_cc_.PixelIdxList{b_sa2maxpos(1)});
    end 

    [b_cen_,b_des_,b_diameters_] = desplazamiento(b_drop_,centro_);

%%               SAVE DATA

    
    b_table_(b_in_,2)=b_diameters_;
    b_table_(b_in_,3)=b_des_;
    b_table_(b_in_,4)=b_cen_(1);
    b_table_(b_in_,5)=b_cen_(2);

    if b_in_ ~= b_end_i_+1
        b_table_(b_in_+1,1)= b_table_(b_in_,1)+1.8519e-04;
    end
                
%%             SAVED DATA

%%                 SHOW DATA

    b_centroids_ = [b_cen_(1),b_cen_(2)];
    b_radio_ = floor(b_diameters_/2);

    b_x=-b_radio_:1:b_radio_;
    b_y1=floor(b_centroids_(2))-sqrt((b_radio_.^2)-b_x.^2);
    b_y2=floor(b_centroids_(2))+sqrt((b_radio_.^2)-b_x.^2);
    b_x= b_centroids_(1)+b_x;

    imshow(b_drop_)

    hold on
    plot(centro_(1),centro_(2), 'b*')
    plot(b_centroids_(1),b_centroids_(2),'b*')
    plot(b_x,b_y1,b_x,b_y2)
    hold off
    
%            SHOWED DATA
%%
    b_in_=b_in_ + 1;
 
  end

    clear b_end_i b_in_
    clear b_i_ b_img_ b2_img_ b_bw_ b_cc_ b_sa2max b_sa2maxpos...
        b_drop_ b_cen_ b_des_ b_diameters_
    clear b_centroids_ b_radio_ b_x b_y1 b_y2 b_x
