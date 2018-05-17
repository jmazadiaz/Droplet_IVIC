%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       desarco.m
%   Input
%       drop =  Objeto más grande en la imagen a analizar
%       archivo = Lista de direccion de las imagnes.
%       i = Indice de la imagen entre la lista a analizar.
%       centro = Punto del centro del target.
%       vent = Tamaño extra del radio del objeto mas grande
%       octantes = lista de octantes a estudiar
%   Output
%       d = Valor maximo entre los dos valores
%
% Esta función es una simplificación del código cuadrante, el objetivo es
% copiar las líneas entre el centro y un punto de todos los octante de
% circulo (es lo que hace radial) calcular el cambio de contraste en esta
% línea (el borde de la lámina) usando el operador diferencial aplicado con
% desplazamientor.m y copiar todo en d. Esto lo hace de la misma manera en
% la imagen i y las imagenes i+1 e i+2. cada octante está organizado :
%
%   [col 1]octante 1(i) ; [col 2]octante 1(i+1) ; [col 3]octante 1(i+2) ; 
%   [col 4]octante 2(i)...; [col 22]octante 8(i) ; [col 23]octante 8(i+1) ; 
%   [col 24]octante 8(i+2).
%
%   Agregar un for para no tener que hacer clines para cada octante
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
function d = desarco(drop,archivo,i,centro,vent, octantes)

    lines1_ = radial(drop,archivo,i,centro,vent,octantes(1));
    lines2_ = radial(drop,archivo,i,centro,vent,octantes(2));
    lines3_ = radial(drop,archivo,i,centro,vent,octantes(3));
    lines4_ = radial(drop,archivo,i,centro,vent,octantes(4));
    lines5_ = radial(drop,archivo,i,centro,vent,octantes(5));
    lines6_ = radial(drop,archivo,i,centro,vent,octantes(6));
    lines7_ = radial(drop,archivo,i,centro,vent,octantes(7));
    lines8_ = radial(drop,archivo,i,centro,vent,octantes(8));

    d(:,1:24) = [desplazamientor( lines1_) desplazamientor( lines2_)...
                 desplazamientor( lines3_) desplazamientor( lines4_)...
                 desplazamientor( lines5_) desplazamientor( lines6_)...
                 desplazamientor( lines7_) desplazamientor( lines8_)]; 

   clear   lines1_ lines2_ lines3_ lines4_ lines5_ lines6_ lines7_ lines8_
   
end