%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    calibraCamera.m
%   Input 
%       imagen = imagen para aplicar correción                                     eestimationErrors 
%       imageFileNames_calibration = dirección de las imagenes de calibación        IntrinsicsErrors :  Error estandar intrinsico de la camara y el \
%       squareSize = tamaño del cuadro en milimetros                                                      coreficiente de distorci�n. 
%       itera = Numero de iteraciones de la modificación                            ExtrinsicsErrors : Error estandar extrinsico estimado de la camara
%   Output
%       estimationErrors =  Error estimado de la correción
%       J1 = la imagen de entrada 'imagen' corregida
%
% Es una función que analizar un mismo tablero de ajedrez en diferentes
% imagenes tomadas en diferentes lugares de un plano fíjo de una lente
% para medir la curbatura agregada por la lente en sus extremos por medio
% de la función 'estimateCameraParameters' y decuerve el patron de
% correción y el respectivo error.
%   
%   Puede modificarse para que corrija muchas imagenes o devuelva el factor
%   de correción para hacer la corección en otra función
%
%  Visualizar parametros : displayErrors(estimationErrors,cameraParams)
%  
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% imageFileNames_calibration = dir('/home/maza/AllMeida/Droplets_Video/Calibracion_camara/*.bmp'); 
% imagen = rgb2gray(imread('/home/maza/AllMeida/Droplets_Video/Agua50-Glicerina/48/AVI/IMG/img-AG48-30/f106.jpg'));
% squareSize = 1; 
% intinera = 24;


function [cameraParams estimationErrors J1]=calibrarCamera(imagen,imageFileNames_calibration, squareSize, itera )
[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(imageFileNames_calibration);

imageFileNames = imageFileNames_calibration(imagesUsed);

worldPoints = generateCheckerboardPoints(boardSize, squareSize);

[cameraParams, imagesUsed, estimationErrors] = estimateCameraParameters(imagePoints, worldPoints, ...
    'EstimateSkew', false, 'EstimateTangentialDistortion', false, ...
    'NumRadialDistortionCoefficients', 2, 'WorldUnits', 'mm');

for i_=1:itera
    J1 = undistortImage(imagen,cameraParams);
    if i_ > 1
        imagen=J1;
    end    
end

end

%Se muestra la im�gen.
% figure;imshow(J1);
    