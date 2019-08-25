%Funcion para calcular la velocidad de una gota a trav�s de una atm�sfera
%de gas, retorna vt calcula tiempo l�mite (tlim) a partir de la velocidad
%limite de caida (vlim), luego reconoce cual es el maximo de tiempo para
%generar el dominio temporal. Calculo K a partir del "radio"
%(k=6*pi*r*etha aire), luego calculo vt a partir de "masa de gota" (masa) y
%el vector temporal. [vt=vlim*(1-exp(-k*t/m))]

function [vt]=vt(vlim, radio, masa, vscai)

    tlim=vlim /9.7767538861216 +3;
     tmax=max(tlim)- (0.85* tlim);
    t=linspace(0.35,tmax,80);
    
    k=6*pi*vscai*radio/2;
    
    for i_ = 1:80     
    v(i_) = vlim *( (1-(exp(-k*t(i_)/masa))));
    end
    vt=[t;v]';
end