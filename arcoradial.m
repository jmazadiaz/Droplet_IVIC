%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    arcoradial.m
%   Input 
%       imagen = Estructura con las 3 imagenes sucesivas.
%       centro = Centro del target.
%       T_vent = Tama�o de la ventana (T_vent+radio).
%       cuadrante = 1 Superior, 2 inferior, circunferencia.
%   Output
%       c_lines = Imagen de la pirmera ventana.
%       
% Permite copiar un ventana entre r1 y r2 (en forma de arco) de la image en 
% una estructura, que contine cada linea del circulo de Bresenham u su
% punto final.
%
%   Parecido a radial.m usada en arco2cuadro.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function c_lines = arcoradial(imagen,centro,T_vent, octante);

    c_drop0_ = imagen;        

    c_centre = floor(centro);
     
    
%%      Clacular puntos    
    
    [c_xy_ , c_pline_all_]= line_radial(c_centre,T_vent,octante); %   Las lineas desde centro al radio en el octante definido.
    c_n_line_ = c_xy_(end,3);
  
    
%%  Copiado de la imagen 

   max_elen_line_ =T_vent +1;

    for c_i_ =  1:c_n_line_
        
        c_ind_ = find(c_xy_(:,3)== c_i_);
        
              cl_ind_c1_=diag(c_drop0_(c_xy_(c_ind_(1:end),2),c_xy_(c_ind_(1:end),1)));
              
        if max_elen_line_> length(cl_ind_c1_)
        
            for ind_ = length(cl_ind_c1_):max_elen_line_
                cl_ind_c1_(ind_) = cl_ind_c1_(ind_-1);
            end
            
        end        
        c_lines(c_i_,:) = {cl_ind_c1_,c_pline_all_(c_i_,:)};
        
    end

%%           SI NECESITA VISUALIZAR        
%         subplot(2,3,1),         imshow(c_drop0_)
%         hold on,               plot(centro(1),centro(2), 'b*')
% %                                plot(Temp_c_x,temp_c_y)
%         hold off
%         subplot(2,3,2),         imshow(c_copy1_rad)
%           
%         subplot(2,3,3),         imshow(c_drop1_)
%         hold on,               plot(centro(1),centro(2), 'b*')
% %                                plot(Temp_c_x,temp_c_y)
%         hold off
%         
%         subplot(2,3,4),         imshow(c_copy2_rad)
%           
%         subplot(2,3,5),         imshow(c_drop2_)
%         hold on,               plot(centro(1),centro(2), 'b*')
% %                                plot(Temp_c_x,temp_c_y)
%         hold off
%         subplot(2,3,6),         imshow(c_copy3_rad)
%        
% %
% %      c_2vent_j_ = c_2vent_j_ - 1;
end

    


