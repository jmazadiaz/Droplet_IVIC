%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    histogramfragsize.m
%   Input 
%       axes_ = Variable que posiciona el grafico
%       frag_size_ = Lista del tamaño de fragmentos
%       n_beans_ = Tamaño de la barra en el histograma
%       sh_caso_ = Caracteres para identificar la grafica 
%       hold_ =  1) para el histograma y el ajuste; 2 : solo la curva. 
%   Output
%       x_valor_ = Valores X de la curva de ajuste. 
%       y_valor_ = Valores Y de la curva de ajuste.
% 
%  Apartir de los datos de tamaño de fragmentos genera los histograma y su
%  respectiva curva de ajuste.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [x_valor_ , y_valor_] = histogramfragsize(axes_,frag_size_,n_beans_, sh_caso_,hold_)

if hold_ == true

histogram(axes_,vertcat(frag_size_{sh_caso_, 3}.Area_Fragmentos(:)),...
                   'BinWidth',n_beans_,'Normalization','pdf')
         title(strcat('Dis.tamaños :',frag_size_{sh_caso_,1}, ...
                    ' - ',frag_size_{sh_caso_,4}.ParameterDescription{1},...
                    '= ', num2str(frag_size_{sh_caso_,4}.a),'---',...
                   frag_size_{sh_caso_,4}.ParameterDescription{2},'= ', ...
                   num2str(frag_size_{sh_caso_,4}.b)))
 xlabel('tamaño de fragmento');  
 ylabel('Densidad de Probabilidad estimada ci/(N.wi)');
 x_valor_ = -20 : max(frag_size_{sh_caso_, 3}.Area_Fragmentos(:)+50);
 y_valor_ = pdf(frag_size_{sh_caso_, 4},x_valor_);
    hold on
     plot(x_valor_,y_valor_,'LineWidth',2);
     
elseif hold_ == false
    
x_valor_ = 0 : max(frag_size_{sh_caso_, 3}.Area_Fragmentos(:));
y_valor_ = pdf(frag_size_{sh_caso_, 4},x_valor_);

plot(x_valor_,y_valor_,'LineWidth',2);

else
  error('(_,_,hold) hold = 1 Histograma y ajuste, hold=2 solo curva de ajuste')  
end
end         
