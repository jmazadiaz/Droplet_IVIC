%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   color.m
%   Input 
%       elementos = Número de elementos que va a generar.
%       symbol = El simbolo que quiere concatenar con el color
%   Output
%       color = Vector con la lista de colores de 8 en 8.
%
% Esta función genera una lista con la cantidad de elementos que se
% necesita para poder usar junto a plot y tener signos de fiferente color
% en el gráfico.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function color = color(elementos,symbol)

c1_ = strcat('y',symbol);  c2_ = strcat('m',symbol);  c3_ = strcat('c',symbol);  
c4_ = strcat('r',symbol);  c5_ = strcat('g',symbol);  c6_ = strcat('b',symbol);
c7_ = strcat('w',symbol);  c8_ = strcat('k',symbol); 

colora_ = vertcat(c1_,c2_,c3_,c4_,c5_,c6_,c7_,c8_);  color = colora_;

repetir_ = elementos / 8 +1;

for i_ = 1:repetir_
    color = vertcat(color,colora_);
end
%%
clear c1_ c2_ c3_ c4_ c5_ c6_ c7_ c8_
clear i_ colora_

end
