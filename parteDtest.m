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
    
    ind_ = 1;
    part_ = 1;
    
%%    
    nun_cc_ = 8;    %(4o8)specifies the desired connectivivty for the connected components
    T_bw_ = 115;     % Maximo valor en binarización
    inv_ = true;    %Inverso del binarizaciónm
    T_O_= 10;       %Numero de pixels para objetos grandes en la imagen
    a_=6.875533829; % Área del target en mm^2
    
%%    

    i=imread(archivo{ind_});   %COPIA EL MAPA DE BITS EN i  % Arriba  ind_
    
    i2=rgb2gray(i);            %TRANSFORMA A i DE RGB A ESCALAS DE GRISES 
    
    ibw_=binarizacion(i2,T_bw_,inv_);    %BINARIZA i2 INVIRTIENDO LOS COLORES  %Ariba T_bw_ inv_
    
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
%     shg
%     L = 1920;
%     W = 1000;
%     a=1;
%     b=1;
%     set(gcf,'position',[a b L W])
   
    
    
    if length(is2maxpos) <= 4
        
        subplot(2,2,1)
            imshow(cell2mat(s_ibw(1,1)))
            hold on
%               plot(iTcentroids(1),iTcentroids(2),'*b')
%               title(['Carpeta ',video_,num2str(num_)])
            hold off
        subplot(2,2,2)
            imshow(cell2mat(s_ibw(1,2)))
            hold on
%               plot(iTcentroids(1),iTcentroids(2),'*b')
%               title(['Imagen ',num2str(ind_)])
            hold off
        subplot(2,2,3)
            imshow(cell2mat(s_ibw(1,3)))
            hold on
%                plot(i2Tcentroids(1),i2Tcentroids(2),'*b')
                title(['Numero de objetos: ',num2str(icc.NumObjects)])
            hold off
        subplot(2,2,4)
            imshow(cell2mat(s_ibw(1,4)))
            hold on
%               plot(jTcentroids(1),jTcentroids(2),'*r')
                title(['Carpeta ',video_,num2str(num_)])
            hold off
    end
%%      
    if length(is2maxpos) <= 6
        
        subplot(2,3,1)
            imshow(cell2mat(s_ibw(1,1)))
            hold on
%               plot(iTcentroids(1),iTcentroids(2),'*b')
%               title(['Carpeta ',video_,num2str(num_)])
            hold off
        subplot(2,3,2)
            imshow(cell2mat(s_ibw(1,2)))
            hold on
%               plot(iTcentroids(1),iTcentroids(2),'*b')
%               title(['Imagen ',num2str(ind_)])
            hold off
        subplot(2,3,3)
            imshow(cell2mat(s_ibw(1,3)))
            hold on
%                plot(i2Tcentroids(1),i2Tcentroids(2),'*b')
                title(['Numero de objetos: ',num2str(icc.NumObjects)])
            hold off
        subplot(2,3,4)
            imshow(cell2mat(s_ibw(1,4)))
            hold on
%               plot(jTcentroids(1),jTcentroids(2),'*r')
                title(['Carpeta ',video_,num2str(num_)])
            hold off
        subplot(2,3,5)
            imshow(cell2mat(s_ibw(1,5)))
            hold on
%               plot(jTcentroids(1),jTcentroids(2),'*r')
                title(['Carpeta ',video_,num2str(num_)])
            hold off
        subplot(2,3,6)
            imshow(cell2mat(s_ibw(1,6)))
            hold on
%               plot(jTcentroids(1),jTcentroids(2),'*r')
                title(['Carpeta ',video_,num2str(num_)])
            hold off    
    end
%%
if length(is2maxpos) <= 9
        
        subplot(3,3,1)
            imshow(cell2mat(s_ibw(1,1)))
            hold on
%               plot(iTcentroids(1),iTcentroids(2),'*b')
%               title(['Carpeta ',video_,num2str(num_)])
            hold off
        subplot(3,3,2)
            imshow(cell2mat(s_ibw(1,2)))
            hold on
%               plot(iTcentroids(1),iTcentroids(2),'*b')
%               title(['Imagen ',num2str(ind_)])
            hold off
        subplot(3,3,3)
            imshow(cell2mat(s_ibw(1,3)))
            hold on
%                plot(i2Tcentroids(1),i2Tcentroids(2),'*b')
                title(['Numero de objetos: ',num2str(icc.NumObjects)])
            hold off
        subplot(3,3,4)
            imshow(cell2mat(s_ibw(1,4)))
            hold on
