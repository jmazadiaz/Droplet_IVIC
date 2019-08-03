%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%   Este escript mide el �rea de cada mancha de tinta luego de la
%   gramentaci�n para medir la distribucion de tama�os en cada lanzamiento
%   y corroborarlo con la conclusion de Strom
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% close all

%%
caso = 'AG58';
file = strcat('partes/New_Folder/partes_',caso,'.mat');

load(file)

t_ejex_ = ' Cantidad de fragmento ';
t_ejeY_ = ' Lanzamiento';
t_ejez_ = ' �rea de fragmento';

Title_ = ' Escala de tama�o de los fragmentos  en cada evento';

size_ = [1 50 1920 960 ];


%%                      Parte A
    
   
    
   

for indice_ = 3:length(Partes)
    
   
    for objeto_ = 1: length(Partes{1,4}.Objetos); 
       
        ob_ = regionprops(Partes{indice_,4}.Objetos{1,objeto_},'area');
        ob_area(indice_,objeto_) = ob_.Area;
        
    end
    
    
end



% figure                
%         shg
%         set(gcf,'position',size_)
%         
%         bar3(ob_area)
%         xlabel(t_ejex_); ylabel(t_ejeY_);  zlabel(strcat(t_ejez_,px_))
%             title(strcat(Title_, ' para : ', caso));


clear caso  end_ indice_ size_ t_ejex_ t_ejeY_ t_ejez_ visualice_ Title_
