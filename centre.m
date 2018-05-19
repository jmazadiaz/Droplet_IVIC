%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       centre.m
%   
%   Input
%       drop = imagen del objeto a medír centro y radio
%   Oputput
%       centre_ = x = centre_(ind,1)[i] , y = centre_(ind,2)[j]
%       
% Halla el centro de la imagen que se ingresa 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [centre,radii] = centre(drop)

stats_ = regionprops('table',drop,'Centroid','MajorAxisLength','MinorAxisLength','Perimeter');%Calcula regiones con pizeles blancos

ind_max_=find(max(stats_.Perimeter));% encuentra el indice de mayor perimetro

centre = stats_.Centroid(ind_max_,:);

diameter_ = mean([stats_.MajorAxisLength(ind_max_) stats_.MinorAxisLength(ind_max_)],2);% M = mean(A,dim) dim = (1 since top to down matrix), =(2 since left to right)
radii = diameter_/2;

clear stats_ ind_max_ diameter_
end