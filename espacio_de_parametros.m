%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Name        : espacio de parametros.m                                 %
%   Author      : Jesus Enrique Maza Diaz                                %
%   Versión     :   1.0                                                 %   
%   Copyright   : GNU/GPL                                                %
%   Descripción : Es un script para definir el espacio de parametro de  %     
%                 proyecto de Imacto de gotas sobre superfices s�lidas   %
%                 donde defino parametros como: tama�o de las gotas, ve- %
%                 locidades de impacto, velocidad limite, altura limite  %
%                 y; la altura y velocidad en funci�n del tiempo, usando %  
%                 el teorema de stokes, de tates y dinam�ca, para su     %
%                 calculo.                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Fluido=[(1)densidad(kg/m^3),(2)viscosidad(kg/m.s),(3)Tension superficial(N/m)]
ag=[1000, 0.00105, 72.8e-03];       %Agua
gl=[1261, 1.3923, 59.4e-03];            %Glicerina
pa=[910, 1, 29.642951e-03];   %Parafina
si=[950, 1, 30.634378e-03];   %Silicona
ai=[1.394, 1.61e-5, 1];      %Aire

% Calibre e las agujas : Rosada, Amarilla, Verde trans, Gris, Azul celeste,
% Azul, Naranja, Gris peque�o.

crosa=1.287e-03; camar=0.891e-03; cverd=0.818e-03; cgris=0.702e-03; cacel=0.644e-03; cazul=0.517e-03; cnara=0.457e-03; cgpeq=0.402e-03;
 
agujas=[crosa, camar, cverd, cgris, cacel, cazul, cnara, cgpeq];
rag=agujas;

%masa de la gota m�s grande que puede colgar de un tubo
%(mg=2*pi*a*sigma*cos(alpha)/g) m=masa , g=gravedad , a=radio del tubo ,
%sigma=tension superficial , cos(alpha)=cos(angulo de caida)

magua=tate(rag,ag);
mglice=tate(rag,gl);
mpara=tate(rag,pa);
msili=tate(rag,si);


% Volumen de la gota  usando la densidad del fluido

vagua=magua/ag(1);
vglice=mglice/gl(1);
vpara=mpara/pa(1);
vsili=msili/si(1);

% Calculo del radio de la gota asumiendo que es esferica

% Radio en  mm Se multipilica por 1000  para que quede en mm 


rag=radio_sph(vagua);
rgl=radio_sph(vglice);
rpa=radio_sph(vpara);
rsi=radio_sph(vsili);

rag_mm=radio_sph(vagua)*1000;
rgl_mm=radio_sph(vglice)*1000;
rpa_mm=radio_sph(vpara)*1000;
rsi_mm=radio_sph(vsili)*1000;

%Calculo de la velocidad limite de una esfera en caida libre usando la ley
%de stokes vlim =
%[(2/9)*g*(densidad.esfera-densidad.fluido)]/viscosidad.fluido}*Radio ^2   vlim(vscdinai, radio, rhoai, rhoeph)


vlimag=vlim(ai(2), rag, ai(1), ag(1)); 
vlimgl=vlim(ai(2), rgl, ai(1), gl(1));
vlimpa=vlim(ai(2), rpa, ai(1), pa(1));
cvlimsi=vlim(ai(2), rsi, ai(1), si(1));

%Calculo de la v(t) (velocidad e la gota) de una esfera en caida libre
%usando la ley de stokes v(t)= v.lim (1-exp(-k*t/m))  

%Cada aguja va ha generar una gota diferente
%Cada liquido va a generar una gota diferente en aguja
%Cuatro l�quidos X 8 agujas = 32


vagcele=vt(vlimag(4),rag(4),magua(4),ai(2));
vggcele=vt(vlimgl(4),rgl(4),mglice(4),ai(2));
ragcele=r(vlimag(4),rag(4),magua(4),ai(2));
rggcele=r(vlimgl(4),rgl(4),mglice(4),ai(2));


 [agWe, agRe] = ADfluid(ag(1), vagcele(:,2), 3.1537e-03 , ag(3) , ag(2));
 [glWe, glRe] = ADfluid(gl(1), vggcele(:,2), 2.7277e-03 , gl(3) , gl(2));


