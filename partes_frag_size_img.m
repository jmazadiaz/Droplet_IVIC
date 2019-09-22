%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Name        : partes_frag_size_img.m                               
%   Author      : Jesus Enrique Maza Diaz                                
%   Descripción : Es un script para extraer de Partes vieja una imagen con
%   todos los fragmentos, la razon es que no quiero arreglar mas fotos y
%   aqui esta todo fino solo que no tiene la misma clase con la que
%   trabajé.
%
%   A veces la presencia de sobras en la imagen puede obtener un objeto mas
%   grande que el target, para prevenir esto cambie el tamaño del objeto.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear

prueba = false;

f_folders_ =  leedir('folders','mat');
f_indice_ =  leedir('indice','mat');

max_num_px = 600;
max_lv_intens = 100;
max_ = 160;
obj_=2;


for ind_ = 1: length(f_folders_)

% ind_ = 1

   load(f_folders_{ind_}); 
   load(f_indice_{ind_});
   
   file_ = strcat('partes/partes_',f_indice_{ind_}(13:17));
   
    if length(folders_) == length(indices_) &...
       min(f_folders_{ind_}(16:20) == f_indice_{ind_}(13:17))
        
     for video_ = 1:30  %length(folders_) 
% video_ = 30
        archivo_ = leedir(folders_{video_},'jpg');
         
        t_img_target_ = rgb2gray(imread(archivo_{indices_(video_,1)}));
        t_img_frag_ =  rgb2gray(imread(archivo_{indices_(video_,10)}));
        
        
%         max_ = mode(mode(t_img_target_,2))/2+min(min(t_img_target_));
        t_bw_target_ = binarizacion(t_img_target_,max_,1);
        t_bw_ = imfill(t_bw_target_,'hole');
        
        
        t_cc_target_ = bwconncomp(t_bw_, 4);
        [~ , maxPos]=objectMaxSize(t_cc_target_,max_num_px);
        no_trg  = earsetarget(t_img_frag_,...
                              t_cc_target_.PixelIdxList{ maxPos(obj_)});
clear t_img_target_         t_img_frag_         ...
      t_bw_target_          t_cc_target_        t_bw_       maxPos
         
       
        d_ibw_ = binarizacion(no_trg,max_lv_intens,1); 
        
        imshowpair(no_trg,d_ibw_,'montage')
if    prueba == false    
     %      Recive imagen en blanco y negro de las machas      d_ibw_ 
        prueba_dist_size_fragment



        %%Esto es igual que parteD.m y Cuadrante para generar Partes
        d_tab = struct2table(d_icc);
        Partes(video_,4)={table2struct(d_tab)};
else
imshowpair(no_trg,d_ibw_,'montage')
clear d_ibw_ d_icc d_tab fragmetos_
% pause
end

     end
       
   else
error('Diferentes archivos en las carpetas indice y folders')
    end
   
 if    prueba == false      
     save(file_,'Partes')
 end
end