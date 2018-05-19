
%%
clear
% clc
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%         CONTROL PRINCIPAL                          %%
%%

folder_drops_ = 'D:\Droplets Video\glicerina\48 cm\AVI\IMG\img-g48-1'; %Recore el diretorio
filetype_drops_ = 'jpg';% Tipo de Archivo

ind_ = 1;
centro_ = [129.2508 , 107.5139];% Centro 1er Ejemplo, Cambiar a referent point
nun_cc_ = 8;%(4o8)specifies the desired connectivivty for the connected components
T_bw_ = 70;% Maximo valor en binarización
inv_ = true;% inverso del binarizaciónm
T_O_= 50; %Numero de pixels para objetos grandes en la imagen
a_=6.875533829;% Área del target en mm^2

%%          CONTROL DE PARTE A DEL FENÓMENO
%%
 a_ini_ = 38;    a_end_ = 88;
 a_T_O_ = 40;    %Numero de pixels para objetos grandes en la imagen

%%          CONTROL DE PARTE B DEL FENÓMENO
%% 
 b_ini_ = 103;    b_end_ = 155;
 b_T_O_ = 70;
 
%%          CONTROL DE PARTE C DEL FENÓMENO
%% 
c_ini_ = 169;    c_end_ = 191;
c_T_O_ = 70;
c_T_vent_ =  15; % Tamaño de la ventana del cuadrante (arco) en 'cetre.m'
c_octantes_ = [1 2 3 4 5 6 7 8];% Parte del arco que quiere visualizar 

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
    
%%

%   parteA

%%

%   parteB

%%

%   parteB

%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                      PARTE D DEL FENOMENO                            %%
%%            MIDE EL NÚMERO DE FRAGMENTOS (Corrección proyectiva) 169 - 191
      
% d_end_i_ = d_end_ - d_ini_-3;
% 
% d_table_(1:d_end_i_,1:5) = 0;  % Crea tabla de datos (# elementos, # columnas)
% d_table_(1,1) = 1/5400* d_ini_;
% d_in_=1;
% 
% d_archivo_=archivo(d_ini_:d_end_);
% 


% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %                       F   I   N
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%