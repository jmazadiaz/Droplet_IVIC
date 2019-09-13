%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%       ab2v.mat
%   input
%       v1 =  Primer Vector
%       v2 =  Segundo Vector
%   output
%       m(1,2) = Magnitud de los vectores
%       a(1:2) = agulos del vector 1
%       a(3:4) = angulos del vetor 2
%       a(5)   = Angulo entre los dos vectores
%
%   Calcula el angulo de cada una de las cordenadas de dos vectores y el
%   angulo entre ambos vectores por medio del despeje del producto punto      
%                       a.b = |a|.|b| cos(th)
%   http://www.matrixlab-examples.com/angle-between-vectors.html
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [m, a] = ab2v(v1, v2, show)

% Magnitude of vector is its norm
m(1) = norm(v1);
m(2) = norm(v2); 

% Min. angles from vector 1 to axes
a(1 : 2) = acosd(v1 / m(1));
% Min. angles from vector 2 to axes
a(3 : 4) = acosd(v2 / m(2)); 

% Dot product dot(v1, v2) equals sum(v1 .* v2)
a(5) = acosd(dot(v1, v2) / m(1) / m(2)); 

if show == true
   disp(' ')
disp(['Angle between vectors: ' num2str(a(5))]) 

disp(' ')
disp('Vector 1')
disp(['Magnitude :' num2str(m(1))])
disp(['Min. angle with x-axis: ' num2str(a(1))])
disp(['Min. angle with y-axis: ' num2str(a(2))])
% disp(['Min. angle with z-axis: ' num2str(a(3))]) 

disp(' ')
disp('Vector 2')
disp(['Magnitude :' num2str(m(2))])
disp(['Min. angle with x-axis: ' num2str(a(3))])
disp(['Min. angle with y-axis: ' num2str(a(4))])
% disp(['Min. angle with z-axis: ' num2str(a(6))]) 
end

end