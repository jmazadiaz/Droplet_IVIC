%%      Apertura de la image
nombre='D:\Droplets Video\glicerina\48 cm\AVI\IMG\img-g48-1\'; %Recore el diretorio
ruta=strcat(nombre,'*.jpg');%concatena el directorio con la extesion de los archivos
lee_archivos = dir(ruta); %el formato de imagen puede ser modificado.
dir_mod='IMG_mod\';% Directorio en la ruta con imagenes modificadas;

%%      Contornos considerados + carpetas
target= 'target';       mkdir(strcat(nombre,dir_mod,target));
comienzo= 'comienzo';   mkdir(strcat(nombre,dir_mod,comienzo));
final = 'final';        mkdir(strcat(nombre,dir_mod,final));
rota = 'rota';          mkdir(strcat(nombre,dir_mod,rota));

%%
mkdir(strcat(nombre,dir_mod))
%%      Buclee para todos los archivos

[num_archivos,~] = size(lee_archivos);

    for frame = 1:num_archivos 


        archivo = lee_archivos(frame).name;
        i=imread(strcat(nombre,archivo));

        %%    Step 1: Acquire Image

        fabric = imread(strcat(nombre,archivo));
        
%         figure(1), imshow(fabric), title('fabric');

        %%     Step 2: Calculate Sample Colors in L*a*b* Color Space for Each Region

        load('region_coordenadas.mat')

        nColors = 4;
        sample_regions = false([size(fabric,1) size(fabric,2) nColors]);

        for count = 1:nColors
          sample_regions(:,:,count) = roipoly(fabric,region_coor(:,1,count),region_coor(:,2,count));
        end

        %%      Muestas imagenes
        
%         subplot(2,3,1)
%         imshow(i(:,:,1)),title('sample region for target');
%         subplot(2,3,2)
%         imshow(i(:,:,2)),title('');

        %%

        lab_fabric = rgb2lab(fabric);     

        a = lab_fabric(:,:,2);  
        b = lab_fabric(:,:,3);
        color_markers = zeros([nColors, 2]);

        for count = 1:nColors
          color_markers(count,1) = mean2(a(sample_regions(:,:,count)));
          color_markers(count,2) = mean2(b(sample_regions(:,:,count)));
        end

        % fprintf('[%0.3f,%0.3f] \n',color_markers(2,1),color_markers(2,2)); 

        %%    Step 3: Classify Each Pixel Using the Nearest Neighbor Rule

        color_labels = 0:nColors-1;

        a = double(a);
        b = double(b);
        distance = zeros([size(a), nColors]);

        for count = 1:nColors
          distance(:,:,count) = ( (a - color_markers(count,1)).^2 + ...
                              (b - color_markers(count,2)).^2 ).^0.5;
        end

        [~, label] = min(distance,[],3);
        label = color_labels(label);
        clear distanc

        %%    Step 4: Display Results of Nearest Neighbor Classification

        rgb_label = repmat(label,[1 1 3]);
        segmented_images = zeros([size(fabric), nColors],'uint8');

        for count = 1:nColors
          color = fabric;
          color(rgb_label ~= color_labels(count)) = 0;
          segmented_images(:,:,:,count) = color;
        end 
        %%%%            Muestras los resutados
%         subplot(2,3,3)
%         imshow(segmented_images(:,:,:,1)), title(strcat(target,'objects'));
%         subplot(2,3,4)
%         imshow(segmented_images(:,:,:,2)), title(strcat(comienzo ,'objects'));
%         subplot(2,3,5)
%         imshow(segmented_images(:,:,:,3)), title(strcat(final, 'objects'));
%         subplot(2,3,6)
%         imshow(segmented_images(:,:,:,4)), title(strcat(rota, 'objects'));

        %%%           Copia imagenes
        
        tar = segmented_images(:,:,:,1);
        com = segmented_images(:,:,:,2);
        fin = segmented_images(:,:,:,3);
        rot = segmented_images(:,:,:,4);

        imwrite(tar,strcat(nombre,dir_mod,target,'\',lee_archivos(frame).name));
        imwrite(com,strcat(nombre,dir_mod,comienzo,'\',lee_archivos(frame).name));
        imwrite(fin,strcat(nombre,dir_mod,final,'\',lee_archivos(frame).name));
        imwrite(rot,strcat(nombre,dir_mod,rota,'\',lee_archivos(frame).name));

    end