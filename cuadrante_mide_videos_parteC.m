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
load('partes\Partes.mat')                                                       % Abro la variable                            
load('videos\videos.mat') 
 for i_ = 1 :length(Partes) 
        for j_ = 1 : length({Partes{i_,3}.Radios})-3
                
            lineas_ =  videos{i_, j_};
            
            for line_ = 1:length(lineas_(1).fotos)
                
            c_lines_(line_,1) = {lineas_(1).fotos(:,line_)};
            c_lines_(line_,2) = {lineas_(2).fotos(:,line_)};               
            c_lines_(line_,3) = {lineas_(3).fotos(:,line_)};
            c_lines_(line_,4) = {lineas_(1).px_final(line_)};
             
            end
            
            [d_, pd_] = desplazamientor( c_lines_ );
            D_radial{i_,j_} = struct('radio',d_,'centroid', {pd_});
            
 clear lineas_ line_ c_lines_ d_ pd_ 
        end
 end
 clear i_ j_ 
%%    Visualizar radio en imagen plana y luego en la imagen real Imagen
  for i_ = 1 :length(Partes) 
    for j_ = 1 : length({Partes{i_,3}.Radios})-3
        for fotogrm_ = 1 : 3
            [L_, W_] = size(videos{i_, j_}(1).fotos);
            plot_fig(L_,W_) = uint8(1);
            for line_ = 1 : W_
                plot_fig(D_radial{i_,j_}.radio(line_,fotogrm_),line_) = uint8(255);
            end
            Vplot_fig{fotogrm_} = plot_fig;
        end
        Vdes_fig{i_,j_} = Vplot_fig;
  clear fotogrm_ plot_fig Vplot_fig L_ W_ line_
    end
  end
  clear i_ j_
end

if ver_ == true

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

