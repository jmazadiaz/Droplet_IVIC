%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   
%       object
%   Input
%       bw = imagen de estudio (solo para el tama�o)
%       PixelIdxList = lista de pixeles a modificar
%   Output
%       bwfigure = Imagen negra con los PixelIdxList valor 1
%
% Esta funci�n la uso para crear una imagen de un objeto determinado de una
% lista de objetos, de una imagen en blanco y negro, que genero usando
% 'bwconncomp' de matlab r2015a.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function bwfigure = object(bw ,PixelIdxList)
bwfigure=false(size(bw));
bwfigure(PixelIdxList) = true;
end