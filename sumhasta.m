%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       sumhasta.m
%   Input
%       array = Arreglo que vamos a operar
%       valor =  Valor que vamos a alcanzar
%   output
%       s_ind = Indice hasta donde se alcanza el valor.     
%
% Suma los elementos de un vector hasta un cantidad ingresada 'valor' y
% devuelve el indice de este valor.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function s_ind =  sumhasta(array,valor)
        tsum_=0;
        s_ = floor(sum(array) * (valor/100));
    for i_ = 1:length(array)
        if tsum_ <= s_
            tsum_ = array(i_)+tsum_;
        elseif tsum_ > valor
            s_ind = i_;
            break
        end
end