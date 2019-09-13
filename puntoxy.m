%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       puntoxy.mat
%   input
%       Partes =  Estructura proveniente de las medidas de los videos
%       video =  Indice del video en partes
%   output
%       p_xy = Estructura con angulos y magnitudes de lso centros 
%               (Trarget y gota)
%
%   Construlle una estructura que contiene toda la informacion
%   trigonometrica del centro de la gota y el target.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [p_xy] = puntoxy(Partes,video)

for ind_fotgram_ = 1:length(Partes{1, 2})
    
c_xy_ (ind_fotgram_,1) = Partes{video, 2}(ind_fotgram_).Centro_x ...
                        - Partes{video, 2}(ind_fotgram_).Des_x;
c_xy_ (ind_fotgram_,2) = Partes{video, 2}(ind_fotgram_).Centro_y ...
                       - Partes{video, 2}(ind_fotgram_).Des_y;
end
centro {1,1} = [mean(c_xy_,1)];

for ind_fotgram_ = 1:length(Partes{1, 2})
    
c_gota_{ind_fotgram_,1} =  [Partes{1, 2}(ind_fotgram_).Centro_x ...
                            Partes{1, 2}(ind_fotgram_).Centro_y];

[m , a] = ab2v(centro{1,1}, c_gota_{ind_fotgram_,1}, false);

p_xy(ind_fotgram_, 1:7) = {c_gota_{ind_fotgram_},m(2), [a(3:4)]...
                           ,centro{1,1},m(2), [a(1:2)],a(5)};

end

end