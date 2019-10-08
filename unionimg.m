function Imagen = unionimg(archivo,indice)

for img_ = indice(1,5):3:indice(1,6)
    
    ftg_ = rgb2gray(imread(archivo{img_}));
    [~ ,x] = size(ftg_);
    size_ = 1+(img_-indice(1,5))/3;
    Imagen(1:x,1+x*(size_-1):size_*x) = ftg_;

end

for img_ = indice(1,7):indice(1,11)
    size_ = size_ + 1;
    ftg_ = rgb2gray(imread(archivo{img_}));
    Imagen(1:x,1+x*(size_-1):size_*x) = ftg_;
end
 
end