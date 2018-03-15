I=imread('D:\Droplets Video\glicerina\48 cm\AVI\IMG\img-g48-1\f001.jpg');
I=I(1:256,1:256,:);
cform = makecform('srgb2lab');
lab_fabric = applycform(I,cform);
IL=lab_fabric(:,:,1);
Ia=lab_fabric(:,:,2);
Ib=lab_fabric(:,:,3);


I1=I(:,:,1);

mask1=(IL>=100);
mask1=imdilate(mask1,strel('disk',10));

mask2=(I1>0);

mask3=((IL+Ib)<200 & (IL+Ib)>140);
mask3=imopen(mask3,strel('disk',12));

I_blue(:,:,1)=I(:,:,1).*uint8(mask1);
I_blue(:,:,2)=I(:,:,2).*uint8(mask1);
I_blue(:,:,3)=I(:,:,3).*uint8(mask1);
I_blue = rgb2gray(I_blue);
subplot(1,3,1),imshow(I_blue);

I_red(:,:,1)=I(:,:,1).*uint8(mask3);
I_red(:,:,2)=I(:,:,2).*uint8(mask3);
I_red(:,:,3)=I(:,:,3).*uint8(mask3);
I_red = rgb2gray(I_red);
subplot(1,3,2),imshow(I_red);

I_dark(:,:,1)=I(:,:,1).*uint8(mask2&~mask3&~mask1);
I_dark(:,:,2)=I(:,:,2).*uint8(mask2&~mask3&~mask1);
I_dark(:,:,3)=I(:,:,3).*uint8(mask2&~mask3&~mask1);
I_dark = rgb2gray(I_dark);
subplot(1,3,3),imshow(I_dark);