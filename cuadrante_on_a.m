%%%%        No es necesaria para el FOR (aca quiero identificar automaticamente la
%%%%        gota)

a_C_ = vertcat(a_cc_.PixelIdxList);
a_num_elem_(1:a_cc_.NumObjects) = 0; 

%%%     Separa elementos con mas de 50 puntos
for i_ = 1:a_cc_.NumObjects
    M = cell2mat(a_C_(i_));
    [tnum_elem_(i_),~] = size(M);
    if tnum_elem_(i_)>40
        a_num_elem_(i_) = tnum_elem_(i_);
    else
        a_num_elem_(i_) = 0;
    end
end
    clear M tnum_elem_(i_);
%%%%%%%%%%%%%%         ordena decendentemente         %%%%%%%%%%%%%%  

[a_n_e_,a_orden] = sort(a_num_elem_,'descend');
a_sa2max = a_n_e_(1:a_cc_.NumObjects-1);
a_sa2maxpos = a_orden(1:a_cc_.NumObjects-1);
