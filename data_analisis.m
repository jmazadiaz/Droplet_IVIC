

for caso_ = 1:length(frag_size_)
    [end_indi_ end_column_] =size(frag_size_{caso_,3}.Area_Fragmentos);
    
    for indi_ = 1: end_indi_
        temp_std_(indi_,:) = std(frag_size_{caso_,3}.Area_Fragmentos(indi_,:));
        temp_mean_(indi_,:) = mean(frag_size_{caso_,3}.Area_Fragmentos(indi_,:));
    end

    clear indi 
    for indi_ = 1: end_indi_
        for column_ = 1:end_column_
        outliers(indi_,column_) = (frag_size_{caso_,3}.Area_Fragmentos(indi_,column_)...
                             - temp_mean_(indi_)) > 2*temp_std_(indi_);
%         fsize_NAN_(caso_,:) = frag_size_{caso_,3}.Area_Fragmentos;
        end
    end
    frag_size_{caso_,3}.Area_Fragmentos(outliers) = NaN;
clear outliers std_caso_ mean_caso_ indi_ temp_std_ temp_mean_
end