%               plot(jTcentroids(1),jTcentroids(2),'*r')
                title(['Carpeta ',video_,num2str(num_)])
            hold off
        subplot(3,3,5)
            imshow(cell2mat(s_ibw(1,5)))
            hold on
%               plot(jTcentroids(1),jTcentroids(2),'*r')
                title(['Carpeta ',video_,num2str(num_)])
            hold off
        subplot(3,3,6)
            imshow(cell2mat(s_ibw(1,6)))
            hold on
%               plot(jTcentroids(1),jTcentroids(2),'*r')
                title(['Carpeta ',video_,num2str(num_)])
            hold off
        subplot(3,3,7)
            imshow(cell2mat(s_ibw(1,7)))
            hold on
%               plot(jTcentroids(1),jTcentroids(2),'*r')
                title(['Carpeta ',video_,num2str(num_)])
            hold off
        subplot(3,3,8)
            imshow(cell2mat(s_ibw(1,8)))
            hold on
%               plot(jTcentroids(1),jTcentroids(2),'*r')
                title(['Carpeta ',video_,num2str(num_)])
            hold off
        subplot(3,3,9)
            imshow(cell2mat(s_ibw(1,9)))
            hold on
%               plot(jTcentroids(1),jTcentroids(2),'*r')
                title(['Carpeta ',video_,num2str(num_)])
            hold off                
    end
    
    
    
%         

%     
%     
% %     [imm2Xpx,immXpx,iTperimeter] = area(ibw1,a_);% calcula la relación pixel mm target
% %     [jmm2Xpx,jmmXpx,jTperimeter] = area(jbw1,a_);
% %     [kmm2Xpx,kmmXpx,kTperimeter] = area(kbw1,a_);
%     
%     [iTcentroids,iTradii] = centre(ibw1);
%     [jTcentroids,jTradii] = centre(jbw1);
%     [kTcentroids,kTradii] = centre(kbw1);
%     
%     [i2Tcentroids,i2Tradii] = centre(ibw2);
%     [j2Tcentroids,j2Tradii] = centre(jbw2);
%     [k2Tcentroids,k2Tradii] = centre(kbw2);
%     
%    close
%    %%
%     figure
%     shg
%     L = 1920;
%     W = 1000;
%     a=1;
%     b=1;
%     set(gcf,'position',[a b L W])
%     %%
%     subplot(3,3,1)
%     imshow(i2)
%     hold on
%     plot(iTcentroids(1),iTcentroids(2),'*b')
%     title(['Carpeta ',video_,num2str(num_)])
%     subplot(3,3,2)
%     imshow(ibw1)
%     hold on
%     plot(iTcentroids(1),iTcentroids(2),'*b')
%     title(['Imagen ',num2str(ind_)])
%     subplot(3,3,3)
%     imshow(ibw2)
%     hold on
%     plot(i2Tcentroids(1),i2Tcentroids(2),'*b')
%     title(['Numero de objetos: ',num2str(icc.NumObjects)])
%     %%
%     subplot(3,3,4)
%     imshow(j2)
%     hold on
%     plot(jTcentroids(1),jTcentroids(2),'*r')
%     title(['Carpeta ',video_,num2str(num_)])
%     subplot(3,3,5)
%     imshow(jbw1)
%     hold on
%     plot(jTcentroids(1),jTcentroids(2),'*r')
%     title(['Imagen ',num2str(ind_+1)])
%     subplot(3,3,6)
%     imshow(jbw2)
%     hold on
%     plot(i2Tcentroids(1),i2Tcentroids(2),'*r')
%     title(['Numero de objetos: ',num2str(jcc.NumObjects)])
%     %%
%     subplot(3,3,7)
%     imshow(k2)
%     hold on
%     plot(kTcentroids(1),kTcentroids(2),'*g')
%     title(['Carpeta ',video_,num2str(num_)])
%     subplot(3,3,8)
%     imshow(kbw1)
%     hold on
%     plot(kTcentroids(1),kTcentroids(2),'*g')
%     title(['Imagen ',num2str(ind_+2)])
%     subplot(3,3,9)
%     imshow(kbw2)
%     hold on
%     plot(i2Tcentroids(1),i2Tcentroids(2),'*g')
%     title(['Numero de objetos: ',num2str(kcc.NumObjects)])
%     %%
%     
%     
%     
%     