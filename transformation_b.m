
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Una prueba para probar una transformaci�n projectiva
%   Leo los archivos(leedir.m) --> Los transforma proyectivamente
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
% Cambiar a BMP la carpeta calibration a
%%
clear 
clc
close all

gridfix_names = '/home/maza/AllMeida/Droplets_Video/Calibracion_camara/'; % Diretorio de calibraci�n A de todas las cuadriculas
gridMov_name = '/home/maza/AllMeida/Droplets_Video/Cuadricula/G48C/'; % Directorio de cuadriculas
grid_calibra_plana_name = '/home/maza/AllMeida/Droplets_Video/Cuadricula/Calibration_a/'; % Directorio de todas las cuadriculas planas para calibraCamera
filetype = 'bmp';% Extensi�n de las imagenes.
        
img_grid_FNames = leedir(gridfix_names,filetype);
img_gridG48_FNames = leedir(gridMov_name,filetype);
img_gridfit_FNames = leedir(grid_calibra_plana_name,filetype);

clear gridfix_names gridMov_name grid_calibra_plana_name

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
i_=1
[P2 Tform]  = transform(img_grid_FNames{i_},img_gridG48_FNames{i_},30);

figure,
imshow(P2);
figure
imshowpair(imread(img_gridG48_FNames{i_}),imread(img_grid_FNames{i_}),'montage')

% LINE 16
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           CALIBRACI�N DE CAMARA
%   Leo la imagen a modificar
%   Ingreso el tama�o de los cuadro del tablero de ajedrez usado para calibrar
%   Ingreso el n�mero de iteraciones
%   Uso la funsi�n calibraCamara con esas variables.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% imagen =imread(img_gridfit_FNames{1});
% imagen =imread('D:\Droplets Video\Cuadricula\flit_calibration\cuadricula-a.png')
% squareSize = 2.04;
% intinera = 1;

% [estimationErrors J1]=calibraCamera(imagen,img_grid_FNames, squareSize, intinera );
% 
% figure, imshow(J1)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% LINE 17
% img_FileNames={'C:\Users\Nexus\Desktop\Cuadricula\cuadricula-a.bmp',...
%                     'C:\Users\Nexus\Desktop\Cuadricula\cuadricula-b.bmp',...
%                     'C:\Users\Nexus\Desktop\Cuadricula\cuadricula-c.bmp',...
%                     'C:\Users\Nexus\Desktop\Cuadricula\cuadricula-c.bmp',...
%                     'C:\Users\Nexus\Desktop\Cuadricula\cuadricula-e.bmp',...
%                     'C:\Users\Nexus\Desktop\Cuadricula\cuadricula-f.bmp',...
%                     'C:\Users\Nexus\Desktop\Cuadricula\cuadricula-g.bmp'}
