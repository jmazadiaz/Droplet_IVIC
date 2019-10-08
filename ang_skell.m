%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Name        : ang_skel.m                               
%   Author      : Jesus Enrique Maza Diaz                                
%   Descripción : Es un script para calcular el angulo de la x en el
%   esqueleto de maximo esparcimiento
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
Calcula = false;             Show = true;

if Calcula == true
%%    

ffold_save_ = 'fingering';                                                 % Carpeta para guardar los datos
f_file_ = 'mat';

max_num_ob_ = 3000;


f_finger_ = leedir(ffold_save_,f_file_);

for caso_ind = 1:length(f_finger_)

        load(f_finger_{caso_ind});  % Abre el iesimo caso

        for ind_vid_ = 1:length(fing_file_)                                 
            img_= rgb2gray(imread(fing_file_{ind_vid_}));                   % Imagen en Escala de grises 
            im_bw_ =imcomplement(imbinarize(img_));                         % Inverso de la imagen (La mancha en un conjunto cerrado de elementos)
            im_close_ = bwmorph(im_bw_,'close');                            % Clausura del conjunto en caso de estar abierto
            im_fill_ = imfill(im_close_,'holes');                           % Rellerno de los espacios internos vacios
        temp_cc_ = bwconncomp(im_fill_);                                    % listo los px donde el conjunto esta ubicado
        [~ ,temp_maxPos]=objectMaxSize(temp_cc_,max_num_ob_);               % Escojo el maximo conjunto (Debe ser el correspondiente a la lamina de liquido)
       t_objeto = object(im_fill_ , temp_cc_.PixelIdxList{temp_maxPos(1)}); % Copio en una imagen el objeto mas grande (La lámina de liquido)
       f =regionprops(t_objeto,'centroid');     
       centro_(ind_vid_,:)=floor(f.Centroid);
tp_branch_ (:,:,ind_vid_)= bwmorph(bwmorph(t_objeto,'skel',inf)...
                            ,'branchpoints');                               % Puntos de ramificaciones del esqueleto
p_end_ (:,:,ind_vid_)= bwmorph(bwmorph(t_objeto,'skel',inf),'endpoints');     
        
puntos_(:,ind_vid_) = {regionprops(tp_branch_ (:,:,ind_vid_),'centroid')};


        clear  img_ im_bw_ im_close_calcular_finger_ im_fill_ im_close_ ...
               temp_maxPos t_objeto f
        end
    
        angulos_ = angulo_skel(puntos_,centro_);
        
        ang_skel(caso_ind,1:6) = {f_finger_{caso_ind}(21:25), ...    % Almaceno la informacion anterior por caso
                   str2num(f_finger_{caso_ind}(24:25)), ...
                   tp_branch_ ,p_end_,angulos_,centro_};        

clear tp_branch_ p_end_ ind_vid_ bw_fill_all_ temp_cc_   angulos_   centro_...
      puntos_
end
clear   max_num_ob_         f_finger_       caso_ind       f_file_      ...
        ffold_save_         fing_file_

end
%%
if Show == true
%%    
 poss = ventPos ( 760 ,3600 , 380, 320);
 
    i_cs_ =11;
    
    for i_vid_ = 1:length(ang_skel{i_cs_,5})
    
        t_ang_ = ang_skel{i_cs_,5}{i_vid_,1};
        t_indC13 = ang_skel{i_cs_,5}{i_vid_,2};
        t_indC24 = ang_skel{i_cs_,5}{i_vid_,3};
        
        for i_ = 1: length(t_indC13)
            x13_(i_) = t_ang_{t_indC13(i_),1}(1);
            y13_(i_) = t_ang_{t_indC13(i_),1}(2);
        end
    clear i_
        for i_ = 1: length(t_indC24)
            x24_(i_) = t_ang_{t_indC24(i_),1}(1);
            y24_(i_) = t_ang_{t_indC24(i_),1}(2);
        end
        
figure1 = figure('position',poss{i_vid_},'ToolBar','none','MenuBar','none'...
                ,'Name',strcat('XSkell : ',ang_skel{i_cs_,1},'-',num2str(i_vid_))...
                ,'NumberTitle','off');
        
%       figure1 = figure('WindowState','maximized');
        % Create axes
        axes = axes('Parent',figure1);
        hold(axes,'on');
        
image(axes,ang_skel{i_cs_,3}(:,:,i_vid_),'Parent',axes,'CDataMapping','scaled');
hold on
image(axes,ang_skel{i_cs_,4}(:,:,i_vid_),'Parent',axes,'CDataMapping','scaled');
        
    createfigure_ang_skel13(axes,x13_, y13_);
    hold on
    createfigure_ang_skel24(axes,x24_, y24_);
    ylim(axes,[1 256]);                  % Limita el eje y
    xlim(axes,[1 256]);                  %Limita el eje x
        
    clear figure1 axes
    end
    
end
    
