%%%%        No es necesaria para el FOR (aca quiero identificar automaticamente la
%%%%        gota)

   

%%%     Separa elementos con mas de 50 puntos
if c_cc_.NumObjects==1
    
    c_drop_ = object(c_bw_inva_,c_cc_.PixelIdxList{1});    

else

    c_c_ = vertcat(c_cc_.PixelIdxList);
    c_num_elem_(1:c_cc_.NumObjects) = 0; 
    
    for i_ = 1:c_cc_.NumObjects
        M = cell2mat(c_c_(i_));
        [tnum_elem_(i_),~] = size(M);
        if tnum_elem_(i_)>40
            c_num_elem_(i_) = tnum_elem_(i_);
        else
            c_num_elem_(i_) = 0;
        end
    end
        clear M tnum_elem_(i_) i_ c_c_;

        [c_n_e_,c_orden] = sort(c_num_elem_,'descend');
        c_sa2max = c_n_e_(1:c_cc_.NumObjects-1);
        c_sa2maxpos = c_orden(1:c_cc_.NumObjects-1);

        c_drop_ = object(c_bw_inva_,c_cc_.PixelIdxList{c_sa2maxpos(1)});

clear M tnum_elem_(i_) i_ c_c_;
end
    
%%%%%%%%%%%%%%         ordena decendentemente         %%%%%%%%%%%%%%  







% [c_cen_i_,c_cen_j_,c_des_,c_diameters_] = desplazamiento(c_drop_,centro_);
% 
% c_img_cI_ = i2(1:centre(2),centre(1):length(i));
% c_img_cII_ = i2(1:centre(2),1:centre(1));
% c_img_cIII_= i2(centre(2):length(i),1:centre(1));
% c_img_cIV_= i2(centre(2):length(i),centre(1):length(i));
% 
% %%%%%%%%%%%%%%%%%%%%%% SOLO PARA EL PRIMER VIDEO %%%%%%%%%%%%%
% % c_img_cI_ = i2(1:107,129:length(i));
% % c_img_cII_ = i2(1:107,1:129);
% % c_img_cIII_= i2(107:length(i),1:129);
% % c_img_cIV_= i2(107:length(i),129:length(i));
% % c_img_cI_II_ = i2(1:107,1:length(i));
% %c_img_cIII_IV= i(centro_(2):length(i),1:length(i));
% 
%     c_centroids_ = [cen_i,cen_j];
%     c_radio_ = floor(diameters_a/2);
% 
%     x=-:1:c_radio_;
%     y1=floor(c_centroids_(2))-sqrt((c_radio_.^2)-x.^2);
%     y2=floor(c_centroids_(2))+sqrt((c_radio_.^2)-x.^2);
%     x= c_centroids_(1)+x;
% 
