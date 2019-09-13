%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Name        : prom_frag_size.m                               
%   Author      : Jesus Enrique Maza Diaz                                
%   Descripción : Este escript extrae de todos los archivos de la carpeta 
%                 partes (carpeta que contiene los datos de todos los caso 
%                 a estudiar)  para  hacer  un  promedio  del  numero  de 
%                 fragmento de cada lanzamiento en cada caso, luego un 
%                 promedio del tamaño de cada fragmento, y por ultimo el 
%                 tamaño de fragmento mas abundante con su dispersion; 
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all

z_calcula_ = true;       z_show_  = true;

%%                  Control
z_folder_ = 'partes/'; 
z_file_partes_ = dir(strcat(z_folder_,'*.mat'));
z_img_ = zeros(256,256);

%  Variables para Mostrar Figure

zhorizontala_ = 0;        zVerticala_ = 45;      zX1 = 1920;    zY1 = 1080;

%      Titulos de los gráficos

for ind_titulo_ = 1:length(z_file_partes_)
   title_histogram_(ind_titulo_,:) = strcat('Distribución de tamaños :'...
                                  ,z_file_partes_(ind_titulo_).name(8:12));
   title_img_(ind_titulo_,:) = strcat('Todos los impactos de :'...
                                  ,z_file_partes_(ind_titulo_).name(8:12));
end
clear ind_titulo_

%%                      Cualculo 

if z_calcula_ == true
 
  clear dec_frag_ elmt_frag_ frag_med_ frag_size_ med_desv_ Partes 
       
 %%                  Extracci�n de la informaci�n 
    
    for caso_ = 1:length(z_file_partes_)   

        load(strcat(z_folder_,z_file_partes_(caso_).name));                     % Abre el caso de estudio
        z_file_partes_(caso_).name(8:10);                                       % Nombre del caso

        for ind_vid_ = 1: length(Partes)                                        % Bucle para los videos

            Num_de_objetos(ind_vid_,1) = length(Partes{ind_vid_,4});

            for objeto_ = 1: length(Partes{ind_vid_,4});                        % Bucle para los objetos en cada video(Es la imagen final, no hay evoluci�n temporal)    

              px_list_ = vertcat(Partes{ind_vid_,4}(objeto_).PixelIdxList);
              bwfigure = object(z_img_ ,px_list_);
                    
              ob_ = regionprops(bwfigure,'area','ConvexArea');                  % Calc�lo el �rea en Px de cada objeto
              ob_area(ind_vid_,objeto_) = ob_.Area;                             % Alamaceno el �rea para cada fragmento
              ob_Cvxarea(ind_vid_,objeto_) = ob_.ConvexArea;
              clear px_list_
            end

    
    
            %%  Imagen todos los fragmentos
            
    

            
    px_list_all_ = vertcat(Partes{ind_vid_,4}.PixelIdxList);
    bw_figure_all_(:,:,ind_vid_) = object(z_img_ ,px_list_all_);
    clear px_list_all_
            

        end

        Area_Fragmentos = sort(ob_area,2);                                      % Ordenos todos los elementos de menor a mayor para cada objeto (avance horizontal) para cada video (avance vertical)
        table_ = table(Num_de_objetos,Area_Fragmentos);                         % Genero la tabla  para numero de objeto y tama�o de framento para el caso

