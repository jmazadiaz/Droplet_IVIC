%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%   cuadrante_mide_videos_parteC.m                                                  Partes{i,3}(j)Radios(k).L#(l,m)
%   Input                                                                        
%       videos =  Estructura que contine la imagen de cada instante de raidal   > m = fotogramas (de 1 a 3)  
%   Output                                                                      > l = Px de la linea (1 = centro l = Punto final) 
%                                                                               > # = Numero del octante de 1 a 8  
%                                                                               > k = Linea del octante
%   Este escript permite calcular el punto final de la sombra de la gota        > j = Instante de tiempo (1 inicio del sparcimiento , j fin del mismo)
%   esparciendose para cada linea de pixeles desde el centro del target         > i = Video de análisis.
%   hasta el exterior. La información contenida en la variable "Videos" 
%   corresponde a lineas desde el centro hasta un punto de una
%   circunferencia de Bresenham de radio variable (asociado al
%   esparcimiento), tomadas de la variable Partes, de 3 fotogramas 
%   sucesivos en todos los octantes, en cada instante de tiempo del
%   esparcimiento de todos los videos de un fenómeno.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

calcula_ = false;
ver_ = true;

if calcula_ == true
clear D_radial Partes Vdes_fig videos
load('partes\parteC_g48.mat')                                                       % Abrir las variable prefijas                           
load('videos\vid_g48.mat') 
 for i_ = 1 :length(Partes)                                                     % For para los Videos 
        for j_ = 1 : length({Partes{i_,3}.Radios})-3                            % for para los instantes
                
            lineas_ =  videos{i_, j_};                                          % Copio todas las líneas de 1 video i_ del instante j_ aparte para analizar
            
            for line_ = 1:length(lineas_(1).fotos)                              % Bucle para las líneas
                
            c_lines_(line_,1) = {lineas_(1).fotos(:,line_)};                    % Primer Fotograma
            c_lines_(line_,2) = {lineas_(2).fotos(:,line_)};                    % Segundo Fotorgrama
            c_lines_(line_,3) = {lineas_(3).fotos(:,line_)};                    % Tercer fotograma
            c_lines_(line_,4) = {lineas_(1).px_final(line_)};                   % coordenada del punto exterior.
             
            end
            
            [d_, pd_] = desplazamientor( c_lines_ );                            % Devuelve los puntos de mayor contrate entre la sombra y fondo claro
            D_radial{i_,j_} = struct('radio',d_,'centroid', {pd_});             % Almacena los datos en una variable para poder pasar al siguiente instante
            
 clear lineas_ line_ c_lines_ d_ pd_                                            % Borra las varaibles temporales para no tene problemas
        end                                                                     % Cambia de video
 end
 clear i_ j_                                                                    % Borra las variables de bucle
%%    Visualizar radio en imagen plana y luego en la imagen real Imagen
  for i_ = 1 :length(Partes)                                                    % For para los Videos  
    for j_ = 1 : length({Partes{i_,3}.Radios})-3                                % for para los instantes
        for fotogrm_ = 1 : 3                                                    % Bucle para Fotogramas
            [L_, W_] = size(videos{i_, j_}(1).fotos);                           % Largo y ancho de la imagen de todas las líneas
            plot_fig(L_,W_) = uint8(1);                                         % Creo imagen negra del tamaño de la imagen
            for line_ = 1 : W_                                                  % Bucle para lineas verticales en la imagen
                plot_fig(D_radial{i_,j_}.radio(line_,fotogrm_),line_)...        % Cabio a blanco el punto donde hay el cambio de contraste
                                      = uint8(255);
            end
            Vplot_fig{fotogrm_} = plot_fig;                                     % Almaceno el resultado en una celda con el resto de los fotogramas
        end
        Vdes_fig{i_,j_} = Vplot_fig;                                            % Almaceno todos los fotogramas en una celda para cada instante (horizontal) y cada video (Vertical)
  clear fotogrm_ plot_fig Vplot_fig L_ W_ line_                                 % Borro las variables para seguridad de dejar sectores desocupados
    end
  end
  clear i_ j_
end

if ver_ == true                                                                 % Condicional para visualizar los resultados sobrepuestos en la imagen real

  for i_ = 1 :length(Partes) 
    for j_ = 1 : length({Partes{i_,3}.Radios})-3
        subplot(3,1,1)
        imshowpair(Vdes_fig{i_,j_}{1,1},videos{i_, j_}(1).fotos)
        subplot(3,1,2)
        imshowpair(Vdes_fig{i_,j_}{1,2},videos{i_, j_}(2).fotos)
        subplot(3,1,3)
        imshowpair(Vdes_fig{i_,j_}{1,3},videos{i_, j_}(3).fotos)
        
        pause
    end
  end
end



