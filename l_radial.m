%  clc
%  close all
clear
radio=15;
centro = [129 106];
press =0 ; %        Si vamos a trabajar con valores 

xy_ = line_radial(centro,radio,press);

xy_ = floor(xy_);

j1_ =1;
j2_ =1;

fxy_(1,:) = xy_(1,:);

end_ = length(xy_)-1;




imshow(imread('D:\Droplets Video\glicerina\48 cm\AVI\IMG\img-g48-1\f007.jpg'));
hold on
% i_= 1:36;
% for i_ =1:36
plot(centro(1),centro(2), 'b*')
plot(fxy_(:,1),fxy_(:,3))
plot(fxy_(:,4),fxy_(:,6))

% end


