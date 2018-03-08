%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Este script analiza los cuadros en una lista y aliza el esparcimiento
%   de la gota, área, centroide, perimetro.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


nombre='D:\Droplets Video\glicerina\48 cm\AVI\IMG\img-g48-1\'; %Recore el diretorio
ruta=strcat(nombre,'*.jpg');%concatena el directorio con la extesion de los archivos
lee_archivos = dir(ruta); %el formato de imagen puede ser modificado.


% [end_,~]=size(lee_archivos);
since_ =168;
end_ = 280;

fin_=end_-since_+1;

table(1:fin_,1:6) = 0;

table(1,1) = 1/5400* since_;
ind_=1;


    for(i_=since_:end_)
                
        archivo = lee_archivos(i_).name;
        i=imread(strcat(nombre,archivo));

        i2=rgb2gray(i);
        bw1=binarizacion(i2,70);
        bw3 = imcomplement(bw1);

        cc=bwconncomp(bw3,4);
        cc.NumObjects;
        drop = object(bw3,cc.PixelIdxList{1});


%         [center,radii]= centre(bw3);
        [area,centre_j,centre_i,perimeter,radii] = centre(bw3);

        table(ind_,2)=radii;
        table(ind_,3)=perimeter;
        table(ind_,4)=area;
        table(ind_,5)=centre_i;
        table(ind_,6)=centre_j;
        
        if ind_+1 ~= fin_+1
        table(ind_+1,1)= table(ind_,1)+1.8519e-04;
        end
        ind_=ind_ + 1;
    end