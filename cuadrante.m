%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   INDICE(1,2) (Ini, Fin parte 0)
%   INDICE(3) (Inicio parte A)
%   INDICE(4) (Fin parte A)
%   INDICE(5) (Inicio parte B)
%   INDICE(6,7) (Fin parte B, Inicio Parte C)
%   INDICE(8,9) (Fin parte C, Lamina muy rota inicio parte D)
%   INDICE(10,11) (Fin de parte D, Fin del proceso)
%   INDICE(12,13) (Inicio y final del video.)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%

clear
% clc
close all
%%      STR Variables (Nomb, Archivo y carpetas a procesar)
% sus_ = 'G68'            % Caso de estudio
% indi_ = 'indi-'
% folder_ = 'folder-'     % parte del nombre del archivo de entrada
folder_caso_ = 'D:\Dropbox\Droplets\Matlab\Droplets\';
findis_ = 'indice\'     % Carpeta de indice de las partes
finds_ = strcat(findis_,'*.mat' );
ffolders_ = 'folders\'  % Capeta de las carpetas de fotogramas de los videos
ffolds_ = strcat(ffolders_,'*.mat' );


%%
l_fold_ =   dir(ffolds_);   % Todos las carpetas de fotogramas
l_inds_ =   dir(finds_);    % todas las lista de indices

