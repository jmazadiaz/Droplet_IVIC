%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       leerdir.m
%   Input
%    d_name = Dirección del directorio de imagenes 'D:\Droplets Video\Cuadricula\cuadricula48G'
%    filetype = formato de las imagénes 'png'
%   Output
%    img_Fnames = el nombre y dirección de los archivos en el directorios
%
% Esta función busca todos los archivos con la extensión de "filetype" y los coloca en un
% vector con la dirección completa de cada archivo a conseguido con la
% extensión
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function img_FNames = leedir(d_name,filetype)

dir_ = strcat(d_name,'\*.',filetype);
files_ = dir(dir_);

    for i_=1:length(files_)
        img_FNames{i_} = strcat(d_name,'\',files_(i_).name);
    end, clear files_ i_;

end

