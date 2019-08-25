%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Corrige Frame    No FUNCIONÓ
%
%   Corrige cada imagen tomada por la camara usado el patron de corrección
%   Radial y tangencial calculado por la app de MatLab
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


folder_drop_ = '/home/maza/AllMeida/Dropbox/Droplets/Matlab/Droplets/';         % Carpeta de trabajo
carpeta_ = 'folders/' ;                                                         % Subcarpeta de lista de carpetas de imagenes   

%% Subcarpeta de imagenes corregidas
folder_correc_a_ = '/home/maza/AllMeida/Droplets_Video/Correnciones/agua';                                                        
folder_correc_b_ = '/home/maza/AllMeida/Droplets_Video/Correnciones/Agua50-Glicerina';
folder_correc_c_ = '/home/maza/AllMeida/Droplets_Video/Correnciones/glicerina';               
sf_drop_ = ['48';'58';'68';'78']; 

form_img_ = 'jpg';                                                              % Extención de frames (leedir.m)         
%%

%                                                                                 En caso de guardar en carpeta Correnciones

f_drop_ = strcat(folder_drop_, carpeta_,'*.mat' );                              % Construyo el comando para buscar Lista de capetas de los cuadros

l_fdrop_ =   dir(f_drop_);                                                      % Busco las lista de las carpetas de los cuadros

for c_caso_ = 1:4

    load(strcat(carpeta_,l_fdrop_(c_caso_).name));    
    
    dirfold_corect_img_ = strcat(folder_correc_a_,'/',sf_drop_(c_caso_,:));
    folds_correct_img_ = dir(dirfold_corect_img_);

    for num_lanza_ = 3:length(folds_correct_img_)+2
        
        l_img_ncorr_ = leedir(folders_(num_lanza_-2),form_img_); 
        l_img_corre_ = leedir(strcat(dirfold_corect_img_,'/',...
                          folds_correct_img_(num_lanza_).name),form_img_);
            
   
                      
%     
% 
%     for i_ = 1 : length(l_fdrop_)
% 
%         load(strcat(carpeta_,l_fdrop_(i_).name));                                   % Abro la i_(esima) lista de imagenes  
%     %     l_fdrop_(i_).name
% 
%         for j_ = 1 : length(folders_)
% 
%            img_files_ =   leedir(folders_{j_},form_img_);                           % Busco los framne en la caperta de lanzamiento
%     %        folders_{j_}
% 
%     %%                                                                              Imagenes
%            for img_ = 1 : length(img_files_)                                        
% 
% 
% 
%            end
% 
%         end
% 
%     end

    end
end