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
        cxy(i_) = struct('octante1',[x_ -y_],'octante2',[ y_ -x_],...
                         'octante3', [-y_ -x_ ],'octante4', [-x_ -y_],...
                         'octante5', [-x_ y_], 'octante6', [-y_ x_],...
                         'octante7',[y_ x_],'octante8',[x_ y_]);
        e_= e_ + 2*y_ + 1;  y_ = y_ + 1;
        
        if 2*e_ > (2*x_ -1)
            i_ = i_ +1;% esto agrega un punto mas en los cambio de x (esfera mas completa).
%             cxy(i_) =  struct('octante8',[x_ y_], 'octante7', [-x_ y_]...
%                                       ,'octante6',[x_ -y_],'octante5', [-x_ -y_]...
%                                       ,'octante4',[y_ x_], 'octante3', [-y_ x_]...
%                                       ,'octante2',[ y_ -x_], 'octante1',
%                                       [-y_ -x_]); .
            cxy(i_) = struct('octante1',[x_ -y_],'octante2',[ y_ -x_],...
                         'octante3', [-y_ -x_ ],'octante4', [-x_ -y_],...
                         'octante5', [-x_ y_], 'octante6', [-y_ x_],...
                         'octante7',[y_ x_],'octante8',[x_ y_]);

            x_ = x_ -1;        e_ = e_ - 2*x_ +1;
        else
                    i_ = i_ +1;
        end
        
      end
   
       
    clear x_ y_ e_ i_
    clear t_cxy_ e_ y_ iend_
    
end