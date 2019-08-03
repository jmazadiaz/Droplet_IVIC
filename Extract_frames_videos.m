%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Este script permite extraer los cuadros de una lista de videos
% enumerados a partir de su raiz y su extensi�n. Y guardarlos en una carpeta
% ~IMG\video-#\ que el mismo crea.  
%                                                                        
%    " raiz_vid = 'XXXX'  "  COLOCAR LA RAIZ DE LOS VIDEOS
%    " ext = '.XXX'     "  COLOCAR LA TEXTENSI�N DE LOS VIDEOS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear
%%D:\Droplets Video\glicerina\48 cm\AVI
folder_drop_ = '/home/maza/AllMeida/Droplets_Video/Agua50-Glicerina/';  %   Carpeta principal
sustanci_ = 'AG';    %%%%    CAMBIAR     %%%%    %   Inicial de la sustancia
subfol_drop_ = '78'; %%%%   CAMBIAR     %%%%    %   Sub carpeta de los videos CINE
subsubfol_drop_ = '/AVI';                   %   Sub carpeta de los videos AVI
filetype_drops_ = 'avi';% Tipo de Archivo

%folder_ ='D:\Droplets Video\glicerina\48 cm\AVI\rgb\'
r_vid_ =strcat(sustanci_,subfol_drop_,'-');
folder_drops_ = strcat(folder_drop_,subfol_drop_,subsubfol_drop_)
file_folders_ = strcat('folders/folder',r_vid_)
%ext  = '.avi'

archivo_ = leedir(folder_drops_, filetype_drops_ );

mkdir(strcat(folder_drops_,'/IMG/'));
mesg_='Porcentaje de la tarea  :  ';
%%
for i_ = 1: length(archivo_)
    dir_  = strcat(folder_drops_,'/IMG/img-',r_vid_,num2str(i_));
    folders_{i_} = dir_;
    porcentaje_ = floor(i_/length(archivo_)*100);
    
    mkdir(dir_)
    
    if true
        vidObj_ = VideoReader(archivo_{i_});
        read(vidObj_, Inf);
    end
           
    for  img_ = 1:vidObj_.NumberOfFrames;
        
         if img_>99
                add_='/f';
         end
         if img_<=99
                add_='/f0';
         end
         if img_<=9
            add_='/f00';
         end
          
            filename = strcat(dir_,add_,num2str(img_),'.jpg');
            tempimg = read(vidObj_,img_); 
           % tempgray = rgb2gray(tempimg);%                                     Convertir en Ggray
           % imwrite(imfilter(tempgray,fspecial('log',[6 6],1)),filename);%     Con filtro gausiano y lapalciano
            imwrite(tempimg,filename);
    end
   
   strcat(mesg_,num2str(porcentaje_), ' %') 
end 

save(file_folders_,'folders_')