% f_caso_ = strcat('folders\',folder_,sus_,'-.mat');   % ESTAN SUSTITUIDAS
% caso_ = strcat('indice\',indi_,sus_,'-.mat');        % PARA TODOS LOS CAOS

%%       Verificando la coincidencia de casos entre folders\ e indice\ PUEDE PONERCE A PARTE
    if length(l_inds_) ~= length(l_fold_)
        display('##  El numero de casos de folders\ es diferente al número de casos en indice\  ##')
        break
    end

    for i_ = 1: length(l_inds_)
        if   l_fold_(i_).name(8:10) ~= l_inds_(i_).name(6:8)
            display('## Los casos en Folders no coinciden con los casos en indice  ##')
            break
        end
    end
    clear i_
%%

%% CADA CASO 

for caso_ = 1:length(l_inds_)  

    % load(caso_);%       indices_(1) Los indices
    % load(f_caso_);%   folders_{1} es D:\Droplets Video\glicerina\48 cm\AVI\IMG\img-g48-1
    
    indices_caso_ = strcat(folder_caso_,'indice\',l_inds_(caso_).name);
    carpeta_caso_ = strcat(folder_caso_,'folders\',l_fold_(caso_).name);
    
    load(indices_caso_);%       indices_(1) Los indices 
    load(carpeta_caso_);%   folders_{1} es D:\Droplets Video\glicerina\48 cm\AVI\IMG\img-g48-1

    %%                            CONTROL PRINCIPAL                          %%
    %%
    
    file = strcat('partes\','partes_',l_inds_(caso_).name(6:8));  % Nombre del archivo de salida
    %folder_drops_ = 'D:\Droplets Video\glicerina\48 cm\AVI\IMG\img-g48-1'; %Recore el diretorio
    filetype_drops_ = 'jpg';% Tipo de Archivo

    %%

    % video_ = 'img-g48-';          % % PARA BORRAR
    % folder_drops_ = strcat('D:\Droplets Video\glicerina\48cm\AVI\IMG\',video_,num2str(num_)); %Recore el diretorio % PARA BORRAR
    % centro_ = [129.2508 , 107.5139];% Centro 1er Ejemplo, Cambiar a referent point  % PARA BORRAR

    nun_cc_ = 8;    %(4o8)specifies the desired connectivivty for the connected components
    T_bw_ = 70;     % Maximo valor en binarización
    inv_ = true;    % inverso del binarizaciónm
    T_O_= 50;       %Numero de pixels para objetos grandes en la imagen
    a_=6.875533829; % Área del target en mm^2




    %%          CONTROL DE PARTE A DEL FENÓMENO
    %%
    %  a_ini_ = 38;    a_end_ = 88;
    %  a_ini_ = indices_(vi_,3);    a_end_ = indices_(vi_,4);
     a_T_O_ = 40;    %Numero de pixels para objetos grandes en la imagen

    %%          CONTROL DE PARTE B DEL FENÓMENO
    %% 
    %  b_ini_ = 103;    b_end_ = 155;
    %  b_ini_ = indices_(vi_,5);  b_end_ = indices_(vi_,6);
     b_T_O_ = 70;

    %%          CONTROL DE PARTE C DEL FENÓMENO
    %% 
    % c_ini_ = 169;    c_end_ = 191;
    % c_ini_ = indices_(vi_,7);  c_end_ = indices_(vi_,8);
    c_T_O_ = 70;
    c_T_vent_ =  15; % Tamaño de la ventana del cuadrante (arco) en 'cetre.m'
    c_octantes_ = [1 2 3 4 5 6 7 8];% Parte del arco que quiere visualizar 

    %%          CONTROL DE PARTE D DEL FENÓMENO
    %% 
    % c_ini_ = 169;    c_end_ = 191;
    % d_ini_ = indices_(vi_,10); d_iframe_ = indices_(vi_,1);  
    d_nun_cc_ = 4;%(4o8)specifies the desired connectivivty for the connected components
    d_T_bw_ = 62;     % Maximo valor en binarización
    d_T1_bw1_ = 76;    % M.V.B en la primera imagen(punta Target)
    d_T1_bw2_ = 120;  % M.V.B en la primera imagen (Target)
    d_T_O_= 0;       %Numero de pixels para objetos grandes en la imagen
    d_valor_ = 120; % Valor de incremento


    %%          HAY QUE SUSTITUIR EN EL FOR
      for vi_ = 1:length(folders_)  % Desde el primero hasta el ultimo video.
        %%


        num_ = 27;       % CARPETA A ANALIZAR DE {  [  ( folders_{num_}  )  ]  }
    %    	vi_ = num_;     % INDICES DE LA CARPETA A ANALIZAR  indices_(vi_,#)
        ind_ = 1;       % INDICE DEL PRIMER FRAME (identificar target)
        %                      CARPETAS Y LEE ARCHIVOS DE LA CARPETA

        fprintf('Van: %d video(s). de: %d  \n', vi_,length(folders_))

        %           PARTES  USANDO indicies_() 
        a_ini_ = indices_(vi_,3);    a_end_ = indices_(vi_,4);
        b_ini_ = indices_(vi_,5);  b_end_ = indices_(vi_,6);
        c_ini_ = indices_(vi_,7);  c_end_ = indices_(vi_,8);
        d_ini_ = indices_(vi_,10); d_iframe_ = indices_(vi_,1);  

        folder_drops_ = folders_{vi_};
        archivo_ = leedir(folder_drops_, filetype_drops_ );

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%             CENTRO DE LA PRIMERA IMAGEN   (target)                  %%                                                                    %%
        %%

        archivo_ = leedir(folder_drops_, filetype_drops_ );
            clear folder_drops_ 

        i=imread(archivo_{ind_});    % Arriba  ind_
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
            d_i1_ = rgb2gray(imread(archivo_{d_iframe_})); % Lee pirmera imagen
        %      Maximos y minimos en la imagen   
            d_i1_bw1_ = binarizacion(d_i1_,d_T1_bw1_,inv_);%  Binariza,(inversion true) 1 todas por encia de T1-bw_ = 120 y cero por debajo 
            d_i1_bw2_ = binarizacion(d_i1_,d_T1_bw2_,inv_);% Binariza, 
            d_cc1_ = bwconncomp(d_i1_bw1_, nun_cc_);%   Busca el objeto cerrado (target)
            d_d_cc2_ = bwconncomp(d_i1_bw2_, nun_cc_);
            [d_is1max, d_is1maxpos]=objectMaxSize(d_cc1_,d_T_O_);
            [d_is2max, d_is2maxpos]=objectMaxSize(d_d_cc2_,d_T_O_);
            d_p_target_ = d_cc1_.PixelIdxList{d_is1maxpos(1)};   % Lista de pixel de la punta del target  para no tomarlos en cuenta luego.
            d_target_ = d_d_cc2_.PixelIdxList{d_is2maxpos(1)};     %Lista de pixel del target  para no tomarlos en cuenta luego.
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
        
%          imshow([d_i1bw_ptarget_,d_i1bw_target_]) 
%          title(strcat('caso : ',l_inds_(caso_).name(6:8),'-  video :',num2str(vi_)))
       
%         pause
        %%          PARTE A

%      	  parteA

    %   SAVED DATA

%             Partes(vi_,1)={table2struct(a_tab_)};


        %%          PARTE B   

%            parteB

        %   SAVED DATA

%             Partes(vi_,2)={table2struct(b_tab_)};

        %   SHOW DATA

    %         showB    

        %%          PARTE C

           parteC

        %   SAVED DATA

%            Partes(vi_,3)={table2struct(c_tab_)};

        %   SHOW SEXTION

    %         showC

        %%          PARTE D

%             parteD

        %   SAVED DATA

%            Partes(vi_,4)={table2struct(d_tab)};

        %   SHOW SECTION

    %         showD


    %%

      end 	% Fin del for desde el primero hasta el último de los videos.

      save(file,'Partes');
%       pause

%%                  CLEAR PART
% 
%         zclear_a  % Borras las variables de parte A.
%         zclear_b  % Borras las variables de parte B.
%         zclear_c  % Borras las variables de parte C.
%         zclear_d  % Borras las variables de parte D.
%         
%%
end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %                       F   I   N
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%