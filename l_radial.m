%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Este escrip muestra como dibuja el circulo y línea de Bresenham
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  clc
% close all
% clear

radio=37;
centro = [129 106];
octante =1; %        Si vamos a trabajar con valores 
load('c_archivo.mat');
load('c_drop.mat');


xy_ = line_radial(centro,radio,octante);

cual_ = 14;
n_cual_ = 15;

ind_ = find(xy_(:,3)== cual_);
l_xy_ = xy_(ind_,1:2);


color_ = color(cual_,'.');
 c_ = color(cual_,'*');
         
% cxy=circulo_bresenham(radio);    
% cxy_ = [cxy(:,3)+centro(1) cxy(:,4)+centro(2)]; 


%   figure
imshow(imread(c_archivo{5}));
hold on
% i_= 1:36;
% for i_ =1:36
plot(centro(1),centro(2), 'r*')
plot(xy_(ind_,1),xy_(ind_,2),color_(cual_+1,:));
plot(l_xy_(n_cual_,1),l_xy_(n_cual_,2),c_(cual_+1,:));

% plot(cxy_(cual_,1),cxy_(cual_,2),c_(cual_,:))
%  [c_copy1_rad,c_copy2_rad,c_copy3_rad] = radial(c_drop,c_archivo,5,centro,5, cuadrante);



