load sensorData

t1=(0:length(s1)-1)/Fs;
t2=(0:length(s2)-1)/Fs;

subplot(2,1,1)
plot(t1,s1)
title('S_1')
subplot(2,1,2)
plot(t2,s2)
title('s_2')
xlabel('Time (s)')
 
%%%% Cross Corelation
 
[acor,lag]=xcorr(s2,s1);

%%%%  Search the max absolute in xcorr

[~,I]=max(abs(acor));
lagDiff=lag(I)


%%%%% Calculo la diferencia
lagDiff =

  -350

timeDiff=lagDiff/Fs

timeDiff =

   -0.0317

%%%%%  Grafico la correlacion   
   
figure
plot(lag,acor)
a3=gca;
a3.XTick=sort([-3000:1000:3000 lagDiff]);

%%%%% Hago la señal con la correción de defase

s1al=s1(-lagDiff+1:end);
t1al=(0:lenght(s1al)-1)/Fs;
t1al=(0:length(s1al)-1)/Fs;

%%%%%%   Ploteo las dos imagenes acomodadas para que veas que estan
%%%%%%   alineadas.


subplot(2,1,1)
plot(t1al,s1al)
title('s_1, aligned')

subplot(2,1,2)
plot(t2,s2)
title('s_2')
xlabel('Time (s)')
