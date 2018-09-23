%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%   Este escript extrae de todos los archivos de la carpeta partes (carpeta 
% que contiene los datos de todos los caso a estudiar) para hacer un
% promedio del numero de fragmento de cada lanzamiento en cada caso, 
% luego un promedio del tamaño de cada fragmento, y por ultimo el tamaño 
% de fragmento más abundante con su dispersión; todo se graficará con 
% respecto a la energía.    
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all

calcula_ = true;       show_  = false;

folder_ = 'partes\'; 
file_partes_ = dir(strcat(folder_,'*.mat'));

%%  Figure

horizontala_1_ = 0;        Verticala_1_ = 45;      X1 = 1000;     Y1 = 450;
horizontala_2_ = 930;      Verticala_2_ = 525;    X2 = 680;     Y2 = 470;
horizontalb_2_ = 630;      horizontalb_3_ = 1270; 


if calcula_ == true
 clear dec_frag_ elmt_frag_ frag_med_ frag_size_ med_desv_ Partes
    %%  Extracción de la información 
    
    for caso_ = 1:length(file_partes_)   

        load(strcat(folder_,file_partes_(caso_).name));                             % Abre el caso de estudio
        file_partes_(caso_).name(8:10);                                             % Nombre del caso

        for indi_ = 1: length(Partes)

            Num_de_objetos(indi_,1) = Partes{indi_,4}.Num_Objetos;

            for objeto_ = 1: length(Partes{indi_,4}.Objetos); 

               ob_ = regionprops(Partes{indi_,4}.Objetos{1,objeto_},'area');
               ob_area(indi_,objeto_) = ob_.Area;

            end

        end

        Area_Fragmentos = sort(ob_area,2);
        

        table_ = table(Num_de_objetos,Area_Fragmentos);
        frag_size_(caso_,1:3) = {file_partes_(caso_).name(8:11),...
                                str2num(file_partes_(caso_).name(10:11)), table_,};
        
 clear Num_de_objetos ob_area Area_Fragmentos
 
    end
    
      clear  file_partes_ caso_ indi_ objeto_ ob_ ob_area...
          Area_Fragmentos table_ Num_de_objetos 
    
%%    Debería excluir las particulas con 2 veces la dispersión de tamaños

for caso_ = 1:length(frag_size_)
    [end_indi_ end_column_] =size(frag_size_{caso_,3}.Area_Fragmentos);
    
    for indi_ = 1: end_indi_
        temp_std_(indi_,:) = std(frag_size_{caso_,3}.Area_Fragmentos(indi_,:));
        temp_mean_(indi_,:) = mean(frag_size_{caso_,3}.Area_Fragmentos(indi_,:));
    end

    clear indi 
    for indi_ = 1: end_indi_
        for column_ = 1:end_column_
        outliers(indi_,column_) = (frag_size_{caso_,3}.Area_Fragmentos(indi_,column_)...
                             - temp_mean_(indi_)) > 2*temp_std_(indi_);
%         fsize_NAN_(caso_,:) = frag_size_{caso_,3}.Area_Fragmentos;
        end
    end
    
     cantidad_(1:end_indi_,1)=0;
for i_ = 1:end_indi_
    for j_ = 1:end_column_
        if outliers(i_,j_)==1
            cantidad_(i_)=cantidad_(i_)+outliers(i_,j_);
        end
    end
end
    frag_size_{caso_,3}.Num_de_objetos= frag_size_{caso_,3}.Num_de_objetos - cantidad_;
    frag_size_{caso_,3}.Area_Fragmentos(outliers) = 0;
    
