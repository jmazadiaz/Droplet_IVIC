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

for i_ = 1:end_
    
    t_xy1_ = xy_(i_,:)
    t_xy2_ = xy_(i_+1,:)
    
    if max(t_xy1_(1,1:3) ~= t_xy2_(1,1:3))  
        fxy_(j1_,1:3) = t_xy2_(1,1:3);
        j1_ = j1_+1;
    end    
    if  max(t_xy1_(1,4:6) ~= t_xy2_(1,4:6))
        fxy_(j2_,4:6) = t_xy2_(1,4:6);
        j2_ = j2_+1;
    elseif i_ == end_ & j2_ ~= j1_
        
        %% Aca quiero evitar que en el ultimo elemento quede un 0 0 0  el condicional es para eso Revisar
        
    end
end


imshow(imread('D:\Droplets Video\glicerina\48 cm\AVI\IMG\img-g48-1\f007.jpg'));
hold on
% i_= 1:36;
% for i_ =1:36
plot(centro(1),centro(2), 'b*')
plot(fxy_(:,1),fxy_(:,3))
plot(fxy_(:,4),fxy_(:,6))

% end


