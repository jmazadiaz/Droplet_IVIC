%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   
%   Este script es para explorar las partes de cada vídeo  en el conjunto de
%   imagenes extraidas de los videos
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
clear
% clc
%close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%         CONTROL PRINCIPAL                          %%
%%
    num_ = 2;
    video_ = 'img-g48-';
    folder_drops_ = strcat('D:\Droplets Video\glicerina\48 cm\AVI\IMG\',video_,num2str(num_)); %Recore el diretorio
    filetype_drops_ = 'jpg';% Tipo de Archivo

    archivo = leedir(folder_drops_, filetype_drops_ );
    
    clear folder_drops_ filetype_drops_
    
    
%% 
    
    d_ini_ = 223;
    part_ = 2;
    
%%    
    d_nun_cc_ = 4;%(4o8)specifies the desired connectivivty for the connected components
    nun_cc_ = 8; % Para escogel el target
    d_T_bw_ = 62;     % Maximo valor en binarización
    d_T1_bw1_ = 76;    % M.V.B en la primera imagen(punta Target)
    d_T1_bw2_ = 120;  % M.V.B en la primera imagen (Target)
    inv_ = true;    %Inverso del binarizaciónm
    d_T_O_= 10;       %Numero de pixels para objetos grandes en la imagen
    a_=6.875533829; % Área del target en mm^2
    
%%  

    d_valor_ = 120; % Valor de incremento
   % max_ = 120; % Maximo valor de pixel en la zona de estudio
   % min_ = 20; % Minimo valor de pixel en la zona de estudio
    
%%    Identifica el target del primer frame del video
%       

    d_i1_ = rgb2gray(imread(archivo{1})); % Lee pirmera imagen
%%      Maximos y minimos en la imagen
    
%%

    d_i1_bw1_ = binarizacion(d_i1_,d_T1_bw1_,inv_);%  Binariza,(inversion true) 1 todas por encia de T1-bw_ = 115 y cero por debajo 
    d_i1_bw2_ = binarizacion(d_i1_,d_T1_bw2_,inv_);% Binariza, 
    d_cc1_ = bwconncomp(d_i1_bw1_, nun_cc_);%   Busca el objeto cerrado (target)
    d_d_cc2_ = bwconncomp(d_i1_bw2_, nun_cc_);
    d_p_target_ = d_cc1_.PixelIdxList{1};   % Lista de pixel de la punta del target  para no tomarlos en cuenta luego.
    d_target_ = d_d_cc2_.PixelIdxList{1};     %Lista de pixel del target  para no tomarlos en cuenta luego.
    d_i1bw_ptarget_ = object(d_i1_bw2_ ,d_p_target_);
    d_i1bw_target_ = object(d_i1_bw2_ ,d_target_);
    
    clear d_cc1_ d_cc2_ d_p_target_ d_target_
%%      DILATACION DE LA IMAGEN DEL TARGET Y LA PUNTA 1PX
    d_se_ = strel('disk',2);
    d_i1pt_dilate_ = imdilate(d_i1bw_ptarget_,d_se_);
    d_i1t_dilate_ = imdilate(d_i1bw_target_,d_se_);
    d_cc1_ = bwconncomp(d_i1pt_dilate_, nun_cc_);%   Busca el objeto cerrado (target)
    d_d_cc2_ = bwconncomp(d_i1t_dilate_, nun_cc_);
    d_p_target_ = d_cc1_.PixelIdxList{1};   % Lista de pixel de la punta del target  para no tomarlos en cuenta luego.
    d_target_ = d_d_cc2_.PixelIdxList{1};     %Lista de pixel del target  para no tomarlos en cuenta luego.
%%
    %%
    
    d_i_ =imread(archivo{d_ini_});   %COPIA EL MAPA DE BITS EN i  % Arriba  ind_
    i2_=rgb2gray(d_i_);            %TRANSFORMA A i DE RGB A ESCALAS DE GRISES 
   
    moda_ = mode(i2_(d_p_target_),2);
    max_ = max(max(i2_(d_target_)));
    min_ = min(min(i2_(d_target_)));
    med_ = mode(moda_); % no se para que me pueda servir el valor mas probable
    
    Target_ = struct('target',d_target_,'p_target',d_p_target_,'valor',d_valor_,'max',max_,'min',min_,'moda',med_);
    
    figi2_ = objectplus(i2_ ,Target_);% Esta función aumenta todos los valores de la lista de pixel valor_=180
%%  
%        PDtest
    
th_ = imhist(figi2_(d_target_));
h_ = imhist(figi2_);

h_indi_ = sumhasta(h_,2100);
hbw_ = h_indi_ -5;

ti_=1;
for d_i_ = 1:length(d_target_)
    if figi2_(d_target_(d_i_))<=h_indi_;
        ch_ind_(ti_) = d_target_(d_i_);
        ti_ = ti_ +1;
    end
end
% ch_ind_ = find(figi2_(target_) <= h_indi_);
 
figi2_(ch_ind_) = h_indi_ + 80;
%%    
    ibw_=binarizacion(figi2_,hbw_,inv_);    %BINARIZA i2 INVIRTIENDO LOS COLORES  %Ariba T_bw_ inv_
  
%%    
%      PDtest1
e_ = strel('disk',1);
i2_dilate_ = imdilate(ibw_,se_);

 moda_ = mode(i2_(d_p_target_),2);
    max_ = max(max(i2_(d_target_)));
    min_ = min(min(i2_(d_target_)));
    med_ = mode(moda_);
 
subplot(2,2,1)
imshow(i2_)
subplot(2,2,2)
imshow(i2_open_)
subplot(2,2,3)
imshow(i2_close_)
subplot(2,2,4)
imshow(i2_dilate_)
%% 
    
    imshow(ibw_);
    
    icc=bwconncomp(ibw_, d_nun_cc_);       %ANALISIS TOPOLOGICO DE LA IMAGEN BLANCO Y NEGRO
   
    [is2max, is2maxpos]=objectMaxSize(icc,d_T_O_);  %ORDENA DE MAYOR A MENOS TAMAÑO LOS OBJETOS     % Arriba T_O_
   
    for d_i_ = 1:length(is2maxpos)    %COPIA TODO LOS OBJETOS ENCONTRADOS POR SEPARADO  
        s_ibw(1,d_i_) = {object(ibw_,icc.PixelIdxList{is2maxpos(d_i_)})};
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
shg
    L = 1200;
    W = 1200;
    a=10;
    b=10;
    set(gcf,'position',[a b L W])

    imshow(figi2_)

    figure                
   
    shg
    L = 1060;
    W = 1000;
    a=850;
    b=10;
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
    
    