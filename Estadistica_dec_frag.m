
 clear ind_i_ mstd_top_ mstd_med_ mstd_bot_ m_dec_frag_ outiers dec_frag_tiers_
 
 % Desviacion
 desv_ = true

%% Calculo el promedio de la desviaci�n estandar del tama�o de los fragmentos 
 
mstd_top_ = floor(mean([std(dec_frag_(1,:)),  std(dec_frag_(2,:)),...
                  std(dec_frag_(3,:)), std(dec_frag_(4,:))]));
mstd_med_ = floor(mean([std(dec_frag_(5,:)),  std(dec_frag_(6,:)),...
                  std(dec_frag_(7,:)), std(dec_frag_(8,:))]));
mstd_bot_ = floor(mean([std(dec_frag_(9,:)),  std(dec_frag_(10,:)),...
                  std(dec_frag_(11,:)), std(dec_frag_(12,:))]));
%% Descarto los elementos que son dos veces menor a la desviaci�n estandar

for ind_i_ = 1:4

  m_dec_frag_(ind_i_) =  mean(dec_frag_(ind_i_,:));
  for ind_j_ = 1:length(dec_frag_)
   outiers1(ind_i_,ind_j_) = dec_frag_(ind_i_,ind_j_) < mstd_top_/2;
   outiers2(ind_i_,ind_j_) = dec_frag_(4+ind_i_,ind_j_) < mstd_med_/2;
   outiers3(ind_i_,ind_j_) = dec_frag_(8+ind_i_,ind_j_) < mstd_bot_/2;
  
  end
end
dec_frag_tiers1_= dec_frag_(1:4,:);   dec_frag_tiers1_(outiers1)=NaN;
dec_frag_tiers2_ = dec_frag_(5:8,:);  dec_frag_tiers2_(outiers2)=NaN;
dec_frag_tiers3_ = dec_frag_(9:12,:); dec_frag_tiers3_(outiers3)=NaN;

%%  Desviacion
if desv_ == true
ZG1=dec_frag_tiers1_(1,:);       ZG2=dec_frag_tiers1_(2,:);
ZG3=dec_frag_tiers1_(3,:);       ZG4=dec_frag_tiers1_(4,:);

ZGA1 = dec_frag_tiers2_(1,:);   ZGA2 = dec_frag_tiers2_(2,:);
ZGA3 = dec_frag_tiers2_(3,:);   ZGA4 = dec_frag_tiers2_(4,:);

ZA1 = dec_frag_tiers3_(1,:);   ZA2 = dec_frag_tiers3_(2,:);
ZA3 = dec_frag_tiers3_(3,:);   ZA4 = dec_frag_tiers3_(4,:);

%%      Normal
elseif desv_ == false
ZG1=dec_frag_(1,:);       ZG2=dec_frag_(2,:);
ZG3=dec_frag_(3,:);       ZG4=dec_frag_(4,:);

ZGA1 = dec_frag_(5,:);   ZGA2 = dec_frag_(6,:);
ZGA3 = dec_frag_(6,:);   ZGA4 = dec_frag_(8,:);

ZA1 = dec_frag_(9,:);   ZA2 = dec_frag_(10,:);
ZA3 = dec_frag_(11,:);   ZA4 = dec_frag_(12,:);
end
%%
Y = 1:length(dec_frag_);

% X1(1:length(dec_frag_))= 48;    X2(1:length(dec_frag_))= 58;
% X3(1:length(dec_frag_))= 68;    X4(1:length(dec_frag_))= 78;
X1(1:length(dec_frag_))= 0.8182;    X2(1:length(dec_frag_))= 0.9527;
X3(1:length(dec_frag_))= 1.0973;    X4(1:length(dec_frag_))= 1.2509;


%%   Gr�fico Glicerina
figure
stem3(X1,Y,ZG1,'Marker','o','MarkerFaceColor','r','MarkerEdgeColor','k')
hold on
stem3(X2,Y,ZG2,'Marker','s','MarkerFaceColor','y','MarkerEdgeColor','k')
stem3(X3,Y,ZG3,'Marker','d','MarkerFaceColor','g','MarkerEdgeColor','k')
stem3(X4,Y,ZG4,'Marker','p','MarkerFaceColor','b','MarkerEdgeColor','k')
%   Label
title({'Histograma de Distribuci�n de tama�os vs Altura de lanzamiento',...
       'Glicerina'})
legend('38 cm','48 cm','68 cm','78 cm','Location','northwest')
xlabel({'Energ�a','(x10^{-6} J)'})
ylabel({'Tama�o de Fragmentos','(Px)'})
zlabel({'Cantidad de Fragmentos por tama�o'})

%%   Gr�gico Glicerina-agua
figure
stem3(X1,Y,ZGA1,'Marker','o','MarkerFaceColor','r','MarkerEdgeColor','k')
hold on
stem3(X2,Y,ZGA2,'Marker','s','MarkerFaceColor','y','MarkerEdgeColor','k')
stem3(X3,Y,ZGA3,'Marker','d','MarkerFaceColor','g','MarkerEdgeColor','k')
stem3(X4,Y,ZGA4,'Marker','p','MarkerFaceColor','b','MarkerEdgeColor','k')
%   Label
title({'Histograma de Distribuci�n de tama�os vs Altura de lanzamiento',...
       'Glicerina - Agua'})
legend('38 cm','48 cm','68 cm','78 cm','Location','northwest')
xlabel({'Energ�a','(x10^{-6} J)'})
ylabel({'Tama�o de Fragmentos','(Px)'})
zlabel({'Cantidad de Fragmentos por tama�o'})

%%  Gr�gico Agua
figure
stem3(X1,Y,ZA1,'Marker','o','MarkerFaceColor','r','MarkerEdgeColor','k')
hold on
stem3(X2,Y,ZA2,'Marker','s','MarkerFaceColor','y','MarkerEdgeColor','k')
stem3(X3,Y,ZA3,'Marker','d','MarkerFaceColor','g','MarkerEdgeColor','k')
stem3(X4,Y,ZA4,'Marker','p','MarkerFaceColor','b','MarkerEdgeColor','k')
%   Label
title({'Histograma de Distribuci�n de tama�os vs Altura de lanzamiento','Agua'})
legend('38 cm','48 cm','68 cm','78 cm','Location','northwest')
xlabel({'Energ�a','(x10^{-6} J)'})
ylabel({'Tama�o de Fragmentos','(Px)'})
zlabel({'Cantidad de Fragmentos por tama�o'})