%%                  Estadistica y Ajuste
        
        Area_Fragmentos(Area_Fragmentos == 0) = [];
        Fit_dist =  fitdist(Area_Fragmentos','Gamma');
%%                  DATA

        frag_size_(caso_,1:5) = {z_file_partes_(caso_).name(8:12),...           % Almaceno la informaci�n anterior por caso
                                str2num(z_file_partes_(caso_).name(11:12)),...
                                table_,Fit_dist,bw_figure_all_};
 clear Num_de_objetos ob_area Area_Fragmentos                                   % Borro variables temporales para volver a calcular
 
    end                                                                         % Siguiente Caso.
    
      clear  file_partes_ caso_ indi_ objeto_ ob_ ob_area...                    % Borro el resto de variables para liberar memoria
             Area_Fragmentos table_ Num_de_objetos 
    

end

%%                            Muestra de datos
if z_show_ == true
    
%     sh_caso_ =2;
    n_beans_ =8;
 
       
    for sh_caso_ = 1:length(frag_size_);
figure1 = figure('Name',strcat('Img. frag.todos : '...                      % Titulo de ventana
                ,frag_size_{sh_caso_}),'NumberTitle','off');
 shg;       set(gcf,'position',[zhorizontala_ zVerticala_ zX1 zY1])         % Coordenad y tamaño de la ventana
 
    subplot(1,2,1)                                                          % Histograma de frecuencia relativas acumuladas
         histogram(vertcat(frag_size_{sh_caso_, 3}.Area_Fragmentos(:)),...
                   'BinWidth',n_beans_,'Normalization','pdf')
         title(strcat(title_histogram_(sh_caso_,:),' - ',...
                   frag_size_{sh_caso_,4}.ParameterDescription{1},'= ', ...
                   num2str(frag_size_{sh_caso_,4}.a),'---',...
                   frag_size_{sh_caso_,4}.ParameterDescription{2},'= ', ...
                   num2str(frag_size_{sh_caso_,4}.b)))
         xlabel('tamaño de fragmento');  
         ylabel('Densidad de Probabilidad estimada ci/(N.wi)');
         x_valor_ = -20 : max(frag_size_{sh_caso_, 3}.Area_Fragmentos(:)+50);
         y_valor_ = pdf(frag_size_{sh_caso_, 4},x_valor_);
         hold on
         plot(x_valor_,y_valor_,'LineWidth',2);
    subplot(1,2,2)
        bw2_figure_all_ = frag_size_{ sh_caso_ ,5};
        
        imshow(...                                                          % Imagen de todas las imagenes finales con la gota fragmentada.
[bw2_figure_all_(:,:,1)  bw2_figure_all_(:,:,2)  bw2_figure_all_(:,:,3)...
bw2_figure_all_(:,:,4)  bw2_figure_all_(:,:,5)  bw2_figure_all_(:,:,6);...
bw2_figure_all_(:,:,7)  bw2_figure_all_(:,:,8)  bw2_figure_all_(:,:,9)...
bw2_figure_all_(:,:,10) bw2_figure_all_(:,:,11) bw2_figure_all_(:,:,12);...
bw2_figure_all_(:,:,13) bw2_figure_all_(:,:,14) bw2_figure_all_(:,:,15)...
bw2_figure_all_(:,:,16) bw2_figure_all_(:,:,17) bw2_figure_all_(:,:,18);...
bw2_figure_all_(:,:,19) bw2_figure_all_(:,:,20) bw2_figure_all_(:,:,21)...
bw2_figure_all_(:,:,22) bw2_figure_all_(:,:,23) bw2_figure_all_(:,:,24);...
bw2_figure_all_(:,:,25) bw2_figure_all_(:,:,26) bw2_figure_all_(:,:,27)...
bw2_figure_all_(:,:,28) bw2_figure_all_(:,:,29) bw2_figure_all_(:,:,30)]);
    end
end
        



% ax1 = axes('Position',[0.1 0.1 .8 .42],'Box','on');
% ax2 = axes('Position',[0.1 0.56 .8 .42],'Box','on');

%              
%     figure
%  shg
%  set(gcf,'position',[zhorizontala_1_ zVerticala_2_ zX2 zY2])    
%     subplot(1,4,1)
%     h_boud(frag_size_{1, 3}.Area_Fragmentos)
%     title(strcat('D. Size 0A -',frag_size_{1,1}))
%     subplot(1,4,2)
%     h_boud(frag_size_{2, 3}.Area_Fragmentos)
%     title(strcat('D. Size 0A -',frag_size_{2,1}))
%     subplot(1,4,3)
%     h_boud(frag_size_{3, 3}.Area_Fragmentos)
%     title(strcat('D. Size 0A --',frag_size_{3,1}))
%     subplot(1,4,4)
%     h_boud(frag_size_{4, 3}.Area_Fragmentos)
%     title(strcat('D. Size 0A -',frag_size_{4,1}))
%     
%     figure
%  shg
%  set(gcf,'position',[zhorizontalb_2_ zVerticala_2_ zX2 zY2])        
%     subplot(1,4,1)
%     h_boud(frag_size_{5, 3}.Area_Fragmentos)
%     title(strcat('D. Size 0G -',frag_size_{5,1}))
%     subplot(1,4,2)
%     h_boud(frag_size_{6, 3}.Area_Fragmentos)
%     title(strcat('D. Size 0G -',frag_size_{6,1}))
%     subplot(1,4,3)
%     h_boud(frag_size_{7, 3}.Area_Fragmentos)
%     title(strcat('D. Size 0G -',frag_size_{7,1}))
%     subplot(1,4,4)
%     h_boud(frag_size_{8, 3}.Area_Fragmentos)
%     title(strcat('D. Size 0G -',frag_size_{8,1}))
%     
%     figure
%  shg
%  set(gcf,'position',[zhorizontalb_3_ zVerticala_2_ zX2 zY2])        
%     subplot(1,4,1)
%     h_boud(frag_size_{9, 3}.Area_Fragmentos)
%     title(strcat('D. Size AG -',frag_size_{9,1}))
%     subplot(1,4,2)
%     h_boud(frag_size_{10, 3}.Area_Fragmentos)
%     title(strcat('D. Size AG -',frag_size_{10,1}))
%     subplot(1,4,3)
%     h_boud(frag_size_{11, 3}.Area_Fragmentos)
%     title(strcat('D. Size AG -',frag_size_{11,1}))
%     subplot(1,4,4)
%     h_boud(frag_size_{12, 3}.Area_Fragmentos)
%     title(strcat('D. Size AG -',frag_size_{12,1}))
%     
% end
% 
% clear horizontala_1_  Verticala_1_  X1 Y1 horizontala_2_ ...
%       horizontalb_2_ horizontalb_3_  Verticala_2_ X2 Y2 ...
%       ind_ md_ calcula_ show_ c end_ind_ folder_ temp_median_frag_
