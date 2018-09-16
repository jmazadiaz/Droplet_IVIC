%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       desplazamientor.m
%   Input
%       lineas = Es una estructura que contiene las líneas del centro a
%                cada punto de un circunferencia de Bresenham
%   Output
%       d = matriz que coniten el indice del maximo valor de la primera y
%           la segunda derivada.
%
% Esta función mide el desplazamiento de la sombra de gota en una estructura
% que contiene las lineas radiales entre el centro y el borde de una
% circunferencia de Bresenham de radio r copiada de 3 imagenes subsecuentes
% del fenómeno
%
%   d(i_,1) = Maximo de la primera imagen de la iesima linea
%   d(i_,2) = Maximo de la segunda imagen de la iesima linea
%   d(i_,3) = Maximo de la tercera imagen de la iesima linea
%   d(i_,4) = Cordenada x extremo de la linea estudiada
%   d(i_,5) = Cordenada 7 extremo de la linea estudiada
%
%   NOTA: Como la linea de Bresemhan puede cambiar, la linea para las tres
%   imagenes sucesivas es la misma.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

alfunction [d pd] = desplazamientor( lineas)
    pd(1,1:2) = [0 0];
    for i_=1:length(lineas)
          
%         I1_ = cell2mat(lineas(i_,1));
%         I2_ = cell2mat(lineas(i_,2));
%         I3_ = cell2mat(lineas(i_,3));
        
        temIph1_ = parcial(cell2mat(lineas(i_,1))); %  Copio temporalmente los valores
        temIph2_ = parcial(cell2mat(lineas(i_,2))); %  de la derivada de lineas 
        temIph3_ = parcial(cell2mat(lineas(i_,3))); %  de 3 imagenes sucesivas.
        
        temIIph1_ = parciald(cell2mat(lineas(i_,1))); % Copio temporalmente los valores
        temIIph2_ = parciald(cell2mat(lineas(i_,2))); % de la derivada 2da de las líneas
        temIIph3_ = parciald(cell2mat(lineas(i_,3))); % de 3 imagenes sucesivas
        
        maxIh1_ = find(temIph1_ == max(temIph1_));    % Encuentra el maximo valor de la 
        maxIh2_ = find(temIph2_ == max(temIph2_));    % primera deriva.
        maxIh3_ = find(temIph3_ == max(temIph3_));
        
        maxIIh1_ = find(temIIph1_ == max(temIIph1_)); % Encuentra el maximo valor de la 
        maxIIh2_ = find(temIIph2_ == max(temIIph2_)); % segunda derivada.
        maxIIh3_ = find(temIIph3_ == max(temIIph3_));
        
%             if  length(maxIIh1_) == length(maxIh1_) == 1
%                 d(i_) = maxIh1_;
%             elseif length(maxIh1_) == 1 
%                 tmaxII1_ = sum(maxIIh1_(1:end))/length(maxIIh1_);
%                 d(i_) = round((tmaxII1_ + maxIh1_)/2);
%             elseif length(maxIIh1_) == 1
%                 tmaxI1_ = sum(maxIh1_(1:end))/length(maxIh1_);
%                 d(i_) = round((tmaxI1_ + maxIh1_)/2);
%             else
%                 tmaxI1_ = sum(maxIh1_(1:end))/length(maxIh1_);
%                 tmaxII1_ = sum(maxIIh1_(1:end))/length(maxIIh1_);
%                 d(i_) = round((tmaxII1_ + tmaxI1_)/2);
%             end

              d(i_,1) = desplazamientorif(maxIIh1_,maxIh1_); %  maximo de linea i_ del la imagen 1
              d(i_,2) = desplazamientorif(maxIIh2_,maxIh2_); %  maximo de linea i_ del la imagen 2
              d(i_,3) = desplazamientorif(maxIIh3_,maxIh3_); %  maximo de linea i_ del la imagen 3
              pd(i_,:) = lineas{i_,4};                  %   Coordenada x,y del fin del al linea
                                  
     end
end
