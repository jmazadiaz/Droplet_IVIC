function pp = px2part(bw)
    [i j]=size(bw);
    ttpx_ = i*j;
    hist_=imhist(bw);
    black_ = hist_(1);
    white_ = hist_(256);
    pb_ =  (black_ * 100)/ttpx_;
    pw_ =(white_ * 100)/ttpx_;
    pp = [pw_ pb_];
end