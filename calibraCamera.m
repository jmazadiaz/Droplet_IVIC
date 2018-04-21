%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    calibraCamera.m
%   Input 
%       imagen = imagen para aplicar correci�n
%       imageFileNames_calibration = direcci�n de las imagenes de calibaci�n
%       squareSize = tama�o del cuadro en milimetros
%       itera = Numero de iteraciones de la modificaci�n
%   Output
%       estimationErrors =  Error estimado de la correci�n
%       J1 = la imagen de entrada 'imagen' corregida
%
% Es una funci�n que analizar un mismo tablero de ajedrez en diferentes
% imagenes tomadas en diferentes lugares de un plano f�jo de una lente
% para medir la curbatura agregada por la lente en sus extremos por medio
% de la funci�n 'estimateCameraParameters' y decuerve el patron de
% correci�n y el respectivo error.
%   
%   Puede modificarse para que corrija muchas imagenes o devuelva el factor
%   de correci�n para hacer la corecci�n en otra funci�n
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% imageFileNames_calibration = dir('C:\Users\maza\Desktop\Conjunto de...
% cuadricula calibbraci�n\Calibration_a\*.png'); imagen ; squareSize =...
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

%Se muestra la im�gen.
% figure;imshow(J1);
    