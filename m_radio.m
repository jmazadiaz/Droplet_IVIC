for lanzamiento_ = 1: length(Partes)

Num_frag_ = Partes{lanzamiento_,4}.Num_Objetos;

    for objeto_ = 1 :  Num_frag_;

      A_obj_(Num_frag_,objeto_) = regionprops(...
                                  Partes{lanzamiento_,4}.Objetos{...
                                  1,objeto_},'area');
        
        
    end


end