clear outliers std_caso_ mean_caso_ indi_ temp_std_ temp_mean_ cantidad_ i_ j_
end
 

    %% Calculo de los promedios 
    
    
    
    for md_ = 1: length(frag_size_)  
        
        [end_ind_ ~] =size(frag_size_{md_, 3}.Area_Fragmentos);
        
        med_desv_ (md_,1) = frag_size_{md_,2} ;
        med_desv_ (md_,2) = mean(frag_size_{md_,3}.Num_de_objetos);                 % Promedoio del número de particulas
        med_desv_ (md_,3) = median(frag_size_{md_,3}.Num_de_objetos);               % Valor 
        med_desv_ (md_,4) = std(frag_size_{md_,3}.Num_de_objetos);                  % Desviacion
        
        frag_med_ (md_,1) = frag_size_{md_,2} ;
        
        for ind_ = 1:end_ind_
            if frag_size_{md_,3}.Num_de_objetos(ind_) == 0
                break
            else
        tmp_frag_(ind_) = sum(frag_size_{md_,3}.Area_Fragmentos...                   % Promedio del tamaño de las particulas 
                           (ind_,:))/frag_size_{md_,3}.Num_de_objetos(ind_); 
        temp_desv_frag_(ind_) = std(frag_size_{md_,3}.Area_Fragmentos(ind_,:));      % D3esviación
        
        temp_median_frag_(ind_) = median(frag_size_{md_,3}.Area_Fragmentos...        % Promedio del tamaño de las particulas 
                                  (ind_,:));
            end
        end
        
        frag_med_ (md_,2) = mean(tmp_frag_);
        frag_med_ (md_,3) = mean(temp_median_frag_);
        frag_med_ (md_,4) = mean(temp_desv_frag_);
        clear temp_desv_frag_ temp_frag_
    end

    
    %%  Cantidad de fragmentos con rango de pixel de 10 en 10
    
    for indice_ = 1 :length(frag_size_)                                             % For para cada caso en frag_size_.
        
        [end_frag_ ~ ]= size(frag_size_{indice_,3});                                % Determino las filas de frag_size_{indice,3}.   
        frag_ = frag_size_{indice_,3}.Area_Fragmentos;                              % Copio Area_Fragmentos en frag_.
        dec_frag_(indice_,1:floor(max(max(frag_)/10))+1) = 0;                       % Contador de elementos por margen de tamaño (10 en 10 Px2).
        elmt_frag_ (indice_,1:floor((max(max(frag_)))/10)+1) = {0};                 % Celda que contiene los elementos contados en margen de tamaños (10 en 10 Px2).
                    
                
        for f_frag_ = 1:  end_frag_
          for c_frag = 1 : length(frag_)
           tmp_area_ = frag_(f_frag_,c_frag);
           tmp_frag_ = floor(tmp_area_/10)+1;

           if tmp_area_ ~= 0
            dec_frag_(indice_,tmp_frag_) = dec_frag_(tmp_frag_) +1;                 % Cuenta los elementos en esa casilla

            if elmt_frag_{indice_,tmp_frag_} == 0
              elmt_frag_{indice_,tmp_frag_} = frag_(f_frag_,c_frag);                % Sustitulle el 0 por el primer elemento en la casilla
            else
              elmt_frag_ {indice_,tmp_frag_} = [elmt_frag_{indice_,tmp_frag_},...   % Agrega un nuevo valor al ya existente en la celda
                                        frag_(f_frag_,c_frag)];
            end
           end
          end
        end
        clear frag_ end_frag_ tmp_area_ tmp_frag_ f_frag_ c_frag
    end
end
  clear indice_
%% Error estandar del tamaño de fragmentos cada 10 en 10 PX2 Buscar forma de visualizar esto

[end_caso_ end_frag]=size(elmt_frag_);

for parte_ = 1:end_caso_
    for frag_ = 1:end_frag
        if length(elmt_frag_{parte_,frag_}) == 0
            break
        else
        elemt_frag_std_(parte_,frag_) = std(elmt_frag_{parte_,frag_})/sqrt(length(elmt_frag_{parte_,frag_}));
        end
    end
end

clear parte_ frag_ end_caso_ end_frag
%%  Median y desviation Fragmentos

for indice_ = 1 :length(frag_size_) 
    
    temp_elmt_frag_ = elmt_frag_(indice_,:);                                        % Aparto el caso para no tener que hacer todos los elementos(Hay casillas vacias)
    
    for ind_ = 1:length(temp_elmt_frag_)
      if isempty(cell2mat(temp_elmt_frag_(ind_)))                                   % Limitador, En caso de haber una casilla vacia va al siguente caso
        break
      elseif max(cell2mat(temp_elmt_frag_(2))) ~=0                                  % Solo trabajar con las casilas que tiene tamaños de fragmentos y no con las vacias
        
        std_elmt_frag_(indice_,ind_) = std(cell2mat(...                             % Dispersión de la distribución de tamaños entre un margen de tamaño
                                           temp_elmt_frag_(ind_)));                 
        mean_elmt_frag_(indice_,ind_) = mean(cell2mat(...                           % Promedio de la distribución de tamaños entre un margen de tamaño
                                             temp_elmt_frag_(ind_)));
        median_elmt_frag_(indice_,ind_) = median(cell2mat(...                       % Mediana de la distribución de tamaños entre un margen de tamaño
                                                 temp_elmt_frag_(ind_)));       
      end
    end
clear temp_elmt_frag_ 
end

clear indice_ ind_ 

if show_ == true

     figure
 shg
 set(gcf,'position',[horizontala_1_ Verticala_1_ X1 Y1])
     subplot(1,2,1)
        plot(med_desv_(1:4,1),med_desv_(1:4,2),'bo')
        % errorbar(med_desv_(1:4,1),med_desv_(1:4,2),med_desv_(1:4,3))
        hold on
        plot(med_desv_(5:8,1),med_desv_(5:8,2),'g*')
        % errorbar(med_desv_(5:8,1),med_desv_(5:8,2),med_desv_(5:8,3))
        hold on
        plot(med_desv_(9:12,1),med_desv_(9:12,2),'b+')
        % errorbar(med_desv_(9:12,1),med_desv_(9:12,2),med_desv_(9:12,3))

        xlabel('Altura (cm)');            ylabel('Número de Fragmentos'); 
                    title('Promedio de número de tamaños por lanzamiento')

      subplot(1,2,2)    
        plot(med_desv_(1:4,1),med_desv_(1:4,3),'bo')
        % errorbar(med_desv_(1:4,1),med_desv_(1:4,2),med_desv_(1:4,3))
        hold on
        plot(med_desv_(5:8,1),med_desv_(5:8,3),'g*')
        % errorbar(med_desv_(5:8,1),med_desv_(5:8,2),med_desv_(5:8,3))
        hold on
        plot(med_desv_(9:12,1),med_desv_(9:12,3),'b+')
        % errorbar(med_desv_(9:12,1),med_desv_(9:12,2),med_desv_(9:12,3))

        xlabel('Altura (cm)');            ylabel('Número de Fragmentos (moda) (Px^2)'); 
                    title('Tamaño promedio de fragmentos(moda)')
                    legend('Agua','Glicerina','Ag-Gl','Location','northwest',-1)  
