%Funcion para calcular el numero de reynold a partir de cada una de sus
%variables como velocidad de caida u, fiametro de la gota, y viscocidad
%dinámica
%el vector temporal. [r(t)=vlim*(t- (masa/k)*(1-exp(-k*t/m)))]

function re = re()

r(i_) = vlim *(t(i_)- (masa/k)*(1-(exp(-k*t(i_)/masa))));

end