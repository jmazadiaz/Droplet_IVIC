%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                      PARTE C DEL FENOMENO                            %%
%%            MIDE EL ESPARCIMIENTO DE LA GOTA (Corrección proyectiva) 169 - 191
      
c_end_i_ = c_end_ - c_ini_+1;

% c_table_(1:c_end_i_,1:5) = 0;  % Crea tabla de datos (# elementos, # columnas)
% c_table_(1,1) = 1/5400* c_ini_;
% c_in_=1;

c_archivo_=archivo_(c_ini_:c_end_);

%%                  Iteración 
   for c_i_ = 1:c_end_i_-3;
    
        c_img1_=rgb2gray(imread(c_archivo_{c_i_}));                             % I imagenes sucesivas
        c_img2_=rgb2gray(imread(c_archivo_{c_i_+1}));
        c_img3_=rgb2gray(imread(c_archivo_{c_i_+2}));

%         c2_img_=rgb2gray(c_img_);
%         c_bw_=binarizacion(c2_img_, T_bw_, inv_);
        %%   AGREGADO Comentar si no sirve
        c_background1 = imclose(c_img1_,strel('disk',1));
        c2_img1_ = c_img1_ + c_background1;                                     % Quitar ruido, solo gota
        c_bw1_ = imfill(imcomplement(im2bw(c2_img1_,0.4)),'holes');
        
        c_background2 = imclose(c_img2_,strel('disk',1));
        c2_img2_ = c_img2_ + c_background2;
        
        c_background3 = imclose(c_img3_,strel('disk',1));
        c2_img3_ = c_img3_ + c_background3;
        
        c_img = {c2_img1_,c2_img2_,c2_img3_};                                   % Estructura para copiar líneas
        %%
        

        c_cc_=bwconncomp(c_bw1_, nun_cc_);                                      % Busqueda de formas conectadas

    %        No es necesaria para el FOR  {Los elementos más grandes segun
    %        su lista de pixel

        [c_sa2max, c_sa2maxpos] = objectMaxSize(c_cc_,T_O_);                    % busca el objeto mas grande

        c_drop_ = object(c_bw1_,c_cc_.PixelIdxList{c_sa2maxpos(1)});            % Busca objetos anteriores y los mide

    %%         GRAFICAR EN RADIAL EL CENTRO EN LA COPIA
    %        MEDIR EL ESPARCIMIENTO DEL CENTRO A CADA PIXEL.

    
            %%         IFORMACION PARA DIBUJAR LAS LINEAS EN LA IMAGEN, EL RADIO ES c_d_ Y EL PUNTO FINAL ES c_dp  
                      %LAS MATRICES NO TIENEN LA MISMA DIMENSIÓN Y ADEMAS
                      %NO SABES COMO VAS A ORDENAR LOS DATOS PARA SU
                      %INTERPRETACION   revisar desarco para entender su
                      %origen y luego etiquetar la información

               if c_i_ <= c_end_i_ -3

                    c_lines_all_ = desarco(c_drop_,c_img,Tcentroids,...
                                  c_T_vent_, c_octantes_);                      % c_d_ = radios , c_dp_ = P.final de linea

               clear c_d_
               else

                     c_lines_all_ = Radios(c_i_-1);
                end
        %%




    %   bar3(c_d_);

        des_ = desplazamiento(c_drop_,Tcentroids);

    %%                   SAVE DATA
    %       c_lines(c_i_,:) = {cl_ind_c1_,cl_ind_c2_,cl_ind_c3_};
                
         Tiempo_(c_i_,1) = 1/5400* c_i_;
         Diametro(c_i_,1) = des_.diametros;
         Desplazamiento(c_i_,1) = des_.Des;
         Radios(c_i_,1) = {c_lines_all_};
         Tcentro{c_i_,1} = Tcentroids;
        
        clear c_d_ c_radios_
    %                   FIN  SAVED DATA
    %%
%          c_in_=c_in_ + 1;
   end
            c_tab_ = table(Tiempo_,Diametro,Desplazamiento,Radios,Tcentro);

 clear Tiempo_ Diametro Desplazamiento   Radios des_ c_radios_ des_  ...
       Tcentro c_i_   c_drop_ c_sa2max  c_sa2maxpos c_end_i_...
       c_img_ c2_img_ c_bw_ c_cc_ c_archivo_    c_archivo_