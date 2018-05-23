%  PDtest.m
    
th_ = imhist(figi2_(target_));
h_ = imhist(figi2_);

h_indi_ = sumhasta(h_,2100);
hbw_ = h_indi_ -5;

ti_=1;
for i_ = 1:length(target_)
    if figi2_(target_(i_))<=h_indi_;
        ch_ind_(ti_) = target_(i_);
        ti_ = ti_ +1;
    end
end
% ch_ind_ = find(figi2_(target_) <= h_indi_);
 
figi2_(ch_ind_) = h_indi_ + 80;
 