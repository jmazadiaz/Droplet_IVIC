%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%iver%%%%%%     
%
%   HPFideal.m                                                  
%   Imput
%       I = Imagen de entrada
%       sigma =  valor de difuminado (<45 da resultados malos)
%       show = true(muestra los pasos)
%   Output
%       Imagen filtrada con el filtro de paso bajo
%
%   filtro ideal de paso alto, es un filtro que funciona en el domino de
%   las frecuencias, donde las componetes de alta frecuencia de la
%   transformada de fourier de una imagén permanecen intactas mientras las
%   de baja frecuencia son alteradas, mejora todas las componenetes de
%   frecuencias dentro de un radio especifico del centro de arreglo de
%   frecuencias arrojada por la transformada de fourier de la imagen.
%
%  Practical Image and Video PROCESSING USING MATLAB by Oge Marques. p(296)
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function I11 = HPFideal(I,radius,show)

%I=rgb2gray(imread('D:\Droplets Video\agua\48\AVI\IMG\img-A48-1\f001.jpg'));
    ID = im2double(I);                                                          % se convierte en doble para poder ser transformado por la funcion fft2
    I_dft = fft2(ID);                                                           % Transformada rápida fe fourier del arreglo.
    [M, N] = size(I);                                                           % tamaño de la imagen para contruir el filtro.        
    dist = distmatrix(M, N);                                                    % Matrices de distacina para especificar e implementar el domino de frecuencia en el filtro. 
                                                                                % (distancia de cada pixel del centro de la imagen)
    H = ones(M, N);                                                             % Creamos la base del filtro, arreglo de zeros del tamaño de la imagen.
%   radius = 30;
    ind = dist <= radius;
    H(ind) = 0;
                                       
    DFT_filt_gau = H .* I_dft;                                                  % Operamos, cambian a cero todo lo que esta fuera del radio
    I11 = real(ifft2(DFT_filt_gau));                                             % Hacemos la tranasformada inversa para convertir la imagen del dom de frecuencia al Dom espacial

if show == true                                                                 % En caso de visaulizar el resultado
    
    figure, subplot(2,3,1), imshow(ID), title('Original Image');
    subplot(2,3,2), imshow(log(1 + abs(fftshift(I_dft))),[]), ...               % por tratarse de un domino de frecuencias, fftshift ordena los valores para poder
                    title('FT of original image');                                              % visaualizarlas en una escala (log) que arroje la información util
    subplot(2,3,3), mesh(log(1+abs(fftshift(dist)))), , ...
                   title(strcat('Dist mat,D0=',num2str(radius)));
    subplot(2,3,4), imshow(I11), title('Filtered Image');
    subplot(2,3,6), imshow(fftshift(H)), title('Ideal high-pass filter');
    subplot(2,3,5), imshow(log(1 + abs(fftshift(DFT_filt_gau))),[]), ...
                    title('FT of filtered image');    
    pause
end
end