%  clc
% close all
clear
radio=10;
centro = [129 106];
cuadrante =2 ; %        Si vamos a trabajar con valores 

xy_ = line_radial(centro,radio,cuadrante);

cual_ = 0;

ind_ = find(xy_(:,3)== cual_);

 color_ = color(cual_,'.');
 c_ = color(cual_,'*');
         
cxy=circulo_bresenham(radio);    
cxy_ = [cxy(:,3)+centro(1) cxy(:,4)+centro(2)]; 

% figure
% imshow(imread('D:\Droplets Video\glicerina\48 cm\AVI\IMG\img-g48-1\f007.jpg'));
hold on
% i_= 1:36;
% for i_ =1:36
plot(centro(1),centro(2), 'r*')
plot(xy_(ind_,1),xy_(ind_,2),color_(cual_,:))
plot(cxy_(cual_,1),cxy_(cual_,2),c_(cual_,:))

% end


