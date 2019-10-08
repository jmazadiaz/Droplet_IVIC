close all 


for fluid = 1:4
 figure1=...  
 figure('Name',strcat('FtD-Size:  Altura: '...                      % Titulo de ventana
                ,num2str(frag_size_{fluid,2})),'NumberTitle','off');
 axes1 = axes('Parent',figure1);


for sh_caso_ = fluid:4:length(frag_size_);
        
         x_valor_ = -20 : max(frag_size_{sh_caso_, 3}.Area_Fragmentos(:)+50);
         y_valor_ = pdf(frag_size_{sh_caso_, 4},x_valor_);
       
         plot(axes1,x_valor_,y_valor_,'LineWidth',1);
           hold on
         legend_{(sh_caso_-fluid)/4+1} = strcat(frag_size_{sh_caso_}(1:3)...
                                             ,':We = ', num2str(rweber (P_fluidos,frag_size_{sh_caso_}))...
                                             ,'|',frag_size_{sh_caso_,4}.ParameterDescription{1}(1:2),'= ', ...
                                             num2str(frag_size_{sh_caso_,4}.a),'|-|',...
                                             frag_size_{sh_caso_,4}.ParameterDescription{2}(1:2),'= ', ...
                                             num2str(frag_size_{sh_caso_,4}.b),'|');
    
end
 title(strcat('FitDist de tamaños: '...                                   % Titulo de Grafica
                ,num2str(frag_size_{fluid,2})))
 xlabel('tamaño de fragmento'); 
 ylabel('Densidad de Probabilidad estimada ci/(N.wi)');

 ylim(axes1,[0 0.12]);                  % Limita el eje y
 xlim(axes1,[-2 105]);                  %Limita el eje x
 l1 = legend(legend_{1},legend_{2},legend_{3},'location','best');
 title(l1,'Universalidad vs We')

            
end
 

for altu_ = 1:3
 figure2=...  
 figure('Name',strcat('FtD-Size:  Fluido: '...                      % Titulo de ventana
                ,frag_size_{sh_caso_}(1:3)),'NumberTitle','off');
 axes2 = axes('Parent',figure2);


for sh_caso_ = 1+4*(altu_-1):4*altu_
        
         x_valor_ = -20 : max(frag_size_{sh_caso_, 3}.Area_Fragmentos(:)+50);
         y_valor_ = pdf(frag_size_{sh_caso_, 4},x_valor_);
       
         plot(axes2,x_valor_,y_valor_,'LineWidth',1);
           hold on
         legend_{sh_caso_-4*(altu_-1)} = strcat(frag_size_{sh_caso_}(4:5)...
                                             ,':We = ', num2str(rweber (P_fluidos,frag_size_{sh_caso_}))...
                                             ,'|',frag_size_{sh_caso_,4}.ParameterDescription{1}(1:2),'= ', ...
                                             num2str(frag_size_{sh_caso_,4}.a),'|-|',...
                                             frag_size_{sh_caso_,4}.ParameterDescription{2}(1:2),'= ', ...
                                             num2str(frag_size_{sh_caso_,4}.b),'|');
    
end
 title(strcat('Ajuste de la distribución de tamaños: '...                                   % Titulo de Grafica
                ,frag_size_{sh_caso_}(1:3)))
 xlabel('tamaño de fragmento'); 
 ylabel('Densidad de Probabilidad estimada ci/(N.wi)');

 ylim(axes2,[0 0.12]);                  % Limita el eje y
 xlim(axes2,[-2 105]);                  %Limita el eje x
 l1 = legend(legend_{1},legend_{2},legend_{3},legend_{4},'location','best');
 title(l1,'Universalidad vs We')

            
end


figure3 = figure('Name','FtD-Size ','NumberTitle','off')                      % Crea una ventana con la cadena de caracteres
                
 axes3 = axes('Parent',figure3);           
    
   for sh_caso_ = 1:length(frag_size_);
        
         x_valor_ = -20 : max(frag_size_{sh_caso_, 3}.Area_Fragmentos(:)+50);
         y_valor_ = pdf(frag_size_{sh_caso_, 4},x_valor_);
       
         plot(axes3,x_valor_,y_valor_,'LineWidth',1);
           hold on
         legend_{sh_caso_} = strcat(frag_size_{sh_caso_}(4:5)...
                                             ,':We = ', num2str(rweber (P_fluidos,frag_size_{sh_caso_}))...
                                             ,'|',frag_size_{sh_caso_,4}.ParameterDescription{1}(1:2),'= ', ...
                                             num2str(frag_size_{sh_caso_,4}.a),'|-|',...
                                             frag_size_{sh_caso_,4}.ParameterDescription{2}(1:2),'= ', ...
                                             num2str(frag_size_{sh_caso_,4}.b),'|');
    
end

    title(strcat('Ajuste de la distribución de tamaños: '...                                   % Titulo de Grafica
                ,frag_size_{sh_caso_}(1:3)))
 xlabel('tamaño de fragmento'); 
 ylabel('Densidad de Probabilidad estimada ci/(N.wi)');

 ylim(axes3,[0 0.12]);                  % Limita el eje y
 xlim(axes3,[-2 105]);                  %Limita el eje x
 l3 = legend(legend_{1},legend_{2},legend_{3}',legend_{4},legend_{5},legend_{6},legend_{7},legend_{8},legend_{9},legend_{10},legend_{11},legend_{12},'location','best');
 title(l3,'Universalidad vs We')
    
% 
% strcat('|',frag_size_{sh_caso_,4}.ParameterDescription{1}(1:2),'= ', ...
%                    num2str(frag_size_{sh_caso_,4}.a),'|-|',...
%                    frag_size_{sh_caso_,4}.ParameterDescription{2}(1:2),'= ', ...
%                    num2str(frag_size_{sh_caso_,4}.b),'|')