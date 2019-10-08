%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Name        : img_transicion.m                               
%   Author      : Jesus Enrique Maza Diaz                                
%   Descripción : Busco colocar todas las imagenes en forma sucesivas para 
%                 observar en cada impacto la evolución morofologica 
%                 durante la transicion.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear

Fold_ = 'folders';    Indices_ = 'indice';       f_file_ = 'media/imagen/';
f_type_ = 'mat';                                 f_img_ = 'jpg';



f_fold_ =  leedir(Fold_,f_type_);     f_indi_ = leedir(Indices_,f_type_);

clear        Folder_              Indices_               f_type_

for caso_ = 1: length(f_fold_)  

load(f_fold_{caso_});           load(f_indi_{caso_});

file_ = strcat(f_file_,f_indi_{caso_}(13:17),'.png');

for vid_ =1:length(folders_)
    archivo_ =  leedir(folders_{vid_},f_img_);
    
    Imagen = unionimg(archivo_,indices_);
    [y,x]=size(Imagen);
    ImgAll(1+y*(vid_-1):vid_*y, 1:x) = Imagen;

    clear    Imagen
    
    
end

imwrite(ImgAll,file_);
clear ImgAll vid_  y   x
end