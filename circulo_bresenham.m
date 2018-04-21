%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   circulo_bresenham.m
%   Input 
%       radio =   Radio del circulo que se quiere crear
%   Outpu
%       cxy = coordenadas del circulo
%
% El circulo de Bresenham es un circulo descrito en un espacio discreto, tal
% espacio esta compuesto por un espacio mallado x,y  para el caso 2D, los
% puntos que arroja esta función arroja los pixel que tocaría un circulo de
% radio 'radio' centrado en el origen (0,0) pintado sobre el mallado.
%
%   http://3.bp.blogspot.com/-aw3jUUtIFkA/UUDtTHjfBII/AAAAAAAAASU/6xmbnzI1UBw/s1600/9.PNG
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function cxy = circulo_bresenham(radio)

    x_ =  radio;    y_ = 0;     e_ = 0;
    i_ = 1;
    
    while y_ <= x_
        
        t_cxy_(i_,1:16) = [x_ y_ -x_ y_ x_ -y_ -x_ -y_ y_ x_ -y_ x_ y_ -x_ -y_ -x_ ];
               
        e_= e_ + 2*y_ + 1;  y_ = y_ + 1;
        
        if 2*e_ > (2*x_ -1)
            i_ = i_ +1;% esto agrega un punto mas en los cambio de x (esfera mas completa).
            t_cxy_(i_,1:16) = [x_ y_ -x_ y_ x_ -y_ -x_ -y_ y_ x_ -y_ x_ y_ -x_ -y_ -x_ ]; 
                         x_ = x_ -1;

                 e_ = e_ - 2*x_ +1;
        end
        
        i_ = i_ +1;
    end
    
    [iend_ ~] = size(t_cxy_);
    cxy(:,3:4) = vertcat(t_cxy_(1:iend_-1,1:2),t_cxy_(iend_-2:-1:1,9:10),t_cxy_(2:iend_-1,11:12),t_cxy_(iend_-2:-1:1,3:4));
    cxy(:,1:2) = vertcat(t_cxy_(1:iend_-1,5:6),t_cxy_(iend_-2:-1:1,13:14),t_cxy_(2:iend_-1,15:16),t_cxy_(iend_-2:-1:1,7:8));
    
    clear x_ y_ e_ i_
    clear t_cxy_ e_ y_ iend_
    
end