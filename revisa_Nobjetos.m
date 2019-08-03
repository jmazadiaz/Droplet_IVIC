% Hacerlo recursivo para todos los casos y videos

folder_ = 'partes\'; 
file_partes_ = dir(strcat(folder_,'*.mat'));

for caso_ = 1:length(file_partes_)
    
    load(strcat(folder_,file_partes_(caso_).name)); 
    
    for i_ = 1 : length(Partes)

        if Partes{i_,4}.Num_Objetos ~= length(Partes{i_,4}.Objetos)
            Partes{i_,4}.Num_Objetos = length(Partes{i_,4}.Objetos);
        end
        
    end
    
     save(file_partes_(caso_).name(1:11),'Partes');
    
end