%% Velocidade de las gotas de agua
% vagrosa=vt(vlimag(1),rag(1),magua(1),ai(2));  % vagamar=vt(vlimag(2),rag(2),magua(2),ai(2));
% vaggris=vt(vlimag(3),rag(3),magua(3),ai(2));  % vagazul=vt(vlimag(5),rag(5),magua(5),ai(2));
% vagnara=vt(vlimag(6),rag(6),magua(6),ai(2));  % vaggpea=vt(vlimag(7),rag(7),magua(7),ai(2));
% % Velocidade de las gotas de glicerina
% vggrosa=vt(vlimgl(1),rgl(1),mglice(1),ai(2)); % vggamar=vt(vlimgl(2),rgl(2),mglice(2),ai(2));
% vgggris=vt(vlimgl(3),rgl(3),mglice(3),ai(2)); % vggazul=vt(vlimgl(5),rgl(5),mglice(5),ai(2));
% vggnara=vt(vlimgl(6),rgl(6),mglice(6),ai(2)); % vgggpea=vt(vlimgl(7),rgl(7),mglice(7),ai(2));
%% Altura de las gotas de agua
% ragrosa=r(vlimag(1),rag(1),magua(1),ai(2));   % ragamar=r(vlimag(2),rag(2),magua(2),ai(2));
% raggris=r(vlimag(3),rag(3),magua(3),ai(2));   % ragazul=r(vlimag(5),rag(5),magua(5),ai(2));
% ragnara=r(vlimag(6),rag(6),magua(6),ai(2));   % raggpea=r(vlimag(7),rag(7),magua(7),ai(2));
% % Altura de las gotas de glicerina
% rggrosa=r(vlimgl(1),rgl(1),mglice(1),ai(2));  % rggamar=r(vlimgl(2),rgl(2),mglice(2),ai(2));
% rgggris=r(vlimgl(3),rgl(3),mglice(3),ai(2));  % rggazul=r(vlimgl(5),rgl(5),mglice(5),ai(2));
% rggnara=r(vlimgl(6),rgl(6),mglice(6),ai(2));  % rgggpea=r(vlimgl(7),rgl(7),mglice(7),ai(2));


%%      Visualizar Velocidad
close all 
figure
subplot(2,2,1)
plot(ragcele(1:end,2),vagcele(1:end,2),rggcele(1:end,2),vggcele(1:end,2),'--')

% plot(vagrosa(1:end,1),vagrosa(1:end,2),'m.')  % plot(vagamar(1:end,1),vagamar(1:end,2),'y.')
% plot(vaggris(1:end,1),vaggris(1:end,2),'k.')  % plot(vagazul(1:end,1),vagazul(1:end,2),'b.')
% plot(vagnara(1:end,1),vagnara(1:end,2),'r.')  % plot(vaggpea(1:end,1),vaggpea(1:end,2),'g.')
%%
% plot(vggrosa(1:end,1),vagrosa(1:end,2),'m+')  % plot(vggamar(1:end,1),vagamar(1:end,2),'y+')
% plot(vgggris(1:end,1),vaggris(1:end,2),'k+')  % plot(vggazul(1:end,1),vagazul(1:end,2),'m.')
% plot(vggnara(1:end,1),vagnara(1:end,2),'r+')  % plot(vgggpea(1:end,1),vaggpea(1:end,2),'g+')

xlabel('Altura (cm)');            ylabel('Velocidad (m/s)'); 
                    title('Velocidad vs tiempo de caida')
                    legend('Agua','gicerina')  
                    %legend('Agua','gicerina','Amarilla','Gris','Azul','Naranja','Gris P.')  


%%      Visualizar atulra
subplot(2,2,3)
plot(ragcele(1:end,1),ragcele(1:end,2),rggcele(1:end,1),rggcele(1:end,2),'--')

%%
% plot(ragrosa(1:end,1),ragrosa(1:end,2),'m.')  % plot(ragamar(1:end,1),ragamar(1:end,2),'y.')
% plot(raggris(1:end,1),raggris(1:end,2),'k.')  % plot(ragazul(1:end,1),ragazul(1:end,2),'b.')
% plot(ragnara(1:end,1),ragnara(1:end,2),'r.')  % plot(raggpea(1:end,1),raggpea(1:end,2),'g.')
%%
% plot(rggrosa(1:end,1),rggrosa(1:end,2),'m+')  % plot(rggamar(1:end,1),rggamar(1:end,2),'y+')
% plot(rgggris(1:end,1),rgggris(1:end,2),'k+')  % plot(rggazul(1:end,1),rggazul(1:end,2),'b+')
% plot(rggnara(1:end,1),rggnara(1:end,2),'r+')  % plot(rgggpea(1:end,1),rgggpea(1:end,2),'g+')

xlabel('Tiempo (s)');            ylabel('Altura (cm) '); 
                    title('Altura de  caida vs el tiempo que tarda en llegar al piso')
                    legend('Agua','gicerina')  
%                     legend('Celeste','Rosa','Amarilla','Gris','Azul','Naranja','Gris P.')  
%%          Visualizar Reynolds y Weber

subplot(2,2,2)

    scatter(AgADI(:,2),AgADI(:,1),'bo')
    hold on
    scatter(glADI(:,2),glADI(:,1),'k+')
 
        xlabel('Weber');            ylabel('Altura'); 
        title('We vs Altura para una gota de 3.22 mm')
        legend('agua','glicerina')  

subplot(2,2,4)

    scatter(AgADI(:,3),AgADI(:,1),'bo')
    hold on
    scatter(glADI(:,3),glADI(:,1),'k+')

        xlabel('Reynolds');            ylabel('Altura'); 
        title('Re vs Altura para una gota de 3.22 mm')
        legend('agua','glicerina')  
