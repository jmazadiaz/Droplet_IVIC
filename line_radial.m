clc
% close all
clear
radio=31;
centro = [radio 0];
press =1 ; %        Si vamos a trabajar con valores 

c_x_ = -radio:radio;

c_y_down_ = centro(2)-sqrt((radio.^2)-c_x_.^2);
if press == 1
    c_y_down_ = floor(c_y_down_);
end
    
c_y_up_ = - c_y_down_;
img_c_x= centro(1)+c_x_;

i=32

% since 2*radio+1 to radio +1

m_up =  (c_y_up_(i)-centro(2)) ./ (img_c_x(i) - centro(1));
y_line2 = m_up*c_x_(i:radio+1);
y_line1 = -m_up*c_x_(radio+1:2*radio+2-i);

y_line3 = -y_line2;
y_line4 = -y_line1;

l_img_c_x2(1:length(y_line2))= img_c_x(i:radio+1);
l_img_c_x1(1:length(y_line2)) =img_c_x(radio+1:2*radio+2-i);

l_img_c_x3 = l_img_c_x2;
l_img_c_x4 = l_img_c_x1
if m_up == Inf
    y_line1 = centro(2):radio;
    y_line2= y_line1;
    l_img_c_x2(1:length(y_line1))= centro(1);
end




plot(centro(1),centro(2), 'b*')
hold on
plot(img_c_x,c_y_down_);
plot(img_c_x,c_y_up_);
plot(l_img_c_x2,y_line2)
plot(l_img_c_x1,y_line1)
plot(l_img_c_x3,y_line3)
plot(l_img_c_x4,y_line4)
plot(img_c_x(i),c_y_down_(i), 'b*')
plot(img_c_x(i),c_y_up_(i), 'r*')