%%     
      figure
   shg
   set(gcf,'position',[horizontala_2_ Verticala_1_ X1 Y1])
      subplot(1,2,1)
        plot(frag_med_(1:4,1),frag_med_(1:4,2),'bo')
        % errorbar(frag_med_(1:4,1),frag_med_(1:4,2),frag_med_(1:4,3))
        hold on
        plot(frag_med_(5:8,1),frag_med_(5:8,2),'g*')
        % errorbar(frag_med_(5:8,1),frag_med_(5:8,2),frag_med_(5:8,3))
        hold on
        plot(frag_med_(9:12,1),frag_med_(9:12,2),'b+')
        % errorbar(frag_med_(9:12,1),frag_med_(9:12,2),frag_med_(9:12,3))
                      
      subplot(1,2,2)
        plot(frag_med_(1:4,1),frag_med_(1:4,3),'bo')
        % errorbar(frag_med_(1:4,1),frag_med_(1:4,2),frag_med_(1:4,3))
        hold on
        plot(frag_med_(5:8,1),frag_med_(5:8,3),'g*')
        % errorbar(frag_med_(5:8,1),frag_med_(5:8,2),frag_med_(5:8,3))
        hold on
        plot(frag_med_(9:12,1),frag_med_(9:12,3),'b+')
        % errorbar(frag_med_(9:12,1),frag_med_(9:12,2),frag_med_(9:12,3))

        xlabel('Altura (cm)');            ylabel('Número de Fragmentos (moda) (Px^2)'); 
                    title('Tamaño promedio de fragmentos(moda)')
                    legend('Agua','Glicerina','Ag-Gl','Location','northwest',-1)      
            
    
%%            
    figure
 shg
 set(gcf,'position',[horizontala_1_ Verticala_2_ X2 Y2])    
    subplot(1,4,1)
    hist(frag_size_{1, 3}.Area_Fragmentos)
    title(strcat('D. Size 0A -',frag_size_{1,1}))
    subplot(1,4,2)
    hist(frag_size_{2, 3}.Area_Fragmentos)
    title(strcat('D. Size 0A -',frag_size_{2,1}))
    subplot(1,4,3)
    hist(frag_size_{3, 3}.Area_Fragmentos)
    title(strcat('D. Size 0A --',frag_size_{3,1}))
    subplot(1,4,4)
    hist(frag_size_{4, 3}.Area_Fragmentos)
    title(strcat('D. Size 0A -',frag_size_{4,1}))
    
    figure
 shg
 set(gcf,'position',[horizontalb_2_ Verticala_2_ X2 Y2])        
    subplot(1,4,1)
    hist(frag_size_{5, 3}.Area_Fragmentos)
    title(strcat('D. Size 0G -',frag_size_{5,1}))
    subplot(1,4,2)
    hist(frag_size_{6, 3}.Area_Fragmentos)
    title(strcat('D. Size 0G -',frag_size_{6,1}))
    subplot(1,4,3)
    hist(frag_size_{7, 3}.Area_Fragmentos)
    title(strcat('D. Size 0G -',frag_size_{7,1}))
    subplot(1,4,4)
    hist(frag_size_{8, 3}.Area_Fragmentos)
    title(strcat('D. Size 0G -',frag_size_{8,1}))
    
    figure
 shg
 set(gcf,'position',[horizontalb_3_ Verticala_2_ X2 Y2])        
    subplot(1,4,1)
    hist(frag_size_{9, 3}.Area_Fragmentos)
    title(strcat('D. Size AG -',frag_size_{9,1}))
    subplot(1,4,2)
    hist(frag_size_{10, 3}.Area_Fragmentos)
    title(strcat('D. Size AG -',frag_size_{10,1}))
    subplot(1,4,3)
    hist(frag_size_{11, 3}.Area_Fragmentos)
    title(strcat('D. Size AG -',frag_size_{11,1}))
    subplot(1,4,4)
    hist(frag_size_{12, 3}.Area_Fragmentos)
    title(strcat('D. Size AG -',frag_size_{12,1}))
    
end

clear horizontala_1_  Verticala_1_  X1 Y1 horizontala_2_ ...
      horizontalb_2_ horizontalb_3_  Verticala_2_ X2 Y2 ...
      ind_ md_ calcula_ show_ c end_ind_ folder_ temp_median_frag_
