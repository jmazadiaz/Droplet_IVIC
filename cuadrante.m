
%%
clear
% clc
close all
load('g48-.mat')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%         CONTROL PRINCIPAL                          %%
%%

folder_drops_ = 'D:\Droplets Video\glicerina\48 cm\AVI\IMG\img-g48-1'; %Recore el diretorio
filetype_drops_ = 'jpg';% Tipo de Archivo

vi_ = 1;

ind_ = 1;
centro_ = [129.2508 , 107.5139];% Centro 1er Ejemplo, Cambiar a referent point
nun_cc_ = 8;%(4o8)specifies the desired connectivivty for the connected components
T_bw_ = 70;% Maximo valor en binarización
inv_ = true;% inverso del binarizaciónm
T_O_= 50; %Numero de pixels para objetos grandes en la imagen
a_=6.875533829;% Área del target en mm^2

%%          CONTROL DE PARTE A DEL FENÓMENO
%%
%  a_ini_ = 38;    a_end_ = 88;
 a_ini_ = indices_(vi_,3);    a_end_ = indices_(vi_,4);
 a_T_O_ = 40;    %Numero de pixels para objetos grandes en la imagen

%%          CONTROL DE PARTE B DEL FENÓMENO
%% 
%  b_ini_ = 103;    b_end_ = 155;
 b_ini_ = indices_(vi_,5);  b_end_ = indices_(vi_,6);
 b_T_O_ = 70;
 
%%          CONTROL DE PARTE C DEL FENÓMENO
%% 
% c_ini_ = 169;    c_end_ = 191;
b_ini_ = indices_(vi_,7);  b_end_ = indices_(vi_,8);
c_T_O_ = 70;
c_T_vent_ =  15; % Tamaño de la ventana del cuadrante (arco) en 'cetre.m'
c_octantes_ = [1 2 3 4 5 6 7 8];% Parte del arco que quiere visualizar 

%%          CONTROL DE PARTE D DEL FENÓMENO
%% 
% c_ini_ = 169;    c_end_ = 191;
d_ini_ = indices_(vi_,10); d_iframe_ = indices_(vi_,1);  
d_nun_cc_ = 4;%(4o8)specifies the desired connectivivty for the connected components
d_T_bw_ = 62;     % Maximo valor en binarización
d_T1_bw1_ = 76;    % M.V.B en la primera imagen(punta Target)
d_T1_bw2_ = 120;  % M.V.B en la primera imagen (Target)
d_T_O_= 10;       %Numero de pixels para objetos grandes en la imagen
d_valor_ = 120; % Valor de incremento

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%             CENTRO DE LA PRIMERA IMAGEN   (target)                  %%                                                                    %%
%%

archivo = leedir(folder_drops_, filetype_drops_ );
    clear folder_drops_ filetype_drops_

i=imread(archivo{ind_});    % Arriba  ind_
i2=rgb2gray(i);
bw_=binarizacion(i2,T_bw_,inv_);    %Ariiba T_bw_ inv_

cc=bwconncomp(bw_, nun_cc_);

%   Los elementos más grandes segun su lista de pixel > Y               %

[s2max, s2maxpos]=objectMaxSize(cc,T_O_);  % Arriba T_O_

bw1 = object(bw_,cc.PixelIdxList{s2maxpos(1)});

[mm2Xpx,mmXpx,Tperimeter] = area(bw1,a_);% calcula la relación pixel mm target

[Tcentroids,Tradii] = centre(bw1);
    
    clear i ind_ i2 i bw_ cc s2max s2maxpos  bw1 .
    
%%              TARGET PARA PARTE D    
%        primer frame del video
    d_i1_ = rgb2gray(imread(archivo{d_iframe_})); % Lee pirmera imagen
