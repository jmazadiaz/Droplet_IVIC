%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                      PARTE C DEL FENOMENO                            %%
%%            MIDE EL ESPARCIMIENTO DE LA GOTA (Corrección proyectiva) 169 - 191
      
c_end_i_ = c_end_ - c_ini_;

c_table_(1:c_end_i_,1:5) = 0;  % Crea tabla de datos (# elementos, # columnas)
c_table_(1,1) = 1/5400* c_ini_;
c_in_=1;

c_archivo_=archivo(c_ini_:c_end_);

%%                  Iteración 
   for c_i_ = 1:c_end_i_;
    
    c_img_=imread(c_archivo_{c_i_});

    c2_img_=rgb2gray(c_img_);
    c_bw_=binarizacion(c2_img_, T_bw_, inv_);
    
    c_cc_=bwconncomp(c_bw_, nun_cc_); 
   
%        No es necesaria para el FOR  {Los elementos más grandes segun
%        su lista de pixel

    [c_sa2max, c_sa2maxpos] = objectMaxSize(c_cc_,T_O_);

    c_drop_ = object(c_bw_,c_cc_.PixelIdxList{c_sa2maxpos(1)});

%%         GRAFICAR EN RADIAL EL CENTRO EN LA COPIA
%        MEDIR EL ESPARCIMIENTO DEL CENTRO A CADA PIXEL.

   if c_i_ <= c_end_i_ -3
        
        c_d_ = desarco(c_drop_,c_archivo_,c_i_,Tcentroids,c_T_vent_, c_octantes_);

        c_radios_(c_i_,:) = [c_table_(c_i_,1), median(c_d_(:,1:end))]; 

    clear c_d_
    else
         c_radios_(c_i_,:) = [c_table_(c_i_,1), 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ];
    end
    
%   bar3(c_d_);
                   
    [c_cen_,c_des_,c_diameters_] = desplazamiento(c_drop_,centro_);

%%                   SAVE DATA
%       c_lines(c_i_,:) = {cl_ind_c1_,cl_ind_c2_,cl_ind_c3_};

    c_table_(c_in_,2)=c_diameters_;
    c_table_(c_in_,3)=c_des_;
    c_table_(c_in_,4)=c_cen_(1);
    c_table_(c_in_,5)=c_cen_(2);
    
    if c_in_ ~= c_end_i_+1
        c_table_(c_in_+1,1)= c_table_(c_in_,1)+1.8519e-04;
    end
                
%                   FIN  SAVED DATA
%%                 SHOW DATA

    
    c_centroids_ = [c_cen_(1),c_cen_(2)];
    c_radio_ = floor(c_diameters_/2);

    c_x=-c_radio_:1:c_radio_;
    c_y1=floor(c_centroids_(2))-sqrt((c_radio_.^2)-c_x.^2);
    c_y2=floor(c_centroids_(2))+sqrt((c_radio_.^2)-c_x.^2);
    c_x= c_centroids_(1)+c_x;

%     imshow(c_drop_)

%     hold on
%     plot(centro_(1),centro_(2), 'b*')
%     plot(c_centroids_(1),c_centroids_(2),'b*')
%     plot(c_x,c_y1,c_x,b_y2)
%     hold off
   
%                   FIN SHOW DATA
%%
     c_in_=c_in_ + 1;
   end

 clear c_end_i c_in_
clear c_i_ c_img_ c2_img_ c_bw_ c_cc_ c_sa2max c_sa2maxpos...
    c_drop_ c_cen_ c_des_ c_diameters_
clear c_centroids_ c_radio_ c_x c_y1 c_y2 c_x