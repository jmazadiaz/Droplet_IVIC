function temp_p = esquinas(i_Points)

tx_min=min(i_Points(:,1));
ty_min=min(i_Points(:,2));

tx_max=max(i_Points(:,1));
ty_max=max(i_Points(:,2));

tiF_P=single(i_Points);

j_ = 1;

    for i_ = 1:length(i_Points)

        if tiF_P(i_,2) == ty_max
           temp_p(j_,:)= [i_Points(i_,:) i_];
           j_=j_+1;

        elseif tiF_P(i_,1) == tx_max
           temp_p(j_,:)= [i_Points(i_,:) i_];
           j_=j_+1;

        elseif   tiF_P(i_,1) == tx_min
           temp_p(j_,:)= [i_Points(i_,:) i_];
           j_=j_+1;

        elseif tiF_P(i_,2) == ty_min
           temp_p(j_,:)= [i_Points(i_,:) i_];
           j_=j_+1;
        end

    end
    
clear i_ j_ tiF_P tx_min ty_min tx_max 

end