%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%   Este escript extraera la información de tercera columna de Partes, la
%   cual contiene los datos inherente a la fase de esparcimiento de la
%   gota, esto permitirá cumplir el pirmer objetivo de la proyecto droplets
%   
%   Esta informacion contiene las línea radiales desde el centro del target
%   al extremo de una circunferencia de bresenham, esta líneas tambien son
%   de Bresenham (revisar radial.m). De aca se aplicará divergencia y
%   laplaciano para determinar camvio de contraste y poder determinar el
%   contorno de la sombra y obtener la morfología de la gota
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fila_ = 1;
rad_fila_ = 1;
imshow(Partes{1,3}(fila_).Radios(1).L1)


%% Para reviasar todos a la vez 
caso_  % Contador del caso 
%%
for  vid_ = 1:length(Partes)                %Contador de videos
    for inst_ = 1:length(Partes{vid_,3})  % Contador del instante
       
         for line_ = 1: length(Partes{vid_, 3}(inst_).Radios)
           
           numL_max_ =  length(Partes{vid_, 3}(inst_).Radios(line_).L1)
           
         end
         
      for fotograma_ = 1:3  
        for line_ = 1: length(Partes{vid_, 3}(inst_).Radios)
            t_img_O1_AllLine_(:,line_) = Partes{vid_, 3}(inst_).Radios(line_).L1(20:-1:1,fotograma_);     % hacer algo con el minimo valor de tamaño
            t_img_O2_AllLine_(:,line_) = Partes{vid_, 3}(inst_).Radios(line_).L2(20:-1:1,fotograma_);
            t_img_O3_AllLine_(:,line_) = Partes{vid_, 3}(inst_).Radios(line_).L3(20:-1:1,fotograma_);
            t_img_O4_AllLine_(:,line_) = Partes{vid_, 3}(inst_).Radios(line_).L4(20:-1:1,fotograma_);
            t_img_O5_AllLine_(:,line_) = Partes{vid_, 3}(inst_).Radios(line_).L5(20:-1:1,fotograma_); 
            t_img_O6_AllLine_(:,line_) = Partes{vid_, 3}(inst_).Radios(line_).L6(20:-1:1,fotograma_);
            t_img_O7_AllLine_(:,line_) = Partes{vid_, 3}(inst_).Radios(line_).L7(20:-1:1,fotograma_);
            t_img_O8_AllLine_(:,line_) = Partes{vid_, 3}(inst_).Radios(line_).L8(20:-1:1,fotograma_);
        end
        
        Lines_(inst_,fotograma_)={[t_img_O1_AllLine_,t_img_O2_AllLine_,t_img_O3_AllLine_,...
                                   t_img_O4_AllLine_,t_img_O5_AllLine_,t_img_O6_AllLine_,...
                                   t_img_O7_AllLine_,t_img_O8_AllLine_]};
        
        clear t_img_O1_AllLine_ t_img_O2_AllLine_ t_img_O3_AllLine_ t_img_O4_AllLine_ ...
              t_img_O5_AllLine_ t_img_O6_AllLine_ t_img_O7_AllLine_ t_img_O8_AllLine_
      end
      
          
    end
end


imshow([t_img_O1_AllLine_,t_img_O2_AllLine_,t_img_O3_AllLine_,t_img_O4_AllLine_,...
       t_img_O5_AllLine_,t_img_O6_AllLine_,t_img_O7_AllLine_,t_img_O8_AllLine_])