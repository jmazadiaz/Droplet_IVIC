%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Es una función para crear dos vectores con los indices de cuadrados        %
%  concentricos, desde el centro hasta el final, en una matriz cuadrada N X M %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 function indi_rad = i_radial(m_study)

    size_matriz = size(img);
    num_elementos = size_matriz(1)*size_matriz(2);

    H=[1:num_elementos]; %crea vector_indice i con NxM elementos vacio
    K=[1:num_elementos]; %Crea vencor_indice j Con NxM Elementos
    %%%%%
    n =1 ; i=n ; j=n;

    %m =1;
    

    i_ini = size_matriz(1)/2; H(1)=i_ini; 
    j_ini = size_matriz(2)/2; K(1)=j_ini; 
    
        for in = [2:num_elementos];

            if (mod(n,2)~=0 & i==0 & j~=0)      %imapar Copia
                    H(in) = H(in-1);
                    K(in) = K(in-1)+1;
                    j=j-1;
            end

            if  (mod(n,2)~=0 & i~=0)          %imapar suma
                    H(in) = H(in-1)+1;
                    K(in) = K(in-1);
                    i=i-1;
            end

            %%%%%%%    Pares   %%%%%%%    

            if (mod(n,2)== 0 & i==0 & j~=0)      %par Copia
                    H(in) = H(in-1);
                    K(in) = K(in-1)-1;
                    j=j-1;
            end

            if (mod(n,2)== 0 & i~=0)             %par resta
                    H(in) = H(in-1)-1;
                    K(in) = K(in-1);
                    i=i-1;
            end

            %%%%%%%    fin Ciclo   %%%%%%%

            if (i==0 & j==0)
                    n=n+1 ; i=n ; j=n;
            end

        end
%    clear;
   indi_rad=vertcat(H,K);
 end

 function y = average(x)
if ~isvector(x)
    error('Input must be a vector')
end
y = sum(x)/length(x); 
end 
 
% En sentido opuesto al reloj

% for(i=1:64)
% ni=indi_rad(1,i);
% nj=indi_rad(2,i);
% n=img(i);
% 
% m_study(ni,nj)=n;
% end

% En sentido del reloj

% for(i=1:64)
% ni=indi_rad(2,i);
% nj=indi_rad(1,i);
% n=img(i);
% 
% m_study(ni,nj)=n;
% end
