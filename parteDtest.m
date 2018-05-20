%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   
%   Este script es para explorar las partes de cada vídeo  en el conjunto de
%   imagenes extraidas de los videos
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
clear
% clc
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%         CONTROL PRINCIPAL                          %%
%%
    num_ = 2;
    video_ = 'img-g48-';
    folder_drops_ = strcat('D:\Droplets Video\glicerina\48 cm\AVI\IMG\',video_,num2str(num_)); %Recore el diretorio
    filetype_drops_ = 'jpg';% Tipo de Archivo

    archivo = leedir(folder_drops_, filetype_drops_ );
    
    clear folder_drops_ filetype_drops_
    
    
%% 
    
    ind_ = 219;
    part_ = 26;
    
%%    
    nun_cc_ = 4;%(4o8)specifies the desired connectivivty for the connected components
    nun1_cc_ = 8; % Para escogel el target
    T_bw_ = 62;     % Maximo valor en binarización
    T1_bw_ = 120;
    inv_ = true;    %Inverso del binarizaciónm
    T_O_= 10;       %Numero de pixels para objetos grandes en la imagen
    a_=6.875533829; % Área del target en mm^2
    
%%  
    valor_ = 180; % Valor de incremento
    max_ = 180; % Maximo valor de pixel en la zona de estudio
    min_ = 0; % Minimo valor de pixel en la zona de estudio
    
%%    Identifica el target del primer frame del video
%       

    i1_ = rgb2gray(imread(archivo{1})); % Lee pirmera imagen
    i1_bw_ = binarizacion(i1_,T1_bw_,inv_);%  Binariza,(inversion true) 1 todas por encia de T1-bw_ = 115 y cero por debajo 
    
    cc1_ = bwconncomp(i1_bw_, nun1_cc_);%   Busca el objeto cerrado (target)
    target_ = cc1_.PixelIdxList{1};    % Lista de pixel del target  para tomarlos en cuenta luego.
%%
    
    i_ =imread(archivo{ind_});   %COPIA EL MAPA DE BITS EN i  % Arriba  ind_
    
    i2_=rgb2gray(i_);            %TRANSFORMA A i DE RGB A ESCALAS DE GRISES 
    
   figi2_ = objectplus(i2_ ,target_, valor_, max_ , min_ );% Esta función aumenta todos los valores de la lista de pixel valor_=180
    
    ibw_=binarizacion(figi2_,T_bw_,inv_);    %BINARIZA i2 INVIRTIENDO LOS COLORES  %Ariba T_bw_ inv_
    
    icc=bwconncomp(ibw_, nun_cc_);       %ANALISIS TOPOLOGICO DE LA IMAGEN BLANCO Y NEGRO
   
    [is2max, is2maxpos]=objectMaxSize(icc,T_O_);  %ORDENA DE MAYOR A MENOS TAMAÑO LOS OBJETOS     % Arriba T_O_
   
    for i_ = 1:length(is2maxpos)    %COPIA TODO LOS OBJETOS ENCONTRADOS POR SEPARADO  
        s_ibw(1,i_) = {object(ibw_,icc.PixelIdxList{is2maxpos(i_)})};
        if length(is2maxpos)< 4
            for j_=length(is2maxpos)+1:4
            s_ibw(1,j_) = {ones(256,256)};
            end
            clear j_
        elseif length(is2maxpos)< 6
            for j_=length(is2maxpos)+1:6
            s_ibw(1,j_) = {ones(256,256)};
            end
            clear j_
        elseif length(is2maxpos)< 9
            for j_=length(is2maxpos)+1:9
            s_ibw(1,j_) = {ones(256,256)};
            end
            clear j_
        end
            
    end
    clear i_
    
    
    
%%          SHOW SECTION
figure 
imshow(figi2_)

    figure                
   
    shg
    L = 1920;
    W = 1000;
    a=1;
    b=1;
    set(gcf,'position',[a b L W])
   
    
    
    if length(is2maxpos) <= 4
        
        subplot(2,2,1)
            imshow(cell2mat(s_ibw(1,1+part_)))
            hold on
             title(['Numero de objetos: ',num2str(icc.NumObjects)])
%               plot(iTcentroids(1),iTcentroids(2),'*b')
                title([num2str(icc.NumObjects),'objetos - ','fragmento ',num2str(1+part_)])
            hold off
        subplot(2,2,2)
            imshow(cell2mat(s_ibw(1,2+part_)))
            hold on
%               plot(iTcentroids(1),iTcentroids(2),'*b')
                title(['fragmento ',num2str(2+part_)])
            hold off
        subplot(2,2,3)
            imshow(cell2mat(s_ibw(1,3+part_)))
            hold on
%                plot(i2Tcentroids(1),i2Tcentroids(2),'*b')
                title(['fragmento ',num2str(3+part_)])
                hold off
        subplot(2,2,4)
            imshow(cell2mat(s_ibw(1,4+part_)))
            hold on
                title(['fragmento ',num2str(4+part_)])
                title(['Carpeta ',video_,num2str(num_)])
            hold off
    end
%%      
    if length(is2maxpos) <= 6
        
        subplot(2,3,1)
            imshow(cell2mat(s_ibw(1,1+part_)))
            hold on
%               plot(iTcentroids(1),iTcentroids(2),'*b')
                title([num2str(icc.NumObjects),'objetos - ','fragmento ',num2str(1+part_)])
            hold off
        subplot(2,3,2)
            imshow(cell2mat(s_ibw(1,2+part_)))
            hold on
%               plot(iTcentroids(1),iTcentroids(2),'*b')
               title(['fragmento ',num2str(2+part_)])
            hold off
        subplot(2,3,3)
            imshow(cell2mat(s_ibw(1,3+part_)))
            hold on
%                plot(i2Tcentroids(1),i2Tcentroids(2),'*b')
                title(['Numero de objetos: ',num2str(icc.NumObjects)])
            hold off
        subplot(2,3,4)
            imshow(cell2mat(s_ibw(1,4+part_)))
            hold on
%               plot(jTcentroids(1),jTcentroids(2),'*r')
                title(['fragmento ',num2str(4+part_)])
            hold off
        subplot(2,3,5)
            imshow(cell2mat(s_ibw(1,5+part_)))
            hold on
%               plot(jTcentroids(1),jTcentroids(2),'*r')
                 title(['fragmento ',num2str(5+part_)])
            hold off
        subplot(2,3,6)
            imshow(cell2mat(s_ibw(1,6+part_)))
            hold on
%               plot(jTcentroids(1),jTcentroids(2),'*r')
                title(['fragmento ',num2str(6+part_)])      
            hold off    
    end
%%
if length(is2maxpos) >= 9
        
        subplot(3,3,1)
            imshow(cell2mat(s_ibw(1,1+part_)))
            hold on
%               plot(iTcentroids(1),iTcentroids(2),'*b')
                title([num2str(icc.NumObjects),'objetos - ','  fragmento ',num2str(1+part_)])
            hold off
        subplot(3,3,2)
            imshow(cell2mat(s_ibw(1,2+part_)))
            hold on
%               plot(iTcentroids(1),iTcentroids(2),'*b')
                title(['fragmento ',num2str(2+part_)])
            hold off
        subplot(3,3,3)
            imshow(cell2mat(s_ibw(1,3+part_)))
            hold on
%                plot(i2Tcentroids(1),i2Tcentroids(2),'*b')

                title(['fragmento ',num2str(3+part_)])
            hold off
        subplot(3,3,4)
            imshow(cell2mat(s_ibw(1,4+part_)))
            hold on
%               plot(jTcentroids(1),jTcentroids(2),'*r')
                title(['fragmento ',num2str(4+part_)])
            hold off
        subplot(3,3,5)
            imshow(cell2mat(s_ibw(1,5+part_)))
            hold on
%               plot(jTcentroids(1),jTcentroids(2),'*r')
                title(['fragmento ',num2str(5+part_)])
            hold off
        subplot(3,3,6)
            imshow(cell2mat(s_ibw(1,6+part_)))
            hold on
%               plot(jTcentroids(1),jTcentroids(2),'*r')
                title(['fragmento ',num2str(6+part_)])
            hold off
        subplot(3,3,7)
            imshow(cell2mat(s_ibw(1,7+part_)))
            hold on
%               plot(jTcentroids(1),jTcentroids(2),'*r')
                 title(['fragmento ',num2str(7+part_)])
            hold off
        subplot(3,3,8)
            imshow(cell2mat(s_ibw(1,8+part_)))
            hold on
%               plot(jTcentroids(1),jTcentroids(2),'*r')
                title(['fragmento ',num2str(8+part_)])
            hold off
        subplot(3,3,9)
            imshow(cell2mat(s_ibw(1,9+part_)))
            hold on
%               plot(jTcentroids(1),jTcentroids(2),'*r')
                title(['fragmento ',num2str(9+part_)])
            hold off                
    end
    
    