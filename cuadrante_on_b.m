%%%%        No es necesaria para el FOR (aca quiero identificar automaticamente la
%%%%        gota)

b_C_ = vertcat(b_cc_.PixelIdxList);
b_num_elem_(1:b_cc_.NumObjects) = 0; 

%%%     Separa elementos con mas de 50 puntos
for i_ = 1:b_cc_.NumObjects
    M = cell2mat(b_C_(i_));
    [tnum_elem_(i_),~] = size(M);
    if tnum_elem_(i_)>40
        b_num_elem_(i_) = tnum_elem_(i_);
    else
        b_num_elem_(i_) = 0;
    end
end
    clear M tnum_elem_(i_) i_;
%%%%%%%%%%%%%%         ordena decendentemente         %%%%%%%%%%%%%%  

[b_n_e_,b_orden] = sort(b_num_elem_,'descend');
b_sa2max = b_n_e_(1:b_cc_.NumObjects-1);
b_sa2maxpos = b_orden(1:b_cc_.NumObjects-1);

