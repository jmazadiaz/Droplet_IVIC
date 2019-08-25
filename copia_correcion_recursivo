%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Corrige Frame
%
%   Corrige cada imagen tomada por la camara usado el patron de corrección
%   Radial y tangencial calculado por la app de MatLab
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


folder_drop_ = '/home/maza/AllMeida/Dropbox/Droplets/Matlab/Droplets/';         % Carpeta de trabajo
carpeta_ = 'folders/' ;                                                         % Subcarpeta de lista de carpetas de imagenes            
calibra_ = 'Calibrate/';                                                        % Subcarpeta de parametros de correción
form_img_ = 'jpg';                                                              % Extención de frames (leedir.m)         

% fold_corregir = strcat(img_files_{img_}(1:35),'Correnciones/Agua/',...
%                        img_files_{img_}(41:44),img_files_{img_}(53:end));
%                                                                                 En caso de guardar en carpeta Correnciones

f_drop_ = strcat(folder_drop_, carpeta_,'*.mat' );                              % Construyo el comando para buscar patrones de correción (dir)

l_fdrop_ =   dir(f_drop_);                                                      % Busco los parametros de correción de la camara


for i_ = 1 : length(l_fdrop_)
    
    load(strcat(carpeta_,l_fdrop_(i_).name));                                   % Abro la i_(esima) lista de imagenes  
%     l_fdrop_(i_).name

    cameraParameters = load(strcat(calibra_,'CP',l_fdrop_(i_).name(7:12),...    % Abro el i_(esimo) parametro de correción 
                                    '.mat'));
       
    
    for j_ = 1 : length(folders_)
        
       img_files_ =   leedir(folders_{j_},form_img_);                           % Busco los framne en la caperta de lanzamiento
%        folders_{j_}
       
%%                                                                              Correcion de las imagenes
       for img_ = 1 : length(img_files_)                                        
           
          img_antes_ =  imread(img_files_{img_});                               % Leo imagen
          img_despues_ = undistortImage(img_antes_,...                          % Corrijo imagen
                                cameraParameters.cameraParams,'nearest',...
                                'OutputView','valid');
          
          imwrite(img_despues_,img_files_{img_});                               % Guardo la imagen corregida
          
       end
        
    end
    
end