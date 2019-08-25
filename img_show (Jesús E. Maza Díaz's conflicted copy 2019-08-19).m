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

f_ = 1;
archivo_ ='g68-.mat';
f_arch_ = strcat('mat/',archivo_);
filetype_drops_ = 'jpg';
%%
load(f_arch_)   % Celdas folders_{i_} == D:\Droplets Video\glicerina\48 cm\AVI\IMG\img-g48-1
load(archivo_)  % Celdas indices_{i_} == 1)INI_0, 2)END_0, 3)INI_A, 4)END_A, 5)INI_B, 6)END_B, 
                %                        7)INI_C, 8)END_C, 9)INI_D, 10)END_D, 11)END_, 12)1er_FRAME, 13)N_FRAME
%%

indices_(indices_(1:end,:)<= 2) = 4;

%%
                
archivo_ = leedir(folders_{f_}, filetype_drops_ );

%%
a = 10;     b = 50;     L = 1900;        W = 940;
set(gcf,'position',[a b L W])

clear f_ archivo_ f_arch_  a b L W
%%
 for i_ = 3:length(folders_);

% i_ = 27;
archivo_ = leedir(folders_{i_}, filetype_drops_ );
%   Imagenes 
ini_a_  = imread(archivo_{indices_(i_,3)});            end_a_  = imread(archivo_{indices_(i_,4)}); 
ini_b_  = imread(archivo_{indices_(i_,5)});            end_b_  = imread(archivo_{indices_(i_,6)});
ini_1c_ = imread(archivo_{indices_(i_,7)-1});          ini_c_  = imread(archivo_{indices_(i_,7)});
ini_c1_ = imread(archivo_{indices_(i_,7)+1});          end_c_  = imread(archivo_{indices_(i_,8)});
ini_1d_ = imread(archivo_{indices_(i_,9)-1});          ini_d_  = imread(archivo_{indices_(i_,9)});    
ini_d1_ = imread(archivo_{indices_(i_,9)+1});          end_d_  = imread(archivo_{indices_(i_,10)});

%   Show Imagenes
subplot(3,2,1)
imshow([ini_a_,end_a_])
title(strcat('Capeta:  ',num2str(i_),'   Ini parte A , End parte A' ))
subplot(3,2,2)
imshow([ini_b_,end_b_])
title('Ini parte B , End parte B' )
subplot(3,2,3)
imshow([ini_1c_,ini_c_])
title('Ini parte C -1 , Ini parte C' )
subplot(3,2,4)
imshow([ini_c1_,end_c_])
title('Ini parte C+1 , End parte C' )
subplot(3,2,5)
imshow([ini_1d_,ini_d_])
title('Ini parte D -1 , Ini parte D' )
subplot(3,2,6)
imshow([ini_d1_,end_d_])
title('Ini parte D + 1 , End parte D' )

pause
 end