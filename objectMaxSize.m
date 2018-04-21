%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       objectMaxSize.m
%   Input
%       cc = connected components in binary image
%       T = numero de pixels minimo para escojer objetos
%   output
%       maxPx = Numero de pixeles del objetos, > T pixel
%       maxPos = Indice de la lista de pixels en cc
%
% Esta función escoje a los objetos mas grandes detectados prebiamenete con
% bwconncomp (funcion Matlab R2015a), y arroja el número de pixels y su
% indice en la lista de componenetes 'cc'.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function  [maxPx, maxPos]=objectMaxSize(cc,T)

C_ = vertcat(cc.PixelIdxList);
num_elem_(1:cc.NumObjects) = 0; 

j_ = 1;

for i_ = 1:cc.NumObjects
    M_ = cell2mat(C_(i_));
    [tnum_elem_(i_),~] = size(M_);
    if tnum_elem_(i_)> T
        num_elem_(i_) = tnum_elem_(i_);
        j_ = j_ + 1;
    else
        num_elem_(i_) = 0;
    end
end

[n_e_,orden] = sort(num_elem_,'descend');

 maxPx = n_e_(1:j_);
 maxPos = orden(1:j_);

 clear C_ num_elem_ M_ tnum_elem_ i_ j_
end
