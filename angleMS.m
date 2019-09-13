%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    angleMS.m
%   Input 
%       angulos = Lista de todos los angulos
%   Output
%       ang_prom = El angulo promedio
%       
%  Calcula el angulo promedio descartando los angulos que estan fuera de la
%  desviacion estandar.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ang_prom = angleMS (angulos)
med_angulos_ = median(angulos);
std_angulos_ = std(angulos);
lim_ang_ = med_angulos_ - std_angulos_;                                     % Calcula el limite superior para escoger cuales angulos estan desde la desviacion. 

amg_=angulos(angulos>=lim_ang_);                                            % Selecciona los angulos a los que se le va a calcular el promedio
 
ang_prom = mean(amg_);

end 