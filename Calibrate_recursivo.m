%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calibrate_recursivo.m
%
%   Busca todo los parametros de correción usadon estimateCameraParameters
%   lo hago de forma recursiva para todos los caso de estudio para hacer
%   más fluido 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear

folder_drop_a_ = '/home/maza/AllMeida/Droplets_Video/agua/';
folder_drop_b_ = '/home/maza/AllMeida/Droplets_Video/Agua50-Glicerina/';
folder_drop_c_ = '/home/maza/AllMeida/Droplets_Video/glicerina/';
               
forder_save_ = '/home/maza/AllMeida/Dropbox/Droplets/Matlab/Droplets/Calibrate/'; % Carpeta de calibracion%
exten_save_ = '.mat';
sustanci_a_ = '0AG';                                                            
sustanci_b_ = 'AGL';
sustanci_c_ = '0GL';
sf_drop_ = ['48N';'58N';'68N';'78N']; 
subsubfol_drop_ = '/calibra/AVI/IMG';                                             % Subcarpeta de los cuadros de cada video
filetype_drops_ = 'jpg';                                                          % Tipo de Archivo

%%                           Agua

for vid_ = 1:4
    strcat(sf_drop_(vid_,:),' : ', num2str(vid_),'de ',  ' 4 ' )
    
    subfol_drop_ = sf_drop_(vid_,:);
    nm_file_CP_ =strcat(forder_save_,'CP',sustanci_a_,sf_drop_(vid_,:),...      % Direccion del parametro de correción
                        exten_save_);
    nm_file_SE_ =strcat(forder_save_,'SE',sustanci_a_,sf_drop_(vid_,:),...      % Dirección del Error estimado
                        exten_save_);

    folder_drops_ = strcat(folder_drop_a_,subfol_drop_,subsubfol_drop_)         % Carpeta de imagenes

    imageFileNames = leedir(folder_drops_, filetype_drops_ );                   % Busqueda de imagenes el su respectiva carpeta

                                                                                % Igual para todo lo demas.

%%      Calculo de los parametros de correción
    
    % Detect checkerboards in images
    [imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints...
                                                        (imageFileNames);
    imageFileNames = imageFileNames(imagesUsed);

    % Read the first image to obtain image size
    originalImage = imread(imageFileNames{1});
    [mrows, ncols, ~] = size(originalImage);

    % Generate world coordinates of the corners of the squares
    squareSize = 2.600000e+00;  % in units of 'millimeters'
    worldPoints = generateCheckerboardPoints(boardSize, squareSize);

    % Calibrate the camera
    [cameraParams, imagesUsed, estimationErrors] = estimateCameraParameters...
                                                 (imagePoints, worldPoints,...
                'EstimateSkew', true, 'EstimateTangentialDistortion', true,...
         'NumRadialDistortionCoefficients', 2, 'WorldUnits', 'millimeters',...
        'InitialIntrinsicMatrix', [], 'InitialRadialDistortion', [], ...
        'ImageSize', [mrows, ncols]);
    
%%      Salvado de resultados

    save(nm_file_CP_,'cameraParams')
    save(nm_file_SE_,'estimationErrors')

end


%%                          Agua Glicerina
for vid_ = 1:4
    strcat(sf_drop_(vid_,:),' : ', num2str(vid_),'de ',  ' 4 ' ) 
        
    subfol_drop_ = sf_drop_(vid_,:);
    nm_file_CP_ =strcat(forder_save_,'CP',sustanci_b_,sf_drop_(vid_,:),...
                                                            exten_save_);
    nm_file_SE_ =strcat(forder_save_,'SE',sustanci_b_,sf_drop_(vid_,:)...
                                                            ,exten_save_);

     folder_drops_ = strcat(folder_drop_b_,subfol_drop_,subsubfol_drop_)

    imageFileNames = leedir(folder_drops_, filetype_drops_ );



%%      Calculo de los parametros de correción
     
    %folder_ ='D:\Droplets Video\glicerina\48 cm\AVI\rgb\'
    % Detect checkerboards in images
    [imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints...
                                                        (imageFileNames);
    imageFileNames = imageFileNames(imagesUsed);

    % Read the first image to obtain image size
    originalImage = imread(imageFileNames{1});
    [mrows, ncols, ~] = size(originalImage);

    % Generate world coordinates of the corners of the squares
    squareSize = 2.600000e+00;  % in units of 'millimeters'
    worldPoints = generateCheckerboardPoints(boardSize, squareSize);

    % Calibrate the camera
    [cameraParams, imagesUsed, estimationErrors] = estimateCameraParameters...
                                                 (imagePoints, worldPoints,...
                'EstimateSkew', true, 'EstimateTangentialDistortion', true,...
         'NumRadialDistortionCoefficients', 2, 'WorldUnits', 'millimeters',...
        'InitialIntrinsicMatrix', [], 'InitialRadialDistortion', [], ...
        'ImageSize', [mrows, ncols]);
    
%%      Salvado de resultados

    save(nm_file_CP_,'cameraParams')
    save(nm_file_SE_,'estimationErrors')

end




%%                          Glicerina
for vid_ = 1:4
    strcat(sf_drop_(vid_,:),' : ', num2str(vid_),'de ',  ' 4 ' ) 
    
    subfol_drop_ = sf_drop_(vid_,:);
    nm_file_CP_ =strcat(forder_save_,'CP',sustanci_c_,sf_drop_(vid_,:),...
                                                            exten_save_);
    nm_file_SE_ =strcat(forder_save_,'SE',sustanci_c_,sf_drop_(vid_,:),...
                                                            exten_save_);

    folder_drops_ = strcat(folder_drop_c_,subfol_drop_,subsubfol_drop_)

    imageFileNames = leedir(folder_drops_, filetype_drops_ );

    

%%      Calculo de los parametros de correción
    
    % Detect checkerboards in images
    [imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints...
                                                        (imageFileNames);
    imageFileNames = imageFileNames(imagesUsed);

    % Read the first image to obtain image size
    originalImage = imread(imageFileNames{1});
    [mrows, ncols, ~] = size(originalImage);

    % Generate world coordinates of the corners of the squares
    squareSize = 2.600000e+00;  % in units of 'millimeters'
    worldPoints = generateCheckerboardPoints(boardSize, squareSize);

    % Calibrate the camera
    [cameraParams, imagesUsed, estimationErrors] = estimateCameraParameters...
                                                 (imagePoints, worldPoints,...
                'EstimateSkew', true, 'EstimateTangentialDistortion', true,...
         'NumRadialDistortionCoefficients', 2, 'WorldUnits', 'millimeters',...
        'InitialIntrinsicMatrix', [], 'InitialRadialDistortion', [], ...
        'ImageSize', [mrows, ncols]);
    
%%      Salvado de resultados    

    save(nm_file_CP_,'cameraParams')
    save(nm_file_SE_,'estimationErrors')
end