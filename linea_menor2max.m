%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       linea_menor2max.m
%   Input
%       linemin = Linea menor al maxima longitud
%   Output
%       linmax = Copia de linemin rellena de 255
%
%   Rellena los espacios necesarios para igular la longitud de todas las
%   lineas menor a la mas grande
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function linmax = linea_menor2max(linemin,max)

        for i_ = 1 : max
       
            if length(linemin) >= i_
                linmax(i_,1) = linemin(i_);
            else
                linmax(i_,1) = linemin(end);
            end
        end

end