%      Maximos y minimos en la imagen   
    d_i1_bw1_ = binarizacion(d_i1_,d_T1_bw1_,inv_);%  Binariza,(inversion true) 1 todas por encia de T1-bw_ = 120 y cero por debajo 
    d_i1_bw2_ = binarizacion(d_i1_,d_T1_bw2_,inv_);% Binariza, 
    d_cc1_ = bwconncomp(d_i1_bw1_, nun_cc_);%   Busca el objeto cerrado (target)
    d_d_cc2_ = bwconncomp(d_i1_bw2_, nun_cc_);
    d_p_target_ = d_cc1_.PixelIdxList{1};   % Lista de pixel de la punta del target  para no tomarlos en cuenta luego.
    d_target_ = d_d_cc2_.PixelIdxList{1};     %Lista de pixel del target  para no tomarlos en cuenta luego.
    d_i1bw_ptarget_ = object(d_i1_bw2_ ,d_p_target_); %Copia en blanco y negro el objeto
    d_i1bw_target_ = object(d_i1_bw2_ ,d_target_);
    
    clear d_cc1_ d_cc2_ d_p_target_ d_target_

%      DILATACION DE LA IMAGEN DEL TARGET Y LA PUNTA 1PX

    d_se_ = strel('disk',2);    % Objeto estructurado Disco de radio 2
    d_i1pt_dilate_ = imdilate(d_i1bw_ptarget_,d_se_);
    d_i1t_dilate_ = imdilate(d_i1bw_target_,d_se_);
    d_cc1_ = bwconncomp(d_i1pt_dilate_, nun_cc_);%   Busca el objeto cerrado (target)
    d_d_cc2_ = bwconncomp(d_i1t_dilate_, nun_cc_);
    d_p_target_ = d_cc1_.PixelIdxList{1};   % Lista de pixel de la punta del target  para no tomarlos en cuenta luego.
    d_target_ = d_d_cc2_.PixelIdxList{1};     %Lista de pixel del target  para no tomarlos en cuenta luego.

%%

%   parteA

%%

%   parteB

%%

%   parteC

%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                      PARTE D DEL FENOMENO                            %%
%%            MIDE EL NÚMERO DE FRAGMENTOS (Corrección proyectiva) 169 - 191
      
    d_i_ =imread(archivo{d_ini_});   %COPIA EL MAPA DE BITS EN i  % Arriba  ind_
    d_i2_=rgb2gray(d_i_);            %TRANSFORMA A i DE RGB A ESCALAS DE GRISES 
   
    d_moda_ = mode(d_i2_(d_p_target_),2);
    d_max_ = max(max(d_i2_(d_target_)));
    d_min_ = min(min(d_i2_(d_target_)));
    d_med_ = mode(d_moda_); % no se para que me pueda servir el valor mas probable
    
    d_Target_ = struct('target',d_target_,'p_target',d_p_target_,'valor',d_valor_,'max',d_max_,'min',d_min_,'moda',d_med_);
    
    d_figi2_ = objectplus(d_i2_ ,d_Target_);% Esta función aumenta todos los valores de la lista de pixel valor_=180
%%      DESCARTA EL TARGET Y LA PUNTA DEL MISMO PARA RESALTAR LAS MACHAS
%        PDtest 
%       IN d_figi2_ d_target_  Incremento = 10 OUT  d_figi2_ d_hbw_

% d_th_ = imhist(d_figi2_(d_target_));
% % d_h_ = imhist(d_figi2_);
% d_pvalor_ = mode(d_figi2_(d_target_))
% 
% d_h_indi_ = sumhasta(d_th_,5);    % Retorna el valor maximo del 5% acumulado de los pexel.
% d_hbw_ = d_h_indi_ -2;
% 
% d_ti_=1;
% for d_i_ = 1:length(d_target_)
%     if d_figi2_(d_target_(d_i_))<=d_h_indi_
%         d_ch_ind_(d_ti_) = d_target_(d_i_);
%         d_ti_ = d_ti_ +1;
%     end
% end
% % ch_ind_ = find(figi2_(target_) <= h_indi_);
%  
% d_figi2_(d_ch_ind_) = d_pvalor_ + 10;
%     d_figi_ = d_figi2_;
    
    [d_figi2_ d_hbw_] = borratarget(d_figi2_ ,d_target_, 10);  % Descarta el target y sus sombras de la binarización.
    
%  imshow([d_figi_,d_figi2_])
%%    
    d_ibw_=binarizacion(d_figi2_,d_hbw_,inv_);    %BINARIZA i2 INVIRTIENDO LOS COLORES  %Ariba T_bw_ inv_
  
