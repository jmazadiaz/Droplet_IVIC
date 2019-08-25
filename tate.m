%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	tate.m 
%	La ley de tate calcula la masa de una gota que pende de una superficie
% 	Una gota se desprende de la superficie en el momento que el peso iguala
%	Su tension superficial por lo tanto:
%	 m*g =  2* pi * r * gamma m=masa , g=gravedad , r=perimetro de estechamiento
%	 C = 2*pi/9.77675388612164
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function [y]=tate(diametro, tsuper)% esta funcion calcula la masa de la gota de agua basada en el teorema de tate

y=(0.6427*tsuper(3)/1000)*(diametro./2);

end

