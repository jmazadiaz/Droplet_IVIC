%   Aplicar filtros yo

i_r = i_radial(img);%lista de indices circular
borde = 255;% Valor que quieres en el borde 
l_mask = 3;
mask = fspecial('gaussian',l_mask,9);

% for j_ = 1:65536
%         ir = i_r(1,j_); 
%         jr = i_r(2,j_);
%         jmg(ir,jr) = img(ir,jr);
% end
jmg = img;

for i_ = 1:65536
    ir = i_r(1,i_); 
    jr = i_r(2,i_);
    
   
    temp_sub = submatriz(jmg,ir,jr,l_mask,borde);
    jm(ir,jr) =sum(sum(temp_sub.*mask));
        
end
im = uint8(jm);

subplot(2,2,1);
imshow(jmg);
title('imagen Sin modificar') 
subplot(2,2,2);
imhist(jmg);
title('Hist I S/m');
subplot(2,2,3);
imshow(im);
title(strcat('filtro : '));
subplot(2,2,4);
imhist(im);
title(strcat('hist filtro: '));