%%    DESCARTADA
%      PDtest1
% e_ = strel('disk',1);
% i2_dilate_ = imdilate(ibw_,se_);
% 
%  d_moda_ = mode(d_i2_(d_p_target_),2);
%     d_max_ = max(max(d_i2_(d_target_)));
%     d_min_ = min(min(d_i2_(d_target_)));
%     d_med_ = mode(d_moda_);
%  
% subplot(2,2,1)
% imshow(d_i2_)
% subplot(2,2,2)
% imshow(i2_open_)
% subplot(2,2,3)
% imshow(i2_close_)
% subplot(2,2,4)
% imshow(i2_dilate_)
%% 
    
    imshow(d_ibw_);
    
    d_icc=bwconncomp(d_ibw_, d_nun_cc_);       %ANALISIS TOPOLOGICO DE LA IMAGEN BLANCO Y NEGRO
   
    [is2max, is2maxpos]=objectMaxSize(d_icc,d_T_O_);  %ORDENA DE MAYOR A MENOS TAMAÑO LOS OBJETOS     % Arriba T_O_
    d_icc.Centro = Tcentroids;
    
     
    for d_i_ = 1:length(is2maxpos)    %COPIA TODO LOS OBJETOS ENCONTRADOS POR SEPARADO  
        s_ibw(1,d_i_) = {object(d_ibw_,d_icc.PixelIdxList{is2maxpos(d_i_)})};
%%         NO TIENE SENTIDO SI YA QUITÉ TODOS LOS PX QUE SON MAS PEQUEÑOS A 10 PX
%
%         if length(is2maxpos)< 4                  
%         
%             for j_=length(is2maxpos)+1:4
%             s_ibw(1,j_) = {ones(256,256)};
%             end
%             clear j_
%         elseif length(is2maxpos)< 6
%             for j_=length(is2maxpos)+1:6
%             s_ibw(1,j_) = {ones(256,256)};
%             end
%             clear j_
%         elseif length(is2maxpos)< 9
%             for j_=length(is2maxpos)+1:9
%             s_ibw(1,j_) = {ones(256,256)};
%             end
%             clear j_
%         end 
%%
    end
    clear i_

    
    
