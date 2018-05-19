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
    num_ = 1;
    video_ = 'img-g48-';
    folder_drops_ = strcat('D:\Droplets Video\glicerina\48 cm\AVI\IMG\',video_,num2str(num_)); %Recore el diretorio
    filetype_drops_ = 'jpg';% Tipo de Archivo

    archivo = leedir(folder_drops_, filetype_drops_ );
    
    clear folder_drops_ filetype_drops_
    
    
%% 
    
    ind_ = 1;
    part_ = 1;
    
%%    
    nun_cc_ = 4;    %(4o8)specifies the desired connectivivty for the connected components
    T_bw_ = 70;     % Maximo valor en binarización
    inv_ = true;    %Inverso del binarizaciónm
    T_O_= 50;       %Numero de pixels para objetos grandes en la imagen
    a_=6.875533829; % Área del target en mm^2
    
%%    

    i=imread(archivo{ind_});    % Arriba  ind_
    j=imread(archivo{ind_+1});
    k=imread(archivo{ind_+2});
    
    i2=rgb2gray(i);
    j2=rgb2gray(j);
    k2=rgb2gray(k);
    
    ibw_=binarizacion(i2,T_bw_,inv_);    %Ariba T_bw_ inv_
    jbw_=binarizacion(j2,T_bw_,inv_);
    kbw_=binarizacion(k2,T_bw_,inv_);
    
    icc=bwconncomp(ibw_, nun_cc_);
    jcc=bwconncomp(jbw_, nun_cc_);
    kcc=bwconncomp(kbw_, nun_cc_);

    [is2max, is2maxpos]=objectMaxSize(icc,T_O_);  % Arriba T_O_
    [js2max, js2maxpos]=objectMaxSize(jcc,T_O_); 
    [ks2max, ks2maxpos]=objectMaxSize(kcc,T_O_); 

    ibw1 = object(ibw_,icc.PixelIdxList{is2maxpos(part_)});
    jbw1 = object(jbw_,jcc.PixelIdxList{js2maxpos(part_)});
    kbw1 = object(kbw_,kcc.PixelIdxList{ks2maxpos(part_)});
    
    ibw2 = object(ibw_,icc.PixelIdxList{is2maxpos(part_+1)});
    jbw2 = object(jbw_,jcc.PixelIdxList{js2maxpos(part_+1)});
    kbw2 = object(kbw_,kcc.PixelIdxList{ks2maxpos(part_+1)});

%     [imm2Xpx,immXpx,iTperimeter] = area(ibw1,a_);% calcula la relación pixel mm target
%     [jmm2Xpx,jmmXpx,jTperimeter] = area(jbw1,a_);
%     [kmm2Xpx,kmmXpx,kTperimeter] = area(kbw1,a_);
    
    [iTcentroids,iTradii] = centre(ibw1);
    [jTcentroids,jTradii] = centre(jbw1);
    [kTcentroids,kTradii] = centre(kbw1);
    
    [i2Tcentroids,i2Tradii] = centre(ibw2);
    [j2Tcentroids,j2Tradii] = centre(jbw2);
    [k2Tcentroids,k2Tradii] = centre(kbw2);
    
   close
   %%
    figure
    shg
    L = 1920;
    W = 1000;
    a=1;
    b=1;
    set(gcf,'position',[a b L W])
    %%
    subplot(3,3,1)
    imshow(i2)
    hold on
    plot(iTcentroids(1),iTcentroids(2),'*b')
    title(['Carpeta ',video_,num2str(num_)])
    subplot(3,3,2)
    imshow(ibw1)
    hold on
    plot(iTcentroids(1),iTcentroids(2),'*b')
    title(['Imagen ',num2str(ind_)])
    subplot(3,3,3)
    imshow(ibw2)
    hold on
    plot(i2Tcentroids(1),i2Tcentroids(2),'*b')
    title(['Numero de objetos: ',num2str(icc.NumObjects)])
    %%
    subplot(3,3,4)
    imshow(j2)
    hold on
    plot(jTcentroids(1),jTcentroids(2),'*r')
    title(['Carpeta ',video_,num2str(num_)])
    subplot(3,3,5)
    imshow(jbw1)
    hold on
    plot(jTcentroids(1),jTcentroids(2),'*r')
    title(['Imagen ',num2str(ind_+1)])
    subplot(3,3,6)
    imshow(jbw2)
    hold on
    plot(i2Tcentroids(1),i2Tcentroids(2),'*r')
    title(['Numero de objetos: ',num2str(jcc.NumObjects)])
    %%
    subplot(3,3,7)
    imshow(k2)
    hold on
    plot(kTcentroids(1),kTcentroids(2),'*g')
    title(['Carpeta ',video_,num2str(num_)])
    subplot(3,3,8)
    imshow(kbw1)
    hold on
    plot(kTcentroids(1),kTcentroids(2),'*g')
    title(['Imagen ',num2str(ind_+2)])
    subplot(3,3,9)
    imshow(kbw2)
    hold on
    plot(i2Tcentroids(1),i2Tcentroids(2),'*g')
    title(['Numero de objetos: ',num2str(kcc.NumObjects)])
    %%
    
    
    
    