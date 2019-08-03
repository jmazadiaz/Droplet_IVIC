function h=imandhist(img,mimg,filtro)
subplot(2,2,1);
imshow(img);
title('imagen Sin modificar'); 
subplot(2,2,2);
imhist(img);
title('Hist I S/m');
subplot(2,2,3);
imshow(mimg);
title(strcat('filtro : ',filtro));
subplot(2,2,4);
imhist(mimg);
title(strcat('hist filtro: ',filtro));
h=1;
end