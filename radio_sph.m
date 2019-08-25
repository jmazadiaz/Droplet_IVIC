%calcula el radio de una esfera a partir de un volumen.
function [radio]=radio_sph(volumen)
radio=nthroot((volumen*3)/(4*pi),3);
end
