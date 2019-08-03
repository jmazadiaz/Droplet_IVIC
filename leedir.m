%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       leerdir.m
%   Input
%    d_name = Direcci�n del directorio de imagenes 'D:\Droplets Video\Cuadricula\cuadricula48G'
%    filetype = formato de las imag�nes 'png'
%   Output
%    img_Fnames = el nombre y direcci�n de los archivos en el directorios
%
% Esta funci�n busca todos los archivos con la extensi�n de "filetype" y los coloca en un
% vector con la direcci�n completa de cada archivo a conseguido con la
% extensi�n
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function img_FNames = leedir(d_name,filetype)

dir_ = strcat(d_name,'/*.',filetype);
files_ = dir(dir_);

    for i_=1:length(files_)
        img_FNames{i_} = strcat(d_name,'/',files_(i_).name);
    end, clear files_ i_;

end

