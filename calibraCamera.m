%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    calibraCamera.m
%   Input 
%       imagen = imagen para aplicar correción
%       imageFileNames_calibration = dirección de las imagenes de calibación
%       squareSize = tamaño del cuadro en milimetros
%       itera = Numero de iteraciones de la modificación
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% imageFileNames_calibration = dir('C:\Users\maza\Desktop\Conjunto de...
% cuadricula calibbración\Calibration_a\*.png'); imagen ; squareSize =...
% 2,04; intinera = 24;


function [estimationErrors J1]=calibraCamera(imagen,imageFileNames_calibration, squareSize, itera )
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

%Se muestra la imágen.
% figure;imshow(J1);
    