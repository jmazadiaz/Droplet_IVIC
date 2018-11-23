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
%   Agregar un for para no tener que hacer clines.m para cada octante
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

function [lines_all_]= desarco(drop,archivo,i,centro,vent, octantes)

    lines1_ = radial(drop,archivo,i,centro,vent,octantes(1));               % Para cada linesx_ copiamos el valor de los pixel de cada línea de Bresenham
    lines2_ = radial(drop,archivo,i,centro,vent,octantes(2));
    lines3_ = radial(drop,archivo,i,centro,vent,octantes(3));
    lines4_ = radial(drop,archivo,i,centro,vent,octantes(4));
    lines5_ = radial(drop,archivo,i,centro,vent,octantes(5));
    lines6_ = radial(drop,archivo,i,centro,vent,octantes(6));
    lines7_ = radial(drop,archivo,i,centro,vent,octantes(7));
    lines8_ = radial(drop,archivo,i,centro,vent,octantes(8));
    
    for line_ = 1:length(lines1_);
    lines_all_(1,line_) = struct('L1',[lines1_{line_,1},lines1_{line_,2},lines1_{line_,3}],...   % Hacemos una tabla con todas las lineas en cada instante de 3 imagenes sucesivas con el mismo punto.
                                 'P1',lines1_{line_,4},...
                                 'L2',[lines2_{line_,1},lines2_{line_,2},lines2_{line_,3}],...
                                 'P2',lines2_{line_,4},...
                                 'L3',[lines3_{line_,1},lines3_{line_,2},lines3_{line_,3}],...            
                                 'P3',lines3_{line_,4},...
                                 'L4',[lines4_{line_,1},lines4_{line_,2},lines4_{line_,3}],...
                                 'P4',lines4_{line_,4},...
                                 'L5',[lines5_{line_,1},lines5_{line_,2},lines5_{line_,3}],...
                                 'P5',lines5_{line_,4},...
                                 'L6',[lines6_{line_,1},lines6_{line_,2},lines6_{line_,3}],...
                                 'P6',lines6_{line_,4},...
                                 'L7',[lines7_{line_,1},lines7_{line_,2},lines7_{line_,3}],...
                                 'P7',lines7_{line_,4},...
                                 'L8',[lines8_{line_,1},lines8_{line_,2},lines8_{line_,3}],...
                                 'P8',lines8_{line_,4});
    end
    clear   lines1_ lines2_ lines3_ lines4_ lines5_ lines6_ ...
           lines7_ lines8_
       
end