function imagen = negativo(im)
 
imagen=imread(im);
[X,Y,Z]=size(imagen);
 
T(1) = max(max(imagen(:,:,1)));
T(2) = max(max(imagen(:,:,2)));
T(3) = max(max(imagen(:,:,3)));
 
for i=1:X
    for j=1:Y
        for k=1:Z
            imagen2(i,j,k) = T(k) - imagen(i,j,k);
        end
    end
end
 
figure(1),title('Figura Original'),imshow(imagen);
figure(2),title('Figura Imagen Negativa'),imshow(imagen2);
 
end