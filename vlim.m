%Calcula la velocidad l�mite de una esfera de liquido callendo en un fluido
%laminar (aire) {vlim =
%[(2/9)*g*[(densidad.esfera-densidad.fluido)]*Radio ^2]/viscosidad.fluido}


function [y]=vlim(vscdinai, radio, rhoai, rhoeph)
    for i_ =1:length(radio)
%     y=(((2/9)*9.7767538861216*(rhoeph-rhoai))/(vscdinai)).*(radio.^2);
      y(i_)=(2.1726e05)*(rhoeph-rhoai).*(radio(i_).^2);
    end
end   

