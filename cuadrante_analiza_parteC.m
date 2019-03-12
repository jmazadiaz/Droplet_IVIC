%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%   cuadrante_analiza_parteC.m                                                  Partes{i,3}(j)Radios(k).L#(l,m)
%   Input                                                                        
%       Partes =  Estructuraque contine las lineas radiales tomadas de los      > m = fotogramas (de 1 a 3)  
%   Output                                                                      > l = Px de la linea (1 = centro l = Punto final) 
%      videos{#video, Instante,1gris/2BW}(fotograma).>fotos o px_final<         > # = Numero del octante de 1 a 8  
%                                                                               > k = Linea del octante
%   Este escript permite exportar la sombra de la gota esparciendose            > j = Instante de tiempo (1 inicio del sparcimiento , j fin del mismo)
%   para cada linea de pixeles desde el centro del target hasta el              > i = Video de análisis.
%   exterior para así ser medida aparte. La información contenida en 
%   la variable "Partes" corresponde a lineas tomadas desde el centro 
%   hasta un punto de una circunferencia de Bresenham de radio variable
%   (asociado al esparcimiento) de 3 fotogramas sucesivos en todos los
%   octantes, en cada instante de tiempo del esparcimiento de todos los 
%   videos de un fenómeno.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;      clear;

load('partes\parteC_g48.mat')                                                       % Abro la variable                            

 ver = false
 calcula = true

if calcula == 1
    folfer = 'videos\'

    file= strcat(folfer,'vid_g48');
%     filebw = strcat(folfer,'bw_vid_g48')
 for i_ = 1 :length(Partes)                                                     % Video
   
     for  j_ = 1 :length({Partes{i_,3}.Radios})-3                               % Instante

     Num_line_ =  length({Partes{i_,3}(j_).Radios.L1});                         % Número de líneas
     Num_pxline_ = length(Partes{i_,3}(j_).Radios(1).L1);                       % Numero de pixels de cada línea
     
     foto_1_(1:Num_pxline_,1:Num_line_*5) = uint8(255);
            foto_2_ = foto_1_;              foto_3_ = foto_1_; 
     
        for k_ = 1 : Num_line_                                                  % Linea
            
            cuadrante_analiza_parteC_PRT_A_Line                                 % ln1_max1_ ln1_max2_ ln1_max3_ ln1_max4_ ln1_max5_ ln1_max6_ ln1_max7_ ln1_max8_ 
                                                                                % ln2_max1_ ln2_max2_ ln2_max3_ ln2_max4_ ln2_max5_ ln2_max6_ ln2_max7_ ln2_max8_
                                                                                % ln3_max1_ ln3_max2_ ln3_max3_ ln3_max4_ ln3_max5_ ln3_max6_ ln3_max7_ ln3_max8_
            
            cuadrante_analiza_parteC_B_fotos                                    % Salida foto_1_, foto_2_, foto_3_ y  px_final_foto 
            
        clear ln1_max1_ ln1_max2_ ln1_max3_ ln1_max4_...
              ln1_max5_ ln1_max6_ ln1_max7_ ln1_max8_...
              ln2_max1_ ln2_max2_ ln2_max3_ ln2_max4_...
              ln2_max5_ ln2_max6_ ln2_max7_ ln2_max8_...
              ln3_max1_ ln3_max2_ ln3_max3_ ln3_max4_...
              ln3_max5_ ln3_max6_ ln3_max7_ ln3_max8_...
                 
        end 
        
      foto_{1} = foto_1_;   foto_{2} = foto_2_;                                 % Agrupo los 3 fotogramas con el mismo punto en una estructura
      foto_{3} = foto_3_;    
      
      if j_ <= floor((length({Partes{i_,3}.Radios})-3)/2)  
          bwfoto_{1} = imfill(imcomplement(im2bw(foto_1_,0.25)),'holes');           % Agrupo los 3 fotogramas en blanco y negro con el mismo punto en una estructura 
          bwfoto_{2} = imfill(imcomplement(im2bw(foto_2_,0.25)),'holes');
          bwfoto_{3} = imfill(imcomplement(im2bw(foto_3_,0.25)),'holes');
      elseif j_ > floor((length({Partes{i_,3}.Radios})-3)/2)
          bwfoto_{1} = imfill(imcomplement(im2bw(foto_1_,0.4)),'holes');           % Agrupo los 3 fotogramas en blanco y negro con el mismo punto en una estructura 
          bwfoto_{2} = imfill(imcomplement(im2bw(foto_2_,0.4)),'holes');
          bwfoto_{3} = imfill(imcomplement(im2bw(foto_3_,0.4)),'holes');
      end
      videos{i_,j_,1} = struct('fotos',foto_,'px_final',{px_final_foto_});        % Hacemos una estructura con todas las lineas en cada instante de 3 imagenes sucesivas 
      videos{i_,j_,2} = struct('fotos',bwfoto_,'px_final',{px_final_foto_});      % Hacemos una estructura con todas las lineas en cada instante de 3 imagenes sucesivas en Blanco y negro
      % con el mismo punto.
      clear foto_ px_final_foto_  foto_1_ foto_2_ foto_3_     

     end
 end
      save(file,'videos')                                                      % Luego sustituir por lista de videos
%       save(filebw,'bwvid')                                                     % Guardando 'videos' y 'bwvid'
end
 clear i_ j_ k_
 

 
 if ver == true
    load('videos\vid_g48.mat')   
    for i_ = 1 :length(Partes) 
        for j_ = 1 : length({Partes{i_,3}.Radios})-3
        
            subplot(3,1,1)
            imshow(videos{i_, j_,2}(1).fotos)
            subplot(3,1,2)
            imshow(videos{i_, j_,2}(2).fotos)
            subplot(3,1,3)
            imshow(videos{i_, j_,2}(3).fotos)
         pause
        end
    end
            
 end
         
%         subplot(3,1,1)
%         imshow(videos{i_, j_}(1).fotos)
%         subplot(3,1,2)
%         imshow(videos{i_, j_}(2).fotos)
%         subplot(3,1,3)
%         imshow(videos{i_, j_}(3).fotos)
        