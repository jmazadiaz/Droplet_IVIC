load(fullfile(matlabroot,'examples','signal','Ring.mat'))% abró el Archivo y es el sonido de una moneda callendo en una superficie y fs la frecuencia de grabación.
Time = 0:1/Fs:(length(y)-1)/Fs;% Generta el tiempo de cada punto a partir de la frecuencia

m = min(y);%    Minimo 
M = max(y);%    Maximo

Full_sig = double(y);%  Pasa a de columna a fila en doble presicion

timeA = 7; %    Inicio del fragmento
timeB = 8;%     Final del Fragmento
snip = timeA*Fs:timeB*Fs;%  Recorte de tiempo

Fragment = Full_sig(snip); %    Framento del recorte de tiempo

% To hear, Type soundsc(Fragment,Fs)

subplot(2,3,1)
plot(Time,Full_sig,[timeA timeB;timeA timeB],[m m;M M],'r--') 
xlabel('Time (s)')
ylabel('Clean')
axis tight

subplot(2,3,2)
plot(snip/Fs,Fragment)
xlabel('Time (s)')
ylabel('Clean')
title('Fragment')
axis tight

[xCorr,lags] = xcorr(Full_sig,Fragment);% Compute an plot the cross-correlation of the full signal and the fragment


subplot(2,3,3)

plot(lags/Fs,xCorr)
grid
xlabel('Lags (s)')
ylabel('Clean')
axis tight

%       The lag at 

[~,I] = max(abs(xCorr));% naximo valor de(magnitud del valor absoluto y complejo de xCorr)
maxt = lags(I);% tiempo del maximo valor

Trial = NaN(size(Full_sig));%Todo lo que es cero se convierte en NaN. Devuelve la representación aritmetica para valores que son el resultado de operaciones que tienen resultados numéricos indefinidos.
Trial(maxt+1:maxt+length(Fragment)) = Fragment;% Copia el fragento en un trozo NaN.(Se ve en naranja en el plot)

subplot(2,3,4)
plot(Time,Full_sig,Time,Trial)
xlabel('Time (s)')
ylabel('Clean')
axis tight

NoiseAmp = 0.2*max(abs(Fragment));% se aplifica el ruido en un 20%

Fragment = Fragment+NoiseAmp*randn(size(Fragment));% Se sobreescribe el fuido y se hace aleatorio el valor de multiplicación.

Full_sig = Full_sig+NoiseAmp*randn(size(Full_sig));% Se Hace lo mismo en toda la señal.

% To hear, type soundsc(Fragment,Fs)

subplot(2,3,5)
plot(Time,Full_sig,[timeA timeB;timeA timeB],[m m;M M],'r--')
xlabel('Time (s)')
ylabel('Noisy')
axis tight

[xCorr,lags] = xcorr(Full_sig,Fragment);% Otra correlación cruzada para encontrar el fragmento en la imagen


subplot(2,3,6)
plot(lags/Fs,xCorr)
grid
xlabel('Lags (s)')
ylabel('Noisy')
axis tight

[~,I] = max(abs(xCorr));% naximo valor de(magnitud del valor absoluto y complejo de xCorr)
maxt = lags(I);% tiempo del maximo valor

Trial = NaN(size(Full_sig));%Todo lo que es cero se convierte en NaN. Devuelve la representación aritmetica para valores que son el resultado de operaciones que tienen resultados numéricos indefinidos.
Trial(maxt+1:maxt+length(Fragment)) = Fragment;% Copia el fragento en un trozo NaN.(Se ve en naranja en el plot)

figure
plot(Time,Full_sig,Time,Trial)
xlabel('Time (s)')
ylabel('Noisy')
axis tight
