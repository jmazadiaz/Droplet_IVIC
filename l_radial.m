%  clc
%  close all
clear
radio=15;
centro = [129 106];
press =0 ; %        Si vamos a trabajar con valores 

xy_ = line_radial(centro,radio,press);

imshow(imread('D:\Droplets Video\glicerina\48 cm\AVI\IMG\img-g48-1\f007.jpg'));
hold on
% i_= 1:36;
% for i_ =1:36
plot(centro(1),centro(2), 'b*')
plot(xy_(:,1),xy_(:,3))
plot(xy_(:,4),xy_(:,6))

% end


