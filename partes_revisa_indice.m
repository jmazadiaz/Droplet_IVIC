 close all
%
                                                             % modo prueba


% Part(:,1)=indices_(:,6)-indices_(:,5);
% Part(:,2)=indices_(:,8)-indices_(:,7);
% Part(:,3)=indices_(:,10)-indices_(:,9);
% Part(:,4)=indices_(:,11)-indices_(:,10);
% % i_ = 4
% indice_(5) = indices_(i_,5);
% indice_(6) = indices_(i_,5)+77;
% indice_(7) = indices_(i_,6)+1;
% indice_(8) = indices_(i_,7)+18;
% indice_(9) = indices_(i_,8)+2;
% indice_(10) = indices_(i_,9)+40;


%%
test_ = false;  
gota_ = 2;                                                                  % 1= si la gota pasa por un lado diferente al reflejo 
                                                                            % 2 = Si la gota pasa por el mismo lado que el reflejo
caso_ = 2;                                                                   % Video que quiere revisar
carpeta_ = 18;                                                                  % Como revisa todos los casos puede escojer cual en Test

menosi_ = 10;                                                                 % Cuanto cuadros antes (Solo test_==true) Impacto
masi_ = -11;                                                                   % Cuanto cuadros despues (Solo test_==true) Impacto

menosf_ = 11;                                                                 % Cuanto cuadros antes (Solo test_==true)
masf_ = 16; 
%%                                                                            

folfer_video_ = 'D:\Dropbox\Droplets\Matlab\Droplets\folders';              % Lista de capeta de los videos
folder_indi_  = 'D:\Dropbox\Droplets\Matlab\Droplets\indice';
filetype_mat_ = 'mat';                                                      % Tipo de archivo a buscar 
filetype_drops_ = 'jpg';                                                    % Tipo de archivo de fotogramas
f_L =1920 ;    f_W = 960;     f_X = 1;      f_Y =40;                                % (L:lengh ; w:Wide) ventana  (X:x  Y:y) de la esquina inferior

video_= leedir(folfer_video_, filetype_mat_ );                              % Lee todos los tipos de archivo mat con al informacion de los videos
indi_ = leedir(folder_indi_, filetype_mat_);                                % Lee "                                                       " indices



figure                
shg
set(gcf,'position',[f_X f_Y f_L f_W])                                               

if gota_ == 1

    for h_ = 1 : length(video_)
     
   load(video_{h_});                                                        % Abre la lista de carpeta de los fotogramas (folders_)
   load(indi_{h_});                                                         % Abre la lista de carpeta de los indices (indices_)
   
    for j_ = 1:length(folders_)                                             % Bucle de las carpetas con fotogramas
       
        archivo_ = leedir(folders_{j_}, filetype_drops_ );                  % Lee todos los tipos de archivos en la carpeta 
        
        i_n_ = length(archivo_{10})-8;
        i_n1_ = length(archivo_{10})-14;
        e_n_ = length(archivo_{10})-4;  
        
        
        subplot(2,4,1)
            imshow(imread(archivo_{indices_(j_,3)}))                        % Sombra gota arriba
            title(strcat('indice 3 -',archivo_{indices_(j_,3)}(i_n_-10:e_n_)))
        subplot(2,4,2)
            imshow(imread(archivo_{indices_(j_,4)}))                        % Sombra gota abajo
            title(strcat('indice 4 -',archivo_{indices_(j_,4)}(i_n_:e_n_)))
        subplot(2,4,3)
             imshow(imread(archivo_{indices_(j_,5)}))                       % gota arriba
             title(strcat('indice 5 -',archivo_{indices_(j_,5)}(i_n_:e_n_)))
        subplot(2,4,4)
             imshow(imread(archivo_{indices_(j_,6)}))                       % gota abajo
             title(strcat('indice 6 -',archivo_{indices_(j_,6)}(i_n_:e_n_)))
        subplot(2,4,5)
             imshow(imread(archivo_{indices_(j_,6)-2}))
             title(strcat('indice 6 ',num2str(-2),' - ',...
                   archivo_{indices_(j_,6)-2}(i_n_:e_n_)))
        subplot(2,4,6)
             imshow(imread(archivo_{indices_(j_,6)-1}))
             title(strcat('indice 6 ',num2str(-1),' - ',...
                   archivo_{indices_(j_,6)-1}(i_n_:e_n_)))
        subplot(2,4,7)
             imshow(imread(archivo_{indices_(j_,8)-2}))
             title(strcat('indice 8 ',num2str(-2),' - ',...
                   archivo_{indices_(j_,8)-2}(i_n_:e_n_)))
        subplot(2,4,8)
             imshow(imread(archivo_{indices_(j_,8)-1}))
             title(strcat('indice 8 ',num2str(-1),' - ',...
                   archivo_{indices_(j_,8)-1}(i_n_:e_n_)))
        
    end

    end