% d_end_i_ = d_end_ - d_ini_-3;
% 
 d_table_(1:d_end_i_,1:5) = 0;  % Crea tabla de datos (# elementos, # columnas)
 d_table_(1,1) = 1/5400* d_ini_;
 d_in_=1;
 
%  d_archivo_=archivo(d_ini_:d_end_);
% 


    
    
%%          SHOW SECTION
    % figure 
    % shg
    %     L = 1200;
    %     W = 1200;
    %     a=10;
    %     b=10;
    %     set(gcf,'position',[a b L W])
    % 
    %     imshow(d_figi2_)
    % 
    %     figure                
    %    
    %     shg
    %     L = 1060;
    %     W = 1000;
    %     a=850;
    %     b=10;
    %     set(gcf,'position',[a b L W])
    %    
    %     
    %     
    %     if length(is2maxpos) <= 4
    %         
    %         subplot(2,2,1)
    %             imshow(cell2mat(s_ibw(1,1+part_)))
    %             hold on
    %              title(['Numero de objetos: ',num2str(icc.NumObjects)])
    % %               plot(iTcentroids(1),iTcentroids(2),'*b')
    %                 title([num2str(icc.NumObjects),'objetos - ','fragmento ',num2str(1+part_)])
    %             hold off
    %         subplot(2,2,2)
    %             imshow(cell2mat(s_ibw(1,2+part_)))
    %             hold on
    % %               plot(iTcentroids(1),iTcentroids(2),'*b')
    %                 title(['fragmento ',num2str(2+part_)])
    %             hold off
    %         subplot(2,2,3)
    %             imshow(cell2mat(s_ibw(1,3+part_)))
    %             hold on
    % %                plot(i2Tcentroids(1),i2Tcentroids(2),'*b')
    %                 title(['fragmento ',num2str(3+part_)])
    %                 hold off
    %         subplot(2,2,4)
    %             imshow(cell2mat(s_ibw(1,4+part_)))
    %             hold on
    %                 title(['fragmento ',num2str(4+part_)])
    %                 title(['Carpeta ',video_,num2str(num_)])
    %             hold off
    %     end
    % %%      
    %     if length(is2maxpos) <= 6
    %         
    %         subplot(2,3,1)
    %             imshow(cell2mat(s_ibw(1,1+part_)))
    %             hold on
    % %               plot(iTcentroids(1),iTcentroids(2),'*b')
    %                 title([num2str(icc.NumObjects),'objetos - ','fragmento ',num2str(1+part_)])
    %             hold off
    %         subplot(2,3,2)
    %             imshow(cell2mat(s_ibw(1,2+part_)))
    %             hold on
    % %               plot(iTcentroids(1),iTcentroids(2),'*b')
    %                title(['fragmento ',num2str(2+part_)])
    %             hold off
    %         subplot(2,3,3)
    %             imshow(cell2mat(s_ibw(1,3+part_)))
    %             hold on
    % %                plot(i2Tcentroids(1),i2Tcentroids(2),'*b')
    %                 title(['Numero de objetos: ',num2str(icc.NumObjects)])
    %             hold off
    %         subplot(2,3,4)
    %             imshow(cell2mat(s_ibw(1,4+part_)))
    %             hold on
    % %               plot(jTcentroids(1),jTcentroids(2),'*r')
    %                 title(['fragmento ',num2str(4+part_)])
    %             hold off
    %         subplot(2,3,5)
    %             imshow(cell2mat(s_ibw(1,5+part_)))
    %             hold on
    % %               plot(jTcentroids(1),jTcentroids(2),'*r')
    %                  title(['fragmento ',num2str(5+part_)])
    %             hold off
    %         subplot(2,3,6)
    %             imshow(cell2mat(s_ibw(1,6+part_)))
    %             hold on
    % %               plot(jTcentroids(1),jTcentroids(2),'*r')
    %                 title(['fragmento ',num2str(6+part_)])      
    %             hold off    
    %     end
    % %%
    % if length(is2maxpos) >= 9
    %         
    %         subplot(3,3,1)
    %             imshow(cell2mat(s_ibw(1,1+part_)))
    %             hold on
    % %               plot(iTcentroids(1),iTcentroids(2),'*b')
    %                 title([num2str(icc.NumObjects),'objetos - ','  fragmento ',num2str(1+part_)])
    %             hold off
    %         subplot(3,3,2)
    %             imshow(cell2mat(s_ibw(1,2+part_)))
    %             hold on
    % %               plot(iTcentroids(1),iTcentroids(2),'*b')
    %                 title(['fragmento ',num2str(2+part_)])
    %             hold off
    %         subplot(3,3,3)
    %             imshow(cell2mat(s_ibw(1,3+part_)))
    %             hold on
    % %                plot(i2Tcentroids(1),i2Tcentroids(2),'*b')
    % 
    %                 title(['fragmento ',num2str(3+part_)])
    %             hold off
    %         subplot(3,3,4)
    %             imshow(cell2mat(s_ibw(1,4+part_)))
    %             hold on
    % %               plot(jTcentroids(1),jTcentroids(2),'*r')
    %                 title(['fragmento ',num2str(4+part_)])
    %             hold off
    %         subplot(3,3,5)
    %             imshow(cell2mat(s_ibw(1,5+part_)))
    %             hold on
    % %               plot(jTcentroids(1),jTcentroids(2),'*r')
    %                 title(['fragmento ',num2str(5+part_)])
    %             hold off
    %         subplot(3,3,6)
    %             imshow(cell2mat(s_ibw(1,6+part_)))
    %             hold on
    % %               plot(jTcentroids(1),jTcentroids(2),'*r')
    %                 title(['fragmento ',num2str(6+part_)])
    %             hold off
    %         subplot(3,3,7)
    %             imshow(cell2mat(s_ibw(1,7+part_)))
    %             hold on
    % %               plot(jTcentroids(1),jTcentroids(2),'*r')
    %                  title(['fragmento ',num2str(7+part_)])
    %             hold off
    %         subplot(3,3,8)
    %             imshow(cell2mat(s_ibw(1,8+part_)))
    %             hold on
    % %               plot(jTcentroids(1),jTcentroids(2),'*r')
    %                 title(['fragmento ',num2str(8+part_)])
    %             hold off
    %         subplot(3,3,9)
    %             imshow(cell2mat(s_ibw(1,9+part_)))
    %             hold on
    % %               plot(jTcentroids(1),jTcentroids(2),'*r')
    %                 title(['fragmento ',num2str(9+part_)])
    %             hold off                
    %     end
    %     

% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %                       F   I   N
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%