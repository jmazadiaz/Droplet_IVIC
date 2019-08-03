
I=imread('/home/maza/AllMeida/Droplets_Video/Calibracion_camara/AAcalibra03.bmp');
I2 =  rangefilt(I);

FP_IMG = HPFButterwE(I2,90,4,3.2,4,0);
FI_IMG = LPFideal(FP_IMG,48,0);

detectCheckerboardPoints(FI_IMG);

c_background2 = imopen(FP_IMG,strel('octagon',9));
img_fil2 = FP_IMG + c_background2;
figure
imshow(img_fil2)
figure
surf(c_background2)


%% segmentation

imageSize = size(A);
numRows = imageSize(1);
numCols = imageSize(2);