%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Agregado a parte D, busca y muestra las propiedades geometricas de
%   cada mancha en la image de la gora fragmentada. Esto permitirá tener la
%   distribución de tamaño. 
%       1) Busca los fragmentos en la imagen en blanco y negro
%       2) Etiqueta los conjuntos conectados 
%       3) Calcula las propiedades
%       4) los calsifica en fragmentos standar y más grandes
%       5) Estudia los fragmentos grandes para determinar una distribucion
%
%  Parte de la linea 23 del "parteD.m", con la image 'd_ibw_' que contiene 
%  una imagen con las gotas del fluido en el aire.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


d_CC_ = bwconncomp(d_ibw_);                                                     % Enumera conjunto de elementos cerrado (1) en una imagen binaria
% d_L2_ = bwlabel(d_ibw_);                                                      % Estaba en la guia de regionprops
d_label_matrix_ = labelmatrix(d_CC_);                                           % Etiqueta cada conjunto con un valor diferente

d_icc = regionprops(d_label_matrix_,'ConvexArea','Centroid',...              % Mide las propiedades de los conjuntos que tengan el mismo valor 
                      'MajorAxisLength','MinorAxisLength','PixelIdxList');
[~,d_temp_index] = sortrows([d_icc.ConvexArea].');                           % Ordena de menor a mayor los elemntos
d_icc = d_icc(d_temp_index(end:-1:1)); 
clear d_temp_index d_CC_ d_label_matrix_                                        
 
d_med_std_ = mean([d_icc.ConvexArea])...                                     % Una medida para escger los conjuntos grandes
             + std([d_icc(10:end).ConvexArea])*3;

d_bckgrnd_img_big_frag_ = false(size(d_ibw_));                                  % imagen de fondo oscura
d_temp_cont_ = 0;                                                               % Contador para quitar luego los elementos estudiados
for i_frag_size_ = 1:length(d_icc)                                           % Bucle para crear una nueva imagen con los conjuntos grandes
    if d_icc(i_frag_size_).ConvexArea >= d_med_std_
       img_big_frag_ = object(d_ibw_,d_icc(i_frag_size_).PixelIdxList);
       d_bckgrnd_img_big_frag_ = d_bckgrnd_img_big_frag_ + img_big_frag_;
       d_temp_cont_ = d_temp_cont_ +1; 
    end
end

d_icc(1:d_temp_cont_) = [];                                                  % Elimino las primeras d_temp_cont_ filas con los grupos grandes
clear d_temp_cont_ d_med_std_ img_big_frag_

%% Watershed                                                                    % Analisis para encontrar fragmentos en manchas grandes

% d_aj_ = d_i2_.*uint8(d_bckgrnd_img_big_frag_);
d_aj_ =  bwdist(~d_bckgrnd_img_big_frag_);
d_aj_ = -d_aj_;
d_aj_(~d_bckgrnd_img_big_frag_) = Inf;
d_l_big_ = watershed(d_aj_,8);
d_l_big_(~d_bckgrnd_img_big_frag_) = 0;

%% Analisis de los fragmentos grandes                                             Repito el estudio de las propiedades del conjuto anterior pero co los
                                                                                % conjuntos grandes separados por Watershed.
d_big_ibw_ = imbinarize(d_l_big_,graythresh(d_l_big_)/10);
d_CC_big_ = bwconncomp(d_big_ibw_);
% d_l2_big_ = bwlabel(d_big_ibw_);                                                % Estaba en la guia de regionprops
d_label2_matrix_ = labelmatrix(d_CC_big_);

d_stats2_ = regionprops(d_label2_matrix_,'ConvexArea','Centroid',...
                      'MajorAxisLength','MinorAxisLength','PixelIdxList');
                  
%%  Juntar todos los fragmentos                                                 % Incluyo los nuevos datos en la variable 'd_stats_'

d_length_stats2_ = length(d_stats2_);

d_icc(end+1:end+d_length_stats2_) = d_stats2_(1:end);
[~,d_temp_index] = sortrows([d_icc.ConvexArea].'); 
d_icc = d_icc(d_temp_index(end:-1:1)); 
clear d_temp_index d_aj_ d_l_big_ d_big_ibw_ d_CC_big_ d_lcc_big_...
      d_length_stats2_

%%  SHOW DATA      

% imshow(d_ibw_)
% hold on
% for i_ = 1:length(d_icc)
% plot(d_icc(i_).Centroid(1),d_icc(i_).Centroid(2), 'r*');
% end
% hold off