elseif gota_ == 2

    if test_ == false
        
        for h_ = 1 : length(video_)

       load(video_{h_});                                                        % Abre la lista de carpeta de los fotogramas (folders_)
       load(indi_{h_});                                                         % Abre la lista de carpeta de los indices (indices_)

        for j_ = 1:length(folders_)                                             % Bucle de las carpetas con fotogramas

            archivo_ = leedir(folders_{j_}, filetype_drops_ );                  % Lee todos los tipos de archivos en la carpeta 

            i_n_ = length(archivo_{10})-8;                                      % Indice del primer caracter
            i_n1_ = length(archivo_{10})-14;                                    % Indice del primer caracter de la primera imagen
            e_n_ = length(archivo_{10})-4;                                      % Indice del ultimo caracter

            subplot(2,4,1)
                imshow(imread(archivo_{indices_(j_,5)}))                        % Sombra gota arriba
                title(strcat('indice 5 (',archivo_{indices_(j_,5)}...
                     (i_n1_:e_n_),')Indice =',num2str(j_)))
            subplot(2,4,2)
                imshow(imread(archivo_{indices_(j_,6)}))                        % Sombra gota abajo
                title(strcat('indice 6 (',archivo_{indices_(j_,6)}...
                     (i_n_:e_n_),')'))
            subplot(2,4,3)
                 imshow(imread(archivo_{indices_(j_,8)}))                       % gota arriba
                 title(strcat('indice 8 (',archivo_{indices_(j_,8)}...
                      (i_n_:e_n_),')'))
            subplot(2,4,4)
                 imshow(imread(archivo_{indices_(j_,9)}))                       % gota abajo
                 title(strcat('indice 9 (',archivo_{indices_(j_,9)}...
                      (i_n_:e_n_),')'))
            subplot(2,4,5)
                 imshow(imread(archivo_{indices_(j_,6)-1}))
                 title(strcat('indice 6 ',num2str(-1),' (',...
                       archivo_{indices_(j_,6)-1}(i_n_:e_n_),')'))
            subplot(2,4,6)
                 imshow(imread(archivo_{indices_(j_,6)+1}))
                 title(strcat('indice 6 + ',num2str(1),' ( ',...
                       archivo_{indices_(j_,6)+1}(i_n_:e_n_),')'))
            subplot(2,4,7)
                 imshow(imread(archivo_{indices_(j_,8)-1}))
                 title(strcat('indice 8 ',num2str(-1),' ( ',...
                       archivo_{indices_(j_,8)-1}(i_n_:e_n_),')'))
            subplot(2,4,8)
                 imshow(imread(archivo_{indices_(j_,8)+1}))
                 title(strcat('indice 8 + ',num2str(1),' ( ',...
                       archivo_{indices_(j_,8)+1}(i_n_:e_n_),')'))

        end

        end
    
    elseif test_ == true
       
        
           
       h_ = caso_;                                                          % Caso De estudio
       j_ =  carpeta_;                                                      % Carpeta de fotogramas con problemas
       
           load(video_{h_});                                                % Abre la lista de carpeta de los fotogramas (folders_)
           load(indi_{h_});                                                 % Abre la lista de carpeta de los indices (indices_)

      indice_ (j_,1:13)= indices_(j_,1:end);  
      
      

            archivo_ = leedir(folders_{j_}, filetype_drops_ );              % Lee todos los tipos de archivos en la carpeta 

            i_n_ = length(archivo_{10})-7;                                  % Indice del primer caracter
            i_n1_ = length(archivo_{10})-13;                                % Indice del primer caracter de la primera imagen
            e_n_ = length(archivo_{10})-4;                                  % Indice del ultimo caracter
            e_n1_ = length(archivo_{10})-9;
            
            antesi_ = menosi_+1;        despuesi_ = masi_+1;
            
            antesf_ = menosf_+1;        despuesf_ = masf_+1;
            
            i_antes6_ = indices_(j_,6)-antesi_;
            i_despues6_ = indices_(j_,6)+despuesi_;
            i_antes8_ = indices_(j_,8)-antesf_;
            i_despues8_ = indices_(j_,8)+despuesf_;
 
            %%
            indice_(j_,6) = i_antes6_;   indice_(j_,7) = i_antes6_+1;
            indice_(j_,8) = i_antes8_;   indice_(j_,9) = i_antes8_ + 2;
            indice_(j_,12) = str2num(archivo_{indices_(j_,5)}...
                                    (i_n1_+8:e_n_));  
            indice_(j_,13) = length(archivo_);
            
            f_indi_test_ = strcat('ind_test_',...
                            archivo_{indices_(j_,5)}...
                           (i_n1_+1:e_n_-7));
            save(f_indi_test_,'indice_');
            %%           
            subplot(2,4,1)
                imshow(imread(archivo_{indices_(j_,5)}))                    % Sombra gota arriba
                title(strcat('indice 5 (',archivo_{indices_(j_,5)}...
                     (i_n1_:e_n1_),' - ',archivo_{indices_(j_,5)}...
                     (e_n1_+2:e_n_),') Indice =',num2str(j_)))
            subplot(2,4,2)
                imshow(imread(archivo_{indices_(j_,6)}))                        % Sombra gota abajo
                title(strcat('indice 6 (',archivo_{indices_(j_,6)}...
                     (i_n_:e_n_),') Indice =',num2str(indices_(j_,6))))
            subplot(2,4,3)
                 imshow(imread(archivo_{indices_(j_,8)}))                       % gota arriba
                 title(strcat('indice 8 (',archivo_{indices_(j_,8)}...
                      (i_n_:e_n_),')  Indice =',num2str(indices_(j_,8))))
            subplot(2,4,4)
                 imshow(imread(archivo_{indices_(j_,9)}))                       % gota abajo
                 title(strcat('indice 9 (',archivo_{indices_(j_,9)}...
                      (i_n_:e_n_),') Indice =',num2str(indices_(j_,9))))
            subplot(2,4,5)
                 imshow(imread(archivo_{indices_(j_,6)-antesi_}))
                 title(strcat('indice 6 ',num2str(-antesi_),' (',...
                       archivo_{indices_(j_,6)-antesi_}(i_n_:e_n_),...
                       ')Ind =',num2str(i_antes6_)))
            subplot(2,4,6)
                 imshow(imread(archivo_{indices_(j_,6)+despuesi_}))
                 title(strcat('indice 6 + ',num2str(despuesi_),' ( ',...
                       archivo_{indices_(j_,6)+despuesi_}(i_n_:e_n_),...
                       ') Ind =',num2str(i_despues6_)))
            subplot(2,4,7)
                 imshow(imread(archivo_{indices_(j_,8)-antesf_}))
                 title(strcat('indice 8 ',num2str(-antesf_),' ( ',...
                       archivo_{indices_(j_,8)-antesf_}(i_n_:e_n_),...
                       ') Ind =',num2str(i_antes8_)))
            subplot(2,4,8)
                 imshow(imread(archivo_{indices_(j_,8)+despuesf_}))
                 title(strcat('indice 8 + ',num2str(despuesf_),' ( ',...
                       archivo_{indices_(j_,8)+despuesf_}(i_n_:e_n_),')Ind =',num2str(i_despues8_)))

    clear archivo                   
 %%      
    end
end

if test_ == false
    
    clear gota_ caso_ carpeta_ menosi_ masi_ menosf_ masf_
    clear folfer_video_ folder_indi_ filetype_mat_ filetype_drops_...
          filetype_drops_  f_L f_W f_X f_Y
    clear h_ j_ i_n_ i_n1_ e_n_  
   
elseif     test_ == true
    clear gota_ caso_ carpeta_ menosi_ masi_ menosf_ masf_
    clear h_ j_ i_n_ i_n1_ e_n_  
    clear folfer_video_ folder_indi_ filetype_mat_ filetype_drops_...
          filetype_drops_  f_L f_W f_X f_Y
    clear antesf_ antesi_ despuesf_ despuesi_ i_antes6_ i_antes8_...
          i_despues6_ i_despues8_  masf_ masi_ menosf_ menosi_ 
end 

% %%   si los indices_(:,1:4) son nulos 
%   for i = 1:4
%       indices_(:,i) = i;
%   end
% %%

%% Si hay indices nulos en la matriz j == Las filas   i ==  Las columnas

% for j = 1:length(indices_)                      
%    
%     for i = 1:13
%         if indices_(j,i) == 0
%             indices_(j,i) = i;
%         end
%     end
%     
% end


