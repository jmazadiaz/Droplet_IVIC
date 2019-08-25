%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   medida_con_calibracion_camara.m
%
%   Quiero replicar lo mmismo de Measuring Planar Objects with a Calibrated
%   Camera pero para mis datos
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Abro mi patron de calibración, obtenido al ejecutar calibraCamera_auto.m

load('/home/maza/AllMeida/Dropbox/Droplets/Matlab/Droplets/Tools/calibración_camera.mat');
magnification = 1

%%  Corrijo imagenes con el patron de calibración

a_imOrig = imread('/home/maza/AllMeida/Droplets_Video/Correnciones/Agua/58/24/f082.jpg');

[a_im, a_newOrigin] = undistortImage(a_imOrig, cameraParams, 'OutputView', 'full');

% SHOW
figure; imshow(a_im);
title('imagen corregida');


%%  Segmento la imagen   imcoin =+ imDroplet

a_imGray = rgb2gray(a_imOrig);

a_t = graythresh(a_imGray);
imDroplet = imcomplement( imbinarize(a_imGray,a_t) );

figure; imshow(imDroplet);
title('Segmented Coins');

%%  Detectar Gota imDetectedCoins == imDetectedDroplet

blobAnalysis = vision.BlobAnalysis('AreaOutputPort', true,...
    'CentroidOutputPort', true,...
    'BoundingBoxOutputPort', true,...
    'MinimumBlobArea', 200, 'ExcludeBorderBlobs', true);
[a_areas, a_boxes] = step(blobAnalysis, imDroplet);                             %   Busca elementos conectados en la imagen BW
[~, a_idx] = sort(a_areas, 'Descend');                                          %   Ordena los lementos por tamaños 

a_boxes = double(a_boxes(a_idx));

scale = magnification * 1;
imDetectedDroplet = imresize(a_im, scale);

imDetectedDroplet = insertObjectAnnotation(imDetectedDroplet, 'rectangle', ...
     a_boxes, 'Droplet');
 
 figure; imshow(imDetectedDroplet);