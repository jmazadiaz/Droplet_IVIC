%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%   Este escript extrae de todos los archivos de la carpeta partes (carpeta 
% que contiene los datos de todos los caso a estudiar) para hacer un
% promedio del numero de fragmento de cada lanzamiento en cada caso, 
% luego un promedio del tamaño de cada fragmento, y por ultimo el tamaño 
% de fragmento más abundante con su dispersión; todo se graficará con 
% respecto a la energía.    
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

folder_ = 'partes\'; 



file_partes_ = dir(strcat(folder_,'*.mat'));





for caso_ = 1:length(file_partes_)
    
    load(strcat(folder_,file_partes_(caso_).name));  % Abre el caso de estudio
    file_partes_(caso_).name(8:10);      % Nombre del caso
    
    for indi_ = 1: length(Partes)
       
        Num_de_objetos(indi_) = Partes{indi_,4}.Num_Objetos.';
        
        for objeto_ = 1: length(Partes{indi_,4}.Objetos); 
       
        ob_ = regionprops(Partes{indi_,4}.Objetos{1,objeto_},'area');
        ob_area(indi_,objeto_) = ob_.Area;
        
        end
        
        
    end
    
    Area_Fragmentos = sort(ob_area,2);
    
    table_ = table(Num_de_objetos',Area_Fragmentos);
    frag_size_(caso_,1:2) = {file_partes_(caso_).name(8:10), table_};

end


%%  Median y desviation


% for md_ = 1: length(frag_size_)
for md_ = 1: 4

    
    % Hasta aca calculo el promedio y la desviación Cambien el for a 4 para
    % pensar como voy a graficar la información.
    
    med_ (md_,2) = median(frag_size_{1,2}.Var1)
    std(frag_size_{1,2}.Var1)

    % Por otra parte tengo que revisar ParteD.m desde la linea 26 a la
    % 41  para entender por que hay un número fijo de fragmentos para cada
    % caso. En Partes_G48 hay caja vacias, no hace falta revisarlas si
    % vamos a correr parteD por el error que representa. Calcular la
    % energía
    
end
