%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       line2img.m
%   Input
%       lines_all_ = Estructura con todas las lineas y su coordenada final
%                    de la imagen de donde se copio.
%       coordenada = Opcion de copiar coordenada en los pixeles finales de
%                    la imagen
%   Output
%       lines_all_ = Todas las lineas en una sola imagen 
%
%   Copia las lineas sucesivas ede arco2cuadro.m en una imagen donde se
%   puede apreciar el esparcimiento radian linea a linea.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
function [img_all] = line2img(lines_all_,coordenada)
last_element_ = length(lines_all_(1).L1);

for ind_line_ =  1: length(lines_all_);
   L1_ (:,ind_line_)= lines_all_(ind_line_).L1(end:-1:1)';
   if coordenada == true
    L1_ ( last_element_ +1,ind_line_) = lines_all_(ind_line_).P1(1);
    L1_ ( last_element_ +2,ind_line_) = lines_all_(ind_line_).P1(2);
   end
end
for ind_line_ =  1: length(lines_all_);
   L2_ (:,ind_line_)= lines_all_(ind_line_).L2(end:-1:1)';
   if coordenada == true
    L2_ ( last_element_ +1,ind_line_) = lines_all_(ind_line_).P2(1);
    L2_ ( last_element_ +2,ind_line_) = lines_all_(ind_line_).P2(2);
   end
end
for ind_line_ =  1: length(lines_all_);
   L3_ (:,ind_line_)= lines_all_(ind_line_).L3(end:-1:1)';
   if coordenada == true
    L3_ ( last_element_ +1,ind_line_) = lines_all_(ind_line_).P3(1);
    L3_ ( last_element_ +2,ind_line_) = lines_all_(ind_line_).P3(2);
   end
end
for ind_line_ =  1: length(lines_all_);
   L4_ (:,ind_line_)= lines_all_(ind_line_).L4(end:-1:1)';
   if coordenada == true
    L4_ ( last_element_ +1,ind_line_) = lines_all_(ind_line_).P4(1);
    L4_ ( last_element_ +2,ind_line_) = lines_all_(ind_line_).P4(2);
   end
end
for ind_line_ =  1: length(lines_all_);
   L5_ (:,ind_line_)= lines_all_(ind_line_).L5(end:-1:1)';
   if coordenada == true
    L5_ ( last_element_ +1,ind_line_) = lines_all_(ind_line_).P5(1);
    L5_ ( last_element_ +2,ind_line_) = lines_all_(ind_line_).P5(2);
   end
end
for ind_line_ =  1: length(lines_all_);
   L6_ (:,ind_line_)= lines_all_(ind_line_).L6(end:-1:1)';
   if coordenada == true
    L6_ ( last_element_ +1,ind_line_) = lines_all_(ind_line_).P6(1);
    L6_ ( last_element_ +2,ind_line_) = lines_all_(ind_line_).P6(2);
   end
end
for ind_line_ =  1: length(lines_all_);
   L7_ (:,ind_line_)= lines_all_(ind_line_).L7(end:-1:1)';
   if coordenada == true
    L7_ ( last_element_ +1,ind_line_) = lines_all_(ind_line_).P7(1);
    L7_ ( last_element_ +2,ind_line_) = lines_all_(ind_line_).P7(2);
   end
end
for ind_line_ =  1: length(lines_all_);
   L8_ (:,ind_line_)= lines_all_(ind_line_).L8(end:-1:1)';
   if coordenada == true
    L8_ ( last_element_ +1,ind_line_) = lines_all_(ind_line_).P8(1);
    L8_ ( last_element_ +2,ind_line_) = lines_all_(ind_line_).P8(2);
   end
end

img_all = [L1_ L2_ L3_ L4_ L5_ L6_ L7_ L8_];

end