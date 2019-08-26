%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                      PARTE D DEL FENOMENO                            %%
%%            MIDE EL N�MERO DE FRAGMENTOS (Correcci�n proyectiva) 169 - 191

d_i_ =imread(archivo_{d_ini_});                                                 % COPIA EL MAPA DE BITS EN i  % Arriba  ind_
d_i2_=rgb2gray(d_i_);                                                           % TRANSFORMA A i DE RGB A ESCALAS DE GRISES 

d_moda_ = mode(d_i2_(d_p_target_),2);
d_max_ = max(max(d_i2_(d_target_)));
d_min_ = min(min(d_i2_(d_target_)));
d_med_ = mode(d_moda_);                                                         % No se para que me pueda servir el valor mas probable

%%  		REALSA EL TARGET PARA QUE NO PUEDA SER BINARIZADO

d_Target_ = struct('target',d_target_,'p_target',d_p_target_,'valor',...
                    d_valor_,'max',d_max_,'min',d_min_,'moda',d_med_);          %	TODOS LOS ELEMENTOS NECESARIOS

d_figi2_ = objectplus(d_i2_ ,d_Target_);                                        % Esta funci�n aumenta todos los valores de la lista de pixel valor_=180

[d_figi2_ d_hbw_] = borratarget(d_figi2_ ,d_target_, 60);                       % Descarta el target y sus sombras de la binarizaci�n.

d_ibw_=binarizacion(d_figi2_,d_hbw_,inv_);                                      % BINARIZA i2 INVIRTIENDO LOS COLORES  %Ariba T_bw_ inv_

%      imshow(d_ibw_);    %	MOSTRAR RESULTADO

d_icc=bwconncomp(d_ibw_, d_nun_cc_);                                            % ANALISIS TOPOLOGICO DE LA IMAGEN BLANCO Y NEGRO (DETECTA MANCHAS)

[is2max, is2maxpos]=objectMaxSize(d_icc,d_T_O_);                                % ORDENA DE MAYOR A MENOS TAMA�O LOS OBJETOS  % Arriba T_O_
d_icc.Centro = Tcentroids;

for d_i_ = 1:length(is2maxpos)                                                  % COPIA TODO LOS OBJETOS ENCONTRADOS POR SEPARADO  
    d_s_ibw(vi_,d_i_) = {object(d_ibw_,d_icc.PixelIdxList{is2maxpos(d_i_)})};
end

clear d_i_
%%          SAVE DATA       s_ibw2= Todos los objetos   d_icc = Datos del Analisis, # objetos y sus lista de px

            Num_Objetos(1)={length(is2maxpos)};
            
         for d_i_ = 1:length(is2maxpos)
            Objetos(d_i_)={d_s_ibw{d_i_}};
         end
%          ListaPx = d_icc.PixelIdxList;

% d_end_i_ = d_end_ - d_ini_-3;
% 
%  d_table_(1:d_end_i_,1:5) = 0;  % Crea tabla de datos (# elementos, # columnas)
             d_tab = table(Num_Objetos,Objetos);
             clear Num_Objetos Objetos ListaPx
%  d_table_(1,1) = 1/5401* d_ini_;
%  d_in_=1;
%  
%  d_archivo_=archivo(d_ini_:d_end_);
% 



