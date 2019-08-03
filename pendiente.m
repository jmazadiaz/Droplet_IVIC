% for video_ = 1:length(Partes)
   
    for medida_ = 1:length(Partes{1,2})-1
    
    pendiente(medida_) = (Partes{1, 2}(medida_+1).Tiempo_ -   Partes{1, 2}(medida_).Tiempo_)...
                        /(Partes{1, 2}(medida_+1).Desplazamiento - Partes{1, 2}(medida_).Desplazamiento)
        
   end
        
% end