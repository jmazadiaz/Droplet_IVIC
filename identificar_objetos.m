%%%%        Step 1: Read Image
num_= 122;
for cn=1:4 
cn2=cn+4;

%%      carpetas
if cn==1
    car='target\';
elseif cn==2
    car='comienzo\';
elseif cn==3
    car='final\';
elseif cn==4
    car='rota\';
else
    fprintf('-->error<--');
end

       
%%

folder=strcat('D:\Droplets Video\glicerina\48 cm\AVI\IMG\img-g48-1\IMG_mod\',car); %Recore el diretorio
ruta=strcat(folder,'*.jpg');%concatena el directorio con la extesion de los archivos
lee_archivos = dir(ruta);

 

file = lee_archivos(num_).name;

RGB = imread(strcat(folder,file)); %         Abre la imagen
  
subplot(2,4,cn2)
imshow(RGB);%                           Muestra la imagen

%%%%        Step 2: Threshold the Image

I = rgb2gray(RGB);
bw = im2bw(I, graythresh(I));%          binariza -> Global image threshold using Otsu's method
subplot(2,4,cn2)
imshow(bw);%                            Muestra

%%%%        Step 3: Remove the Noise

bw = bwareaopen(bw,1);%                Remueve todos los objetos que tienens menos de 30 Pixels
se = strel('disk',10,6);%                Crea un elemento morfologicamente estructurado (Disco, radio,N must be 0, 4, 6, or 8) 

bw = imclose(bw,se);%                   Imagen morfologicamente cerrada, se = The structuring element
bw = imfill(bw,'holes');%               llena los agujeros, suado para estimar el area encerrada por cada límite.

subplot(2,4,cn2)
% imshow(bw)%                             Muestra

%%%%        Step 4: Find the Boundaries


[B,L] = bwboundaries(bw,'noholes');%    Solo se concentra en el limite exterior 'noholes'= no busca los contornos internos. B son las coordenadas del contorno, L es la image BW

subplot(2,4,cn)
imshow(label2rgb(L, @jet, [.5 .5 .5]))% Muestra las matriz de etiquetas y pinta cada contorno

hold on%                                Agrega mas cosas a la imagen

for k = 1:length(B)
  boundary = B{k};
  subplot(2,4,cn)
  plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end

%%%%        Step 5: Determine which Objects are Round

stats = regionprops(L,'Area','Centroid');%Mide propiedades de las regiones de la imagen 'Centroid' devuelve la cooredenada x,y del centroide de la figura
threshold = 0.94;%                      Limite

for k = 1:length(B)%                    Ciclo para los contornos
  
  boundary = B{k};%                     Obtiene las coordenadas de los limites para el k elemento

  delta_sq = diff(boundary).^2;%        Calcula un estimado del perimetro del objeto
  perimeter = sum(sqrt(sum(delta_sq,2)));
  area = stats(k).Area;%                Obtiene el área calculada del k-esimo elemnto
  
  metric = 4*pi*area/perimeter^2;%      calcula la redodez del perimeto
  
  subplot(2,4,cn)
  metric_string = sprintf('%2.2f',metric);%Muestras los resultados

  
  if metric > threshold%                Marca un limite sobe el objeto con un circulo negor
    centroid = stats(k).Centroid;
    plot(centroid(1),centroid(2),'ko');
  end
  
  subplot(2,4,cn)
  text(boundary(1,2)-35,boundary(1,1)+13,metric_string,'Color','y',...
       'FontSize',14,'FontWeight','bold');
  
end

title(['Metrics closer to 1 indicate that ','the object is approximately round']);
% hold off
end