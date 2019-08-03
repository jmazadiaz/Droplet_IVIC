%% Parte del código cuadrante_analiza_parteC.m--> Simplificar código.       Salida foto_  y  px_final_foto 
% Voy a trabajar solo con los primeros 5 octantes
foto_1_ (end:-1:1,k_)= ln1_max1_;                       
foto_1_ (end:-1:1,k_+Num_line_)= ln1_max2_;             
foto_1_ (end:-1:1,k_+Num_line_*2)= ln1_max3_;           
foto_1_ (end:-1:1,k_+Num_line_*3)= ln1_max4_;            
foto_1_ (end:-1:1,k_+Num_line_*4)= ln1_max5_;
% foto_1_ (end:-1:1,k_+Num_line_*5)= ln1_max6_;
% foto_1_ (end:-1:1,k_+Num_line_*6)= ln1_max7_;
% foto_1_ (end:-1:1,k_+Num_line_*7)= ln1_max8_;
                %%
foto_2_ (end:-1:1,k_)= ln2_max1_;
foto_2_ (end:-1:1,k_+Num_line_)= ln2_max2_;
foto_2_ (end:-1:1,k_+Num_line_*2)= ln2_max3_;
foto_2_ (end:-1:1,k_+Num_line_*3)= ln2_max4_;
foto_2_ (end:-1:1,k_+Num_line_*4)= ln2_max5_;
% foto_2_ (end:-1:1,k_+Num_line_*5)= ln2_max6_;
% foto_2_ (end:-1:1,k_+Num_line_*6)= ln2_max7_;
% foto_2_ (end:-1:1,k_+Num_line_*7)= ln2_max8_;
                %%
foto_3_ (end:-1:1,k_)= ln3_max1_;
foto_3_ (end:-1:1,k_+Num_line_)= ln3_max2_;
foto_3_ (end:-1:1,k_+Num_line_*2)= ln3_max3_;
foto_3_ (end:-1:1,k_+Num_line_*3)= ln3_max4_;
foto_3_ (end:-1:1,k_+Num_line_*4)= ln3_max5_;
% foto_3_ (end:-1:1,k_+Num_line_*5)= ln3_max6_;
% foto_3_ (end:-1:1,k_+Num_line_*6)= ln3_max7_;
% foto_3_ (end:-1:1,k_+Num_line_*7)= ln3_max8_;
                %%
% foto_{j_,1} = foto_1_ ; foto_{j_,2} = foto_2_ ; foto_{j_,3} = foto_3_;

px_final_foto_{1,k_}             = uint8(Partes{i_,3}(j_).Radios(k_).P1);
px_final_foto_{1,k_+Num_line_}   = uint8(Partes{i_,3}(j_).Radios(k_).P2);
px_final_foto_{1,k_+Num_line_*2} = uint8(Partes{i_,3}(j_).Radios(k_).P3);
px_final_foto_{1,k_+Num_line_*3} = uint8(Partes{i_,3}(j_).Radios(k_).P4);
px_final_foto_{1,k_+Num_line_*4} = uint8(Partes{i_,3}(j_).Radios(k_).P5);
% px_final_foto_{1,k_+Num_line_*5} = uint8(Partes{i_,3}(j_).Radios(k_).P6);
% px_final_foto_{1,k_+Num_line_*6} = uint8(Partes{i_,3}(j_).Radios(k_).P7);
% px_final_foto_{1,k_+Num_line_*7} = uint8(Partes{i_,3}(j_).Radios(k_).P8);

