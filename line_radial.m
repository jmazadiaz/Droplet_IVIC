%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       line_radial
%   Input
%       centro =  Centro del la circunferencia
%       radio = Radio de la circunferencia
%       press = Aprobación de enteros o racionales
%   Output
%       xy_ = Coordenadas de las linas radiales de una circunferencia
%
% Esta función calculas los indices de las líneas radiales de una
% circunferencias de radio 'radio' y centro 'centro', el valor de los
% elementos puede cambiar de entero a racional colocando false en la
% casilla press.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% % clc
% % close all
% clear
% radio=12;
% centro = [129 106];
% press =1 ; %        Si vamos a trabajar con valores 
%%
function xy_ = line_radial(centro,radio,press)

    incremento = 0.04;

    temp_c_xI_ = -radio:incremento:0;
    
    
    end_= floor(sqrt((length(temp_c_xI_))));
    end2_ =end_*2+2;
    
    for i_=1:end_
        c_x_(i_)=temp_c_xI_(i_*i_);
        c_x_(end2_-i_)= -c_x_(i_)
    end
   
    clear i_ end_
    
%       c_x_ = -radio:radio;

    
    c_y_down_ = centro(2)+sqrt((radio.^2)-c_x_.^2);     % Calcula el arco inferior
    c_y_up_ = centro(2)-sqrt((radio.^2)-c_x_.^2);       %Calcula el arco superior


    img_c_x_= centro(1)+c_x_;

    mitad_cx_ = (length(c_x_)-1)/2    
    
    for i_ = 1:mitad_cx_+1
    %  i_ = 22;

        m_ =  (c_y_up_(i_)-centro(2)) / (img_c_x_(i_) - centro(1)); % Calcula la pendiente

        y_line2_ = m_*c_x_(i_:mitad_cx_+1)+ centro(2);  %Calcula la Coordenada Y de la linea (I cuadrante)
        y_line1_ = -m_*c_x_(mitad_cx_+1:2*mitad_cx_+2-i_)+centro(2);    %Calcula la Coordenada Y de la linea (II cuadrante)
        y_line3_ = -m_*c_x_(i_:mitad_cx_+1)+ centro(2);     %Calcula la Coordenada Y de la linea (III cuadrante)
        y_line4_ = m_* c_x_(mitad_cx_+1:2*mitad_cx_+2-i_)+centro(2);    %Calcula la Coordenada Y de la linea (IV cuadrante)


        l_img_c_x1_(1:length(y_line2_)) =img_c_x_(mitad_cx_+1:2*mitad_cx_+2-i_);
        l_img_c_x2_(1:length(y_line2_))= img_c_x_(i_:mitad_cx_+1);
%         l_img_c_x3 = l_img_c_x2; % Solo para visualizar
%         l_img_c_x4 = l_img_c_x1_;

        if m_ == Inf
            y_line1_ = centro(2):mitad_cx_;
            y_line2_= y_line1_;
            l_img_c_x2_(1:length(y_line1_))= centro(1);
        end

        if isnan(unique(y_line2_))==1
            y_line1_ = centro(2); 
            y_line2_ = centro(2); 
            y_line3_ = centro(2);
            y_line4_ = centro(2);
        end

           temp_xy_(:,1) = l_img_c_x1_;
           temp_xy_(:,2) = y_line1_;
         temp_xy_(:,3) = y_line4_;
         temp_xy_(:,4) = l_img_c_x2_;
         temp_xy_(:,5) = y_line2_;
         temp_xy_(:,6) = y_line3_;

        if i_== 1
           xy_ = temp_xy_;
        else
            xy_ =vertcat(xy_,temp_xy_);
        end

         clear y_line2_ y_line1_ y_line3_ y_line4_ temp_xy_
         clear l_img_c_x2_ l_img_c_x1_ 

     end

     if press == 1
        xy_ = floor(xy_); 
     end
              clear m_up i_ c_y_down_ c_y_up_ c_x_ img_c_x_

end

% imshow(imread('D:\Droplets Video\glicerina\48 cm\AVI\IMG\img-g48-1\f007.jpg'));
% hold on
% plot(centro(1),centro(2), 'b*')
% plot(xy_(i_,1),xy_(i_,2))
% plot(xy_(i_,4),xy_(i_,5))

% hold on
% plot(centro(1),centro(2), 'b*')
% hold on
% plot(img_c_x,c_y_down_);
% plot(img_c_x,c_y_up_);
% plot(l_img_c_x2,y_line2)
% plot(l_img_c_x1,y_line1)
% plot(l_img_c_x3,y_line3)
% plot(l_img_c_x4,y_line4)
% plot(img_c_x(i_),c_y_down_(i_), 'b*')
% plot(img_c_x(i_),c_y_up_(i_), 'r*')

