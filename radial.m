%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    radial.m
%   Input 
%       c_drop_ = Imagen del esparcimiento
%       c_archivo = Lista con todos los archivos del video.
%       indice = El número de frame a analizar
%       centro = Centro del target.
%       T_vent = Tamaño de la ventana (T_vent+radio).
%       cuadrante = 1 Superior, 2 inferior, circunferencia.
%   Output
%       c_copy1_rad = Imagen de la pirmera ventana.
%       c_copy2_rad = Imagen de la segunda ventana.
%       c_copy3_rad = Imagen de la tercera ventana.
%
% Esta función me permite copiar un ventana entre r1 y r2 (en forma de arco) 
% de la image en una sub imagen rectangular, el tamaño de la imagen va a
% ser el radio de esparcimiento de la gota + T_vent y -T_vent, esto lo hace 
% para la imagen "incice" y las 2 imagenes siguientes. En  caso de que el 
% fenomeno sea muy rápido, puede modificar la variable incremento que eleva
% el tamaño de la venta para las imagenes subsecuentes.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [c_copy1_rad,c_copy2_rad,c_copy3_rad] = radial(c_drop,c_archivo,indice,centro,T_vent, cuadrante);

    c_i_copy_ = 1;% Variable de copiado visto que las lineas van de derecha a izquierda
    
    c_drop0_ = rgb2gray(imread(c_archivo{indice}));    
    c_drop1_ = rgb2gray(imread(c_archivo{indice+1}));    c_drop2_ = rgb2gray(imread(c_archivo{indice+2}));
    c_centre = floor(centro);
%     bw_Cdrop_=binarizacion(c_drop0_, 70, true) ;
     
    stats_ = regionprops('table',c_drop,'Centroid','MajorAxisLength','MinorAxisLength');%Calcula regiones con pizeles blancos
    c_diameters_ = mean([stats_.MajorAxisLength(1) stats_.MinorAxisLength(1)],2);% M = mean(A,dim) dim = (1 since top to down matrix), =(2 since left to right)
          
    c_radio_ = floor(c_diameters_/2) + T_vent;% Calcula El radio del figura a copiar (radio+T_vent)
    
    c_xy_ = line_radial(c_centre,c_radio_,cuadrante);
    c_n_line_ = c_xy_(end,3);
%   c_r_ = c_radio_-T_vent;% Calcula el radio minimo de ventana  % NO ME INTEREZA POR QUE AHORA VOY A COPIAR DEL CENTRO AL EXTREMO
    
%%         TAMAÑO DE LA IMAGEN A COPIAR
    
    c_length_copy_ = c_radio_+4;% length
    c_width_copy_ = (c_n_line_)+4;%width 
    
%%      ESTA PARTE NO ME HACE FALTA POR QUE AHORA EL CENTRO ES LA LINEA INFERIOR
%     c_rad_vent_i_ = floor(c_width_copy_ / 2)+1;% calcula la mitad de la Ventana
%     c_2vent_j_=c_length_copy_;%Clacula la ultima línea (lenght <j>) de la Ventana 
%%  
    c_copy1_rad(1:c_length_copy_,1:c_width_copy_) = uint8(0);% Define Ventana << h(j,i) (Length) Y hasta 2*ventana , (Width) X hasta (radio + ventana)*2+1 >>.
    c_copy2_rad(1:c_length_copy_,1:c_width_copy_)= uint8(0);     c_copy3_rad(1:c_length_copy_,1:c_width_copy_)= uint8(0);% Define Ventana 2 y 3.
    %   c_copy_rad_= uint8(c_copy_rad_);
    
%% 

    for c_i_ =  1:c_n_line_
        
        c_ind_ = find(c_xy_(:,3)== c_i_);

        
        for c_j_ = 1: length(c_ind_)
          
            c_copy1_rad(c_j_+2,c_i_+2) = c_drop0_(c_xy_(c_ind_(c_j_),2),c_xy_(c_ind_(c_j_),1));
            c_copy2_rad(c_j_+2,c_i_+2) = c_drop1_(c_xy_(c_ind_(c_j_),2),c_xy_(c_ind_(c_j_),1));
            c_copy3_rad(c_j_+2,c_i_+2) = c_drop2_(c_xy_(c_ind_(c_j_),2),c_xy_(c_ind_(c_j_),1));
        end
        
% %         c_copy1_rad(:,c_i_) = c_drop0_(c_xy_(c_ind_,1:2));% IMAGEN QUE SE QUIERE COPIAR  C_DROP inicial +0
%         c_copy2_rad(:,c_i_)= c_drop1_(c_xy_(c_ind_,1),c_xy_(c_ind_,2));% IMAGEN QUE SE QUIERE COPIAR  C_DROP siguiente +1
%         c_copy3_rad(:,c_i_)= c_drop2_(c_xy_(c_ind_,1),c_xy_(c_ind_,2));% IMAGEN QUE SE QUIERE COPIAR  C_DROP subsigiente +2
        
%         c_i_copy_ = c_i_copy_+1;
    end
%         for c_r_ii_ = 1:length(Temp_c_x)
%             
%             c_j_=c_rad_vent_i_+temp_c_x(c_r_ii_);% coordenadas en j desde el centro del cuadro
%             c_copy_ind_i_ = Temp_c_x(c_r_ii_);             c_copy_ind_j_ = temp_c_y(c_r_ii_);
%             
%             c_copy1_rad(c_2vent_j_,c_j_) = c_drop0_(c_copy_ind_j_,c_copy_ind_i_);% IMAGEN QUE SE QUIERE COPIAR  C_DROP inicial +0
%             c_copy2_rad(c_2vent_j_,c_j_)= c_drop1_(c_copy_ind_j_,c_copy_ind_i_);% IMAGEN QUE SE QUIERE COPIAR  C_DROP siguiente +1
%             c_copy3_rad(c_2vent_j_,c_j_)= c_drop2_(c_copy_ind_j_,c_copy_ind_i_);% IMAGEN QUE SE QUIERE COPIAR  C_DROP subsigiente +2
%         end
%%           SI NECESITA VISUALIZAR        
%         subplot(2,3,1),         imshow(c_drop0_)
%         hold on,               plot(centro(1),centro(2), 'b*')
%                                plot(Temp_c_x,temp_c_y)
%         hold off
%         subplot(2,3,2),         imshow(c_copy1_rad)
%           
%         subplot(2,3,3),         imshow(c_drop1_)
%         hold on,               plot(centro(1),centro(2), 'b*')
%                                plot(Temp_c_x,temp_c_y)
%         hold off
%         
%         subplot(2,3,4),         imshow(c_copy2_rad)
%           
%         subplot(2,3,5),         imshow(c_drop2_)
%         hold on,               plot(centro(1),centro(2), 'b*')
%                                plot(Temp_c_x,temp_c_y)
%         hold off
%         subplot(2,3,6),         imshow(c_copy3_rad)
       
%%
%      c_2vent_j_ = c_2vent_j_ - 1;
end

    


