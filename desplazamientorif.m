%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       desplazamientorif.m
%   Input
%       maxI = Es el valor maximo de la primera derivada 
%       maxII ) Es el valor maximo de la segunda derivada
%   Output
%       d = Valor maximo entre los dos valores
%
% Esta función es un conjunto de condiciones que simplifican el codigo en
% desplazamiento.m, como las variables de entradas pueden ser de diferentes
% valores, esta fuincion evalue cada caso posible para poder encontrar en
% que punto se encuentra un cambio brusco de contrasto usadondo la primera
% y segunda derivada en las lineas copiadas de las 3 imagenes sucesivas.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

function d = desplazamientorif(maxII,maxI)
            if  length(maxII) == length(maxI) == 1
                d = maxI;
            elseif length(maxII) > 1 
                tmaxII_ = sum(maxII(1:end))/length(maxII);
                d = round((tmaxII_ + maxI)/2);
            elseif length(maxI) > 1
                tmaxI_ = sum(maxI(1:end))/length(maxI);
                d = round((tmaxI_ + maxII)/2);
            end
            
            if  length(maxII) >1 &   length(maxI) > 1
                tmaxI_ = sum(maxI(1:end))/length(maxI);
                tmaxII_ = sum(maxII(1:end))/length(maxII);
                d = round((tmaxII_ + tmaxI_)/2);
            end